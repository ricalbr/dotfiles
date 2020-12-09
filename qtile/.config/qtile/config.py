# QTile config file
# @ricalbr

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os
import subprocess
from libqtile import hook


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


mod = "mod1"                # MODIFIER = ALT
# terminal = 'alacritty'     # DEFAULT TERMINAL
terminal = 'kitty'          # DEFAULT TERMINAL

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.up(), desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "control"], "j", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.spawn('rofi -show drun'),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

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
        border_focus='#505050',
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
                    padding=8,
                ),
                widget.Clock(format='%a %d/%m, %H:%M'),
                widget.Sep(
                    linewidth=0,
                    padding=8,
                ),
                widget.Prompt(),
                widget.Spacer(),
                widget.GroupBox(
                    font='Iosevka Heavy',
                    active='AF9595',
                    borderwidth=0,
                    hide_unused=False,
                    highlight_method='text',
                    invert_mouse_wheel=True,
                    this_current_screen_border='ffffff',
                ),
                widget.CurrentLayout(),
                widget.Spacer(),
                widget.TextBox(
                    text='',
                    fontsize=13,
                ),
                widget.Volume(),
                widget.Systray(
                    icon_size=13,
                ),
                widget.QuickExit(
                    font='Iosevka Light',
                    default_text='',
                    fontsize=13,
                    countdown_format='[{}]',
                    padding=None,
                    countdown_start=3,
                ),
                widget.Sep(
                    linewidth=0,
                    padding=6,
                ),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
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
