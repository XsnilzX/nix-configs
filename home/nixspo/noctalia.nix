{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = "compact";
        position = "top";
        widgets = {
          left = [
            {id = "Launcher";}
            {id = "Clock";}
            {id = "SystemMonitor";}
            {id = "ActiveWindow";}
          ];
          center = [
            {id = "Workspace";}
          ];
          right = [
            {id = "Tray";}
            {id = "NotificationHistory";}
            {id = "Volume";}
            {id = "Brightness";}
            {id = "Battery";}
            {id = "ControlCenter";}
          ];
        };
      };

      location = {
        name = "Hannover";
      };

      colorSchemes = {
        useWallpaperColors = true;
        darkMode = true;
        generationMethod = "tonal-spot";
      };

      appLauncher = {
        position = "center";
        viewMode = "list";
        showCategories = true;
        pinnedApps = [];
      };

      controlCenter.position = "close_to_bar_button";
      notifications.location = "top_right";
      osd.location = "top_right";

      dock.enabled = false;
    };
  };

  programs.myQuickshell.enable = lib.mkForce false;

  programs.niri.settings.spawn-at-startup = lib.mkAfter [
    {command = ["noctalia-shell"];}
  ];
}
