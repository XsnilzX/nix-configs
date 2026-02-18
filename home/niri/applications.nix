{pkgs}: {
  browser = "${pkgs.helium}/bin/helium";
  terminal = "${pkgs.ghostty}/bin/ghostty";
  fileManager = "${pkgs.thunar}/bin/thunar";
  appLauncher = "${pkgs.anyrun}/bin/anyrun";
  mail = "${pkgs.thunderbird}/bin/thunderbird";
  code = "${pkgs.vscodium}/bin/vscodium";
}
