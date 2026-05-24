local home = os.getenv("HOME")

-- Autostart-Eventsblock (Entspricht dem alten exec-once)
hl.on("hyprland.start", function ()

    --------------------------------------------------------------------------------
    --! Bar, wallpaper
    --------------------------------------------------------------------------------
    hl.exec_cmd(home .. "/.config/hypr/hyprland/scripts/start_geoclue_agent.sh")
    hl.exec_cmd("qs -c $qsConfig") -- Da hl.exec_cmd asynchron läuft, wurde das '&' entfernt
    hl.exec_cmd(home .. "/.config/hypr/custom/scripts/__restore_video_wallpaper.sh")

    --------------------------------------------------------------------------------
    --! Core components (authentication, lock screen, notification daemon)
    --------------------------------------------------------------------------------
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("dbus-update-activation-environment --all")
    hl.exec_cmd("sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dex -a")

    --------------------------------------------------------------------------------
    --! Clipboard: history
    --------------------------------------------------------------------------------
    hl.exec_cmd([[wl-paste --type text --watch bash -c 'cliphist store && qs -c $qsConfig ipc call cliphistService update']])
    hl.exec_cmd([[wl-paste --type image --watch bash -c 'cliphist store && qs -c $qsConfig ipc call cliphistService update']])

    --------------------------------------------------------------------------------
    --! Cursor
    --------------------------------------------------------------------------------
    hl.exec_cmd("hyprctl setcursor Adwaita 16")

    --------------------------------------------------------------------------------
    --! Fixes / Workarounds (Inaktiv / Auskommentiert)
    --------------------------------------------------------------------------------
    -- hl.exec_cmd("sleep 3.5 && hyprctl reload && sleep 0.5 && touch " .. home .. "/.config/quickshell/ii/shell.qml")

end)

