# install python-rofi with the following commands
#
# git clone https://github.com/bcbnz/python-rofi && cd python-rofi
# sudo python setup.py install

import subprocess
import getpass
from libqtile.command_client import Client
from rofi import Rofi


def powermenu(qtile):
    """
    Simple function to use rofi as a powermenu for qtile.
    It requires an installation of rofi and the powermenu.rasi theme to be in
    the rofi directory.
    """

    shutdown = ""
    reboot = ""
    lock = ""
    suspend = ""
    logout = ""
    options = [shutdown, logout, reboot]

    r = Rofi(rofi_args=['-theme', '~/.config/rofi/powermenu/powermenu.rasi'])
    index, key = r.select('', options)

    if index == 0:
        # poweroff
        subprocess.Popen(['systemctl', 'poweroff'])

    elif index == 1:
        # logout
        try:
            client = Client()
            client.shutdown()
        except:
            subprocess.Popen(["loginctl", "terminate-user", getpass.getuser()])

    elif index == 2:
        # reboot
        subprocess.Popen(['systemctl', 'reboot'])

    else:
        pass
