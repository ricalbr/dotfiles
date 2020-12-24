from subprocess import Popen, PIPE, run, DEVNULL
import os


def switcher(qtile):
    """
    Simple function to use rofi as an app swtcher for qtile.
    It requires an installation of rofi and the windows.rasi theme to be in
    the rofi directory.
    """

    # count number of opened window
    n_win = int(os.popen('wmctrl -l | wc -l').read())

    # excute the real rofi command!
    print(n_win)
    if n_win == 0:
        pass
    elif n_win == 1:
        run(["rofi", "-theme", "~/.config/rofi/themes/windows.rasi",
             "-width", "10", "-show", "window"], stdout=DEVNULL)

    elif n_win == 2:
        run(["rofi", "-theme", "~/.config/rofi/themes/windows.rasi",
             "-width", "22", "-show", "window"], stdout=DEVNULL)

    elif n_win == 3:
        run(["rofi", "-theme", "~/.config/rofi/themes/windows.rasi",
             "-width", "33", "-show", "window"], stdout=DEVNULL)

    else:
        run(["rofi", "-theme", "~/.config/rofi/themes/windows.rasi",
             "-width", "43", "-show", "window"], stdout=DEVNULL)
