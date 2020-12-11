# QTile config file
# @ricalbr

from typing import List  # noqa: F401

import os
import socket
import subprocess
# from subprocess import call, check_output

from libqtile import bar, layout, widget, extension
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile import hook

# TODO:
# * add audio notification with dunst
# * add redshift toggle button


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])


@hook.subscribe.startup
def dbus_register():
    # this part is for starting Qtile in a GNOME Session. Additional config files
    # are necessary, follow (http://docs.qtile.org/en/latest/manual/config/gnome.html)

    id = os.environ.get('DESKTOP_AUTOSTART_ID')
    if not id:
        return
    subprocess.Popen(['dbus-send',
                      '--session',
                      '--print-reply',
                      '--dest=org.gnome.SessionManager',
                      '/org/gnome/SessionManager',
                      'org.gnome.SessionManager.RegisterClient',
                      'string:qtile',
                      'string:' + id])


class Commands:
    alsamixer = ' -e alsamixer'
    # volume_up = 'amixer -q -c 0 sset Master 2dB+'
    # volume_down = 'amixer -q -c 0 sset Master 2dB-'
    # volume_toggle = 'amixer -q set Master toggle'
    volume_up = 'volume u'
    volume_down = 'volume d'
    volume_toggle = 'volume m'
    # mic_toggle = 'amixer -q set Dmic0 toggle'
    screenshot_all = 'sscrot'
    screenshot_window = 'sscrot u'
    screenshot_selection = 'sscrot s'


commands = Commands()

prompt_cmd = "{0}@{1}".format(os.environ["USER"], socket.gethostname())

# key macros
ALT = 'mod1'
WIN = 'mod4'
TAB = 'Tab'
CTRL = 'control'
SHIFT = 'shift'
RETURN = 'Return'
SPACE = 'space'
PRINT = 'Print'
MODKEY = ALT

# terminal = 'alacritty'     # DEFAULT TERMINAL
terminal = 'kitty'          # DEFAULT TERMINAL

keys = [

    # WINDOW MANAGEMENT ############

    Key([MODKEY, CTRL], "r", lazy.restart(), desc="Restart qtile"),
    Key([MODKEY, CTRL], "q", lazy.shutdown(), desc="Shutdown qtile"),

    # Move focus
    Key([MODKEY], "h", lazy.layout.left()),
    Key([MODKEY], "l", lazy.layout.right()),
    Key([MODKEY], "j", lazy.layout.down()),
    Key([MODKEY], "k", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([MODKEY, SHIFT], "h", lazy.layout.swap_left()),
    Key([MODKEY, SHIFT], "l", lazy.layout.swap_right()),
    Key([MODKEY, SHIFT], "j", lazy.layout.shuffle_down()),
    Key([MODKEY, SHIFT], "k", lazy.layout.shuffle_up()),
    Key([MODKEY], 'i', lazy.layout.swap_main()),

    # Toggle floating / fullscreen
    Key([MODKEY], "t", lazy.window.toggle_floating(),
        desc="Toggle floating window"),
    Key([MODKEY, SHIFT], "f", lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen"),

    # Toggle between different layouts
    Key([MODKEY], "Tab", lazy.next_layout(), desc="Toggle between layouts"),


    # GAPS and RESIZING ############

    Key([MODKEY, CTRL], "k", lazy.layout.grow()),
    Key([MODKEY, CTRL], "j", lazy.layout.shrink()),
    Key([MODKEY, SHIFT], 'n', lazy.layout.reset()),
    Key([MODKEY], "m", lazy.layout.maximize()),
    Key([MODKEY], "o", lazy.layout.flip()),

    # LAUNCHERS AND PROGRAMS #######

    Key([MODKEY], "space", lazy.spawn('rofi -show drun'),
        desc="Rofi application launcher"),
    Key([MODKEY], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([MODKEY], "w", lazy.spawn('brave'), desc="Launch browser"),
    Key([MODKEY], "e", lazy.spawn(terminal + " -e mutt"),
        desc="Launch email-client"),
    Key([MODKEY], "f", lazy.spawn('nautilus'),
        desc="Launch graphical filemanager"),
    Key([MODKEY, SHIFT], "f", lazy.spawn(terminal + " -e ranger"),
        desc="Launch filemanager in terminal"),

    # Volume control
    Key([], "F10", lazy.spawn(Commands.volume_toggle),
        desc='Mute volume'),
    Key([], "F11", lazy.spawn(Commands.volume_down),
        desc='Turn down volume'),
    Key([], "F12", lazy.spawn(Commands.volume_up),
        desc='Turn up volume'),

    # Screenshot
    Key([], "Print", lazy.spawn(Commands.screenshot_selection),
        desc='scrot selection'),
    Key([SHIFT], "Print", lazy.spawn(Commands.screenshot_all),
        desc='scrot fullscreen'),
    Key([CTRL], "Print", lazy.spawn(Commands.screenshot_window),
        desc='scrot focused window'),

    # Kill and Restart
    Key([MODKEY], "r", lazy.spawncmd(prompt=prompt_cmd),
        desc="Spawn a command using a prompt widget"),
    Key([MODKEY], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([MODKEY, SHIFT], "q", lazy.run_extension(extension.CommandSet(
        commands={
            'poweroff': 'systemctl poweroff',
            'restart': 'reboot',
            'logout': 'qtile-cmd -o cmd -f shutdown',
            'reload': 'qtile-cmd -o cmd -f restart',
        },
        foreground='#863034',
        selected_background='#863034',
        font='Iosevka Heavy',
        fontsize=11,)),
        desc='dmenu session manager'),
]

# Mouse bindings
mouse = [
    Drag([MODKEY], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([MODKEY], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([MODKEY], "Button2", lazy.window.bring_to_front())
]


# Groups
groups = [
    Group('1'),
    Group('2'),
    Group('3'),
    Group('4'),
    Group('5'),
    Group('6'),
    Group('7'),
    Group('8'),
    Group('9'),
]

for i in groups:
    keys.append(Key([MODKEY], i.name, lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name)))
    keys.append(Key([MODKEY, SHIFT], i.name,
                    lazy.window.togroup(i.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(i.name)))

layouts = [
    layout.MonadTall(
        margin=10,
        border_focus='#303030',
        ratio=0.55,
        max_ratio=0.75,
        min_ratio=0.35,
        name='m'
        # name='\u25a3'
    ),
    layout.Max(
        name='M'
        # name='\u25a1',
    ),
    layout.Floating(
        auto_float_types='dialog',
        border_width=0,
        max_border_width=0,
        fullscreen_border_width=0,
        border_focus='#303030',
        border_normal='#101010',
        name='f',
    ),
]

widget_defaults = dict(
    font='Iosevka Heavy',
    fontsize=15,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                    linewidth=0,
                    padding=10,
                ),
                widget.Prompt(),
                widget.Spacer(),
                widget.GroupBox(
                    font='Iosevka Heavy',
                    active='#AF9595',
                    inactive='#262626',
                    borderwidth=0,
                    hide_unused=False,
                    highlight_method='text',
                    invert_mouse_wheel=True,
                    this_current_screen_border='#ffffff',
                ),
                widget.CurrentLayout(),
                widget.Spacer(),
                # widget.TextBox(
                #     text='',
                #     fontsize=13,
                #     mouse_callbacks={
                #         'Button1': lambda qtile: qtile.cmd_spawn(terminal +
                #                                                  commands.alsamixer),
                #     },
                # ),
                # widget.Volume(),
                widget.Systray(
                    icon_size=13,
                    padding=7,
                ),
                widget.Sep(
                    linewidth=0,
                    padding=10,
                ),
                widget.Clock(
                    format='%a, %d/%m %H:%M',
                    font='Iosevka Bold',
                ),
                widget.Sep(
                    linewidth=0,
                    padding=10,
                ),
            ],
            30,
        ),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'Matplotlib'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wname': 'pinentry-gtk-2'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    {'role': 'about'},
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
