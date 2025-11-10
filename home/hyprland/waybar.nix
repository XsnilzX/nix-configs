{
    programs.waybar = {
        enable = true;
        style = ''
            /* Schrift & Grundfarbe */
            * {
                border: none;
                border-radius: 0px;
                font-family: "JetBrainsMono Nerd Font", monospace;
                font-size: 12px;
                color: #cdd6f4;
            }

            /* GANZE Waybar transparent */
            window#waybar {
                background: transparent;
            }

            .modules-left,
            .modules-center,
            .modules-right {
            background: rgba(30, 30, 46, 0.85);
            padding: 2px 6px;
            margin: 2px 4.5px;
            border-radius: 16px;
            }

            #clock,
            #custom-weather{
                padding: 0 4px;
            }

            #cpu,
            #memory,
            #network,
            #battery,
            #backlight,
            #pulseaudio,
            #power-profiles-daemon,
            #custom-hyprclip{
                padding: 0 6px;
            }


            /* Wetter Tooltip (wie gehabt) */
            tooltip {
                background: #1e1e2e;
                border-radius: 8px;
                padding: 8px;
                font-size: 13px;
                color: #cdd6f4;
                opacity: 0.9;
            }

            #custom-weather {
                font-size: 14px;
            }

            /* Wetter Widget Farben je nach Wetterlage */
            #custom-weather.severe {
                color: #eb937d; /* Extremes Wetter (Sturm, Gewitter) */
            }

            #custom-weather.sunnyDay {
                color: #c2ca76; /* Sonnig (Tag) */
            }

            #custom-weather.clearNight {
                color: #89a1b0; /* Klarer Himmel (Nacht) */
            }

            #custom-weather.cloudyFoggyDay,
            #custom-weather.cloudyFoggyNight {
                color: #c2ddda; /* Bewölkt oder neblig */
            }

            #custom-weather.rainyDay,
            #custom-weather.rainyNight {
                color: #5aaca5; /* Regen */
            }

            #custom-weather.snowyIcyDay,
            #custom-weather.snowyIcyNight {
                color: #d6e7e5; /* Schnee oder Eis */
            }

            #custom-weather.default {
                color: #dbd9d8; /* Standardfarbe */
            }

            /* Separator */
            #custom-separator {
                color: #585b70;
                font-size: 16px;
            }

            #tray,
            #custom-exit{
                padding: 0 4px;
            }

            #custom-exit {
                font-family: "Font Awesome 6 Free";
                font-size: 12px;
                color: #f53c3c;
            }
        '';
        settings = {
            "layer": "top",
            "position": "top",
            "height": 30,

            // Wir zeigen jetzt nur 3 Container-Module an
            "modules-left": ["hyprland/workspaces"],
            "modules-center": ["clock", "custom/weather"],
            "modules-right": 
            [
                "cpu", "memory", "battery", "backlight", "pulseaudio",
                "power-profiles-daemon", "custom/notification", "custom/separator",
                "tray", "custom/exit"
            ],
            "clock": {
                "format": " {:%H:%M}",
                "tooltip": false,
            },
            "cpu": {
                "interval": 1,
                "format": "{usage}%",
            },
            "memory": {
                "interval": 2,
                "format": "{used:0.1f}GB",
            },
            "battery": {
                "format": "{capacity}%",
                "format-charging": "{capacity}%",
                "format-plugged": "{capacity}%",
            },
            "backlight": {
                "format": "{percent}%",
            },
            "custom/weather": {
                "exec": "uv run --directory=/home/xsnilzx/Git/weather-widget main.py",
                "return-type": "json",
                "interval": 120, // alle 2 Minuten aktualisieren
                "format": "{}",
                "tooltip": true,
            },
            "pulseaudio": {
                "format": "{volume}% {icon} {format_source}",
                "format-muted": " {format_source}",
                "format-source": "{volume}% ",
                "format-source-muted": "",
                "format-bluetooth": "{volume}% {icon} {format_source}",
                "format-bluetooth-muted": " {icon} {format_source}",
                "format-icons": {
                "default": ["", "", ""],
                "headphone": "",
                "headset": "",
                "hands-free": "",
                "phone": "",
                "portable": "",
                "car": ""
                },
                "on-click": "pavucontrol"
            },
            "tray": {
                "spacing": 5,
                "icon-size": 18,
                "items": ["nm-applet", "blueman-applet"],
                "tooltip": false,
            },
            "custom/separator": {
                "format": "|",
                "tooltip": false,
            },
            "custom/exit": {
                "format": "⏻",
                "on-click": "wlogout",
                "tooltip": false,
            },
            "power-profiles-daemon": {
                "format": "{icon}",
                "tooltip-format": "Power Profile: {icon} {profile}",
                "format-icons": {
                "performance": "",
                "balanced": "",
                "power-saver": ""
                }
            },
            "custom/notification": {
                "tooltip": false,
                "format": "{icon}",
                "format-icons": {
                "notification": "<span foreground='red'><sup></sup></span>",
                "none": "",
                "dnd-notification": "<span foreground='red'><sup></sup></span>",
                "dnd-none": "",
                "inhibited-notification": "<span foreground='red'><sup></sup></span>",
                "inhibited-none": "",
                "dnd-inhibited-notification": "<span foreground='red'><sup></sup></span>",
                "dnd-inhibited-none": ""
                },
                "return-type": "json",
                "exec-if": "which swaync-client",
                "exec": "swaync-client -swb",
                "on-click": "swaync-client -t -sw",
                "on-click-right": "swaync-client -d -sw",
                "escape": true
            },
        };
    };
}