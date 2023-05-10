from srlinux.data import TagValueFormatter, Border, Data
from srlinux.location import build_path
from srlinux.mgmt.cli import CliPlugin
from srlinux.mgmt.server.server_error import ServerError
from srlinux.schema import FixedSchemaRoot
from srlinux.syntax import Syntax


class Plugin(CliPlugin):

    '''
      Adds 'show version' command.

      Example output:

      Hostname          : DUT4
      Chassis Type      : 7250 IXR-10
      Part Number       : Sim Part No.
      Serial Number     : Sim Serial No.
      System MAC Address: 00:01:04:FF:00:00
      Software Version  : v0.0.0-12388-g1815c7e
      Architecture      : x86_64
      Last Booted       : 2019-09-12T17:34:42.865Z
      Total Memory      : 49292336 kB
      Free Memory       : 8780776 kB
    '''

    def load(self, cli, **_kwargs):
        cli.show_mode.add_command(
                Syntax('informacion', help='Muestra la informacion del equipo'), update_location=False, callback=self._print,
            schema=self._get_schema())

    def _print(self, state, output, arguments, **_kwargs):
        self._fetch_state(state)
        result = self._populate_data(state, arguments)
        self._set_formatters(result)
        output.print_data(result)

    def _get_schema(self):
        root = FixedSchemaRoot()
        root.add_child(
            'basic system info',
            fields=[
                'Hostname',
                'Chassis Type',
                'Part Number',
                'Serial Number',
                'System HW MAC Address',
                'Software Version',
                'Build Number',
                'Architecture',
                'Last Booted',
                'Total Memory',
                'Free Memory']
        )
        return root

    def _fetch_state(self, state):
        hostname_path = build_path('/system/name/host-name:')
        chassis_path = build_path('/platform/chassis')
        software_version_path = build_path('/system/app-management/application[name="idb_server"]')
        control_path = build_path('/platform/control[slot="*"]')

        try:
            self._hostname_data = state.server_data_store.get_data(hostname_path, recursive=True)
        except ServerError:
            self._hostname_data = None

        try:
            self._chassis_data = state.server_data_store.get_data(chassis_path, recursive=True)
        except ServerError:
            self._chassis_data = None

        try:
            self._software_version = state.server_data_store.get_data(software_version_path, recursive=True)
        except ServerError:
            self._software_version = None

        try:
            self._control_data = state.server_data_store.get_data(control_path, recursive=True)
        except ServerError:
            self._control_data = None

    def _populate_data(self, state, arguments):
        result = Data(arguments.schema)
        data = result.basic_system_info.create()

        data.hostname = '<Unknown>'
        if self._hostname_data:
            data.hostname = self._hostname_data.system.get().name.get().host_name or data.hostname

        data.chassis_type = '<Unknown>'
        data.part_number = '<Unknown>'
        data.serial_number = '<Unknown>'
        data.system_hw_mac_address = '<Unknown>'
        data.last_booted = '<Unknown>'
        if self._chassis_data:
            data.chassis_type = self._chassis_data.platform.get().chassis.get().type or data.chassis_type
            data.part_number = self._chassis_data.platform.get().chassis.get().part_number or data.part_number
            data.serial_number = self._chassis_data.platform.get().chassis.get().serial_number or data.serial_number
            data.system_hw_mac_address = self._chassis_data.platform.get().chassis.get().hw_mac_address \
                or data.system_hw_mac_address
            data.last_booted = self._chassis_data.platform.get().chassis.get().last_booted or data.last_booted

        data.software_version = '<None>'
        data.build_number = '<None>'
        if self._software_version:
            if self._software_version.system.get().app_management.get().application.exists('idb_server'):
                sw_version = self._software_version.system.get().app_management.get().application.get('idb_server').version
                if len(sw_version.strip()):
                    sw_version_strings = sw_version.split('-')
                    data.software_version = sw_version_strings[0]
                    if len(sw_version_strings) > 1:
                        data.build_number = '-'.join(sw_version_strings[1:])

        data.architecture = '<Unknown>'
        data.total_memory = '<Unknown>'
        data.free_memory = '<Unknown>'
        if self._control_data:
            for control_slot in ['A', 'B']:
                if self._control_data.platform.get().control.exists(control_slot):
                    ctrl_data = self._control_data.platform.get().control.get(control_slot)
                    if state.system_features.chassis and not ctrl_data.role == 'active':
                        continue
                    if 'cpu' in ctrl_data.child_names:
                        if ctrl_data.cpu.exists('all'):
                            data.architecture = ctrl_data.cpu.get('all').architecture
                    if 'memory' in ctrl_data.child_names:
                        total_mem_value = ctrl_data.memory.get().physical
                        free_mem_value = ctrl_data.memory.get().free
                        if total_mem_value:
                            data.total_memory = (str(total_mem_value // 1024)) + ' kB'
                        if free_mem_value:
                            data.free_memory = (str(free_mem_value // 1024)) + ' kB'
        return result

    def _set_formatters(self, data):
        data.set_formatter('/basic system info', Border(TagValueFormatter(), Border.Above | Border.Below))
