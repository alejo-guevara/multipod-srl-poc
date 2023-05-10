#!/usr/bin/python
# Copyright by NOKIA
# Replace customer with your customer name

from srlinux.location import build_path
from srlinux.mgmt.cli.cli_plugin import CliPlugin
from srlinux.syntax import Syntax
import datetime
import subprocess

class Plugin(CliPlugin):
    def load(self, cli, **_kwargs):
        customer = cli.show_mode.add_command(Syntax('customer'))
        hello = customer.add_command(Syntax('hello', help='Show greetings'),
                update_location=False, callback=show_hello)
        sysinfo = customer.add_command(Syntax('sysinfo', help='Show System Information'),
                update_location=False, callback=show_sysinfo)

def show_sysinfo(state, output, arguments, **_kwargs):
    output.print("\n")
    output.print(str(subprocess.call('neofetch')))

def show_hello(state, output, arguments, **_kwargs):
    output.print('################################\n')
    output.print('# Welcome to the CUSTOMER PoC! #\n')
    output.print('################################\n')

