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
        };
    };
}