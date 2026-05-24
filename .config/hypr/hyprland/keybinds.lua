-- hl.bind("SUPER + Super_L", hl.dsp.global("quickshell:searchToggleRelease"), { ignore_mods = true })
-- hl.bind("SUPER + Super_R", hl.dsp.global("quickshell:searchToggleRelease"), { ignore_mods = true })
--

function workspace_in_group(i)
    local curr = hl.get_active_workspace().id
    local newVal = math.floor((curr - 1) / 10) * 10 + i
    -- hl.notification.create({ text = "curr " .. curr .. " floor " .. math.floor(curr / 10) .. " new " .. newVal, duration = 5000 })
    return newVal
end

local qsIpcCall = "qs -c $qsConfig ipc call"
local qsIsAlive = qsIpcCall .. " TEST_ALIVE"

hl.bind("SUPER + SUPER_L", hl.dsp.global("quickshell:searchToggleRelease"), { description = "Shell: Toggle search" })
hl.bind("SUPER + SUPER_R", hl.dsp.global("quickshell:searchToggleRelease"))
hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd(qsIsAlive .. " || pkill fuzzel || fuzzel"))
hl.bind("SUPER + SUPER_R", hl.dsp.exec_cmd(qsIsAlive .. " || pkill fuzzel || fuzzel"))

hl.bind("SUPER_L", hl.dsp.global("quickshell:workspaceNumber"), { ignore_mods = true, transparent = true })
hl.bind("SUPER_R", hl.dsp.global("quickshell:workspaceNumber"), { ignore_mods = true, transparent = true })
hl.bind("SUPER_L", hl.dsp.global("quickshell:workspaceNumber"),
    { ignore_mods = true, transparent = true, release = true })
hl.bind("SUPER_R", hl.dsp.global("quickshell:workspaceNumber"),
    { ignore_mods = true, transparent = true, release = true })

--hl.bind("SUPER + catchall", hl.dsp.global("quickshell:searchToggleReleaseInterrupt"), { ignore_mods = true, transparent = true, non_consuming = true })
hl.bind("CTRL + Super_L", hl.dsp.global("quickshell:searchToggleReleaseInterrupt"))
hl.bind("CTRL + Super_R", hl.dsp.global("quickshell:searchToggleReleaseInterrupt"))

hl.bind("Super_L", hl.dsp.global("quickshell:workspaceNumber"), { ignore_mods = true, transparent = true })
hl.bind("Super_R", hl.dsp.global("quickshell:workspaceNumber"), { ignore_mods = true, transparent = true })
hl.bind("SUPER + Tab", hl.dsp.global("quickshell:overviewWorkspacesToggle"), { description = "Toggle overview" })
hl.bind("SUPER + V", hl.dsp.global("quickshell:overviewClipboardToggle"), { description = "Clipboard history >> clipboard" })
hl.bind("SUPER + Period", hl.dsp.global("quickshell:overviewEmojiToggle"), { description = "Emoji >> clipboard" })
hl.bind("SUPER + N", hl.dsp.global("quickshell:sidebarRightToggle"), { description = "Toggle right sidebar" })
hl.bind("SUPER + G", hl.dsp.global("quickshell:overlayToggle"), { description = "Toggle overlay" })
hl.bind("CTRL + ALT + Delete", hl.dsp.global("quickshell:sessionToggle"), { description = "Toggle session menu" })
hl.bind("SUPER + J", hl.dsp.global("quickshell:barToggle"), { description = "Toggle bar" })

-- Fallback-Session-Menü
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("qs -c $qsConfig ipc call TEST_ALIVE || pkill wlogout || wlogout -p layer-shell"))

-- Bildschirmhelligkeit und Lautstärke (locked + repeating)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("qs -c $qsConfig ipc call brightness increment || brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("qs -c $qsConfig ipc call brightness decrement || brightnessctl s 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"), { locked = true, repeating = true })


-- Audio Stummschalten (locked)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true })

-- Hintergrundbild-Auswahl & Widgets-Neustart
hl.bind("CTRL + SUPER + T", hl.dsp.global("quickshell:wallpaperSelectorToggle"), { description = "Toggle wallpaper selector" })
hl.bind("CTRL + SUPER + R", hl.dsp.exec_cmd("killall ags agsv1 gjs ydotool qs quickshell; qs -c $qsConfig &"), { description = "Restart widgets" })


--------------------------------------------------------------------------------
--! Utilities
--------------------------------------------------------------------------------

-- Clipboard- & Emoji-Fallbacks
hl.bind("SUPER + V", hl.dsp.exec_cmd("qs -c $qsConfig ipc call TEST_ALIVE || pkill fuzzel || cliphist list | fuzzel --match-mode fzf --dmenu | cliphist decode | wl-copy"), { description = "Copy clipboard history entry" })
hl.bind("SUPER + Period", hl.dsp.exec_cmd("qs -c $qsConfig ipc call TEST_ALIVE || pkill fuzzel || ~/.config/hypr/hyprland/scripts/fuzzel-emoji.sh copy"), { description = "Copy an emoji" })

-- Screenshots / OCR
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("grimblast -f copysave area"))
hl.bind("SUPER + SHIFT + X", hl.dsp.global("quickshell:regionOcr"), { description = "Character recognition >> clipboard" })
hl.bind("SUPER + SHIFT + T", hl.dsp.global("quickshell:regionOcr"))

hl.bind("SUPER + SHIFT + X", hl.dsp.exec_cmd([[qs -c $qsConfig ipc call TEST_ALIVE || pidof slurp || grim -g "$(slurp $SLURP_ARGS)" "/tmp/ocr_image.png" && tesseract "/tmp/ocr_image.png" stdout -l $(tesseract --list-langs | awk 'NR>1{print $1}' | tr '\n' '+' | sed 's/\+$/\n/') | wl-copy && rm "/tmp/ocr_image.png"]]))
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd([[qs -c $qsConfig ipc call TEST_ALIVE || pidof slurp || grim -g "$(slurp $SLURP_ARGS)" "/tmp/ocr_image.png" && tesseract "/tmp/ocr_image.png" stdout -l $(tesseract --list-langs | awk 'NR>1{print $1}' | tr '\n' '+' | sed 's/\+$/\n/') | wl-copy && rm "/tmp/ocr_image.png"]]))

-- Color picker
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Color picker" })

-- Fullscreen Screenshots (locked / non_consuming)
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"), { locked = true })
hl.bind("CTRL + Print", hl.dsp.exec_cmd([[mkdir -p $(xdg-user-dir PICTURES)/Screenshots && grim $(xdg-user-dir PICTURES)/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png]]), { locked = true, non_consuming = true })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grim - | wl-copy"), { locked = true, non_consuming = true })


--------------------------------------------------------------------------------
--! Window
--------------------------------------------------------------------------------

-- Maus-Aktionen (Fenster bewegen/Größe ändern)
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:274", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Fokus wechseln (Pfeiltasten / Vim-Keys / Brackets)
local directions = { Left = "left", Right = "right", Up = "up", Down = "down", H = "left", L = "right", K = "up", J = "down" }
for key, dir in pairs(directions) do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }))
end
hl.bind("SUPER + BracketLeft", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + BracketRight", hl.dsp.focus({ direction = "right" }))

-- Fenster verschieben
for key, dir in pairs(directions) do
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Schließen & Force Quit
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close" })
hl.bind("SUPER + SHIFT + ALT + Q", hl.dsp.exec_cmd("hyprctl kill"), { description = "Forcefully zap a window" })

-- Layout-Zustände (Floating / Fullscreen)
hl.bind("SUPER + Space", hl.dsp.window.float({ action = "toggle" }), { description = "Float/Tile" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Fullscreen" })
hl.bind("SUPER + ALT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 3, action = "set" }), { description = "Fullscreen spoof" })

for i = 1, 10 do
    hl.bind("SUPER + " .. (i % 10), function()
        hl.dispatch(hl.dsp.focus({ workspace = workspace_in_group(i) }))
    end, { description = "Workspace: Focus " .. i })
end

for i = 1, 10 do
    local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
    hl.bind("SUPER + code:" .. numberkey[i], function()
        hl.dispatch(hl.dsp.focus({ workspace = workspace_in_group(i) }))
    end)
end

for i = 1, 10 do
    hl.bind("SUPER + SHIFT + " .. (i % 10), function()
        hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i), follow = false }))
    end, { description = "Window: Send to workspace " .. i })
end

for i = 1, 10 do
    local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
    hl.bind("SUPER + SHIFT + code:" .. numberkey[i], function()
        hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i), follow = false }))
    end)
end

-- Navigation über Tastenkombinationen und Mausrad
hl.bind("CTRL + SUPER + Right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("CTRL + SUPER + Left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("CTRL + SUPER + ALT + Right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("CTRL + SUPER + ALT + Left", hl.dsp.focus({ workspace = "m-1" }))
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "-1" }))
hl.bind("CTRL + SUPER + Page_Down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("CTRL + SUPER + Page_Up", hl.dsp.focus({ workspace = "r-1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "-1" }))
hl.bind("CTRL + SUPER + mouse_up", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("CTRL + SUPER + mouse_down", hl.dsp.focus({ workspace = "r-1" }))


--------------------------------------------------------------------------------
--! Virtual machines (Natives Lua Submap-Handling)
--------------------------------------------------------------------------------

hl.bind("SUPER + ALT + F1", function()
    hl.dispatch(hl.dsp.exec_cmd("notify-send 'Entered Virtual Machine submap' 'Keybinds disabled. Hit Super+Alt+F1 to escape' -a 'Hyprland'"))
    hl.dispatch(hl.dsp.submap("virtual-machine"))
end)

hl.define_submap("virtual-machine", function()
    hl.bind("SUPER + ALT + F1", function()
        hl.dispatch(hl.dsp.exec_cmd("notify-send 'Exited Virtual Machine submap' 'Keybinds re-enabled' -a 'Hyprland'"))
        hl.dispatch(hl.dsp.submap("reset"))
    end)
end)


--------------------------------------------------------------------------------
--! Session
--------------------------------------------------------------------------------

hl.bind("CTRL + SHIFT + ALT + SUPER + Delete", hl.dsp.exec_cmd("systemctl poweroff || loginctl poweroff"))


--------------------------------------------------------------------------------
--! Media
--------------------------------------------------------------------------------

hl.bind("XF86AudioNext", hl.dsp.exec_cmd([[playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`]]), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("SUPER + SHIFT + ALT + mouse:275", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("SUPER + SHIFT + ALT + mouse:276", hl.dsp.exec_cmd([[playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`]]))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })


--------------------------------------------------------------------------------
--! Apps
--------------------------------------------------------------------------------

hl.bind("SUPER + Return", hl.dsp.exec_cmd([[~/.config/hypr/hyprland/scripts/launch_first_available.sh "${TERMINAL}" "kitty -1" "foot" "alacritty" "wezterm" "konsole" "kgx" "uxterm" "xterm"]]), { description = "Terminal" })
hl.bind("SUPER + B", hl.dsp.exec_cmd([[~/.config/hypr/hyprland/scripts/launch_first_available.sh "chromium" "microsoft-edge-stable" "opera" "librewolf"]]), { description = "Browser" })
hl.bind("SUPER + E", hl.dsp.exec_cmd([[~/.config/hypr/hyprland/scripts/launch_first_available.sh "thunar"]]), { description = "File manager" })
hl.bind("CTRL + SUPER + V", hl.dsp.exec_cmd([[~/.config/hypr/hyprland/scripts/launch_first_available.sh "pavucontrol"]]), { description = "Volume mixer" })
hl.bind("SUPER + I", hl.dsp.exec_cmd([[XDG_CURRENT_DESKTOP=gnome ~/.config/hypr/hyprland/scripts/launch_first_available.sh "qs -p ~/.config/quickshell/$qsConfig/settings.qml" "systemsettings" "gnome-control-center" "better-control"]]), { description = "Settings app" })
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd([[~/.config/hypr/hyprland/scripts/launch_first_available.sh "gnome-system-monitor" "plasma-systemmonitor --page-name Processes" "command -v btop && kitty -1 fish -c btop"]]), { description = "Task manager" })


--------------------------------------------------------------------------------
--! Cursed stuff
--------------------------------------------------------------------------------

-- Ändert die aktive Fenstergröße exakt auf 640x480 (ohne relative = true)
hl.bind("CTRL + SUPER + Backslash", hl.dsp.window.resize({ x = 640, y = 480 }))
