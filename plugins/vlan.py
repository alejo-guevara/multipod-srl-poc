###########################################################################
# Description: CLI plugin for the command 'show vlan'
###########################################################################

from srlinux.mgmt.cli import CliPlugin
from srlinux.syntax import Syntax
from srlinux.schema import FixedSchemaRoot
from srlinux.location import build_path
from srlinux.mgmt.cli import KeyCompleter
from srlinux import strings
from srlinux.data import ColumnFormatter, TagValueFormatter, TagValueWithKeyLineFormatter, Formatter
from srlinux.data import Border, Borders, Data, Indent, Header, Whiteline, Footer, Alignment
from srlinux.syntax.value_checkers import IntegerValueInRangeChecker
from srlinux.data.utilities import Percentage
import json

class Plugin(CliPlugin):
    '''
        Load() method: load new CLI command at CLI startup
        In: cli, the root node of the CLI command hierachy
    '''
    def load(self, cli, **_kwargs):
        ## print("\n---> LAB4 : THIS IS A TEMP PRINT TO VERIFY THAT VLAN.PY IS FOUND")
        print("\n\n ### This SRL contains the 'show vlan' command ###\n\n")
        ## add your code here
        syntax = Syntax('vlan', help='display all configured vlan(s)')
        syntax.add_unnamed_argument(
                'interface',
                default='*',
                #suggestions=KeyCompleter(path='/interface[name=*]'),
                help='interface name')
        syntax.add_named_argument(
                'vlan-id',
                help='look-up this vlan ID only',
                #value_checker=IntegerValueInRangeChecker(1, 4095),
                default='*')
        syntax.add_named_argument(
                'network-instance',
                help='network instance name',
                #value_checker=CheckInstanceName(),
                #suggestions=KeyCompleter(path='/network-instance[name=*]'),
                default='default')
        syntax.add_named_argument(
                'interface-type',
                default='*',
                #choices=['*'] + list(self.__interface_types),
                help='interface type')
        syntax.add_boolean_argument(
                'show-ip-address',
                help='display primary IP addresses')

        print("Loading CLI:", syntax) ## temporary display

        cli.show_mode.add_command(
                syntax,
                update_location=False,
                callback=self._print,
                schema=self._my_schema()
        )
    '''
        _my_schema() method: contruct schema for this CLI command
        Return: schema object
    '''

    def _my_schema(self):
        root = FixedSchemaRoot()

        interface = root.add_child(
               'interface',
                key='name',
                fields=['description', 'vlan-tagging'])

        subint = interface.add_child(
                'subinterface',
                key='name',
                fields=['vlan-id', 'ipv4-address', 'ipv6-address'])

        return root
    '''
        _fetch_state() method: extract relevant data from the state datastore
        In: state, reference to the datastores
        In: arguments, the CLI command's context
        Return: copy of a section of the state datastore
    '''
    def _fetch_state(self, state, arguments):
        pass ## replace pass with your code
    '''
        _populate_schema() method: fill in schema from state datastore
        In: state_datastore, state datastore extract
        In: arguments, the CLI commands context
        Return: filled-in schema
    '''
    def _populate_schema(self, state_datastore, arguments):
        pass ## replace pass with your code
    '''
        _set_formatters() method
        In: schema, schema to augment with formatters
    '''
    def _set_formatters(self, schema):
        pass ## replace pass with your code
    '''
        _print() method: the callback function
        In: state, reference to the datastores
        In: arguments, the CLI command's context
        In: output: the CLI output object
    '''
    def _print(self, state, arguments, output, **_kwargs):
        #state_datastore = self._fetch_state(state, arguments)
        #schema = self._populate_schema(state_datastore, arguments)
        #self._set_formatters(schema)
        #output.print_data(schema)
        pass # remove pass once the methods above are implemented



