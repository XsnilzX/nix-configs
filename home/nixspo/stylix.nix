{pkgs, ...}: {
  home.packages = [
    (pkgs.kdePackages.kcalc.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.makeWrapper];

      postFixup = ''
        wrapProgram $out/bin/kcalc \
          --unset QT_QPA_PLATFORMTHEME \
          --unset QT_STYLE_OVERRIDE \
          --unset QT_QUICK_CONTROLS_STYLE \
          --set QT_QPA_PLATFORM wayland
      '';
    }))
  ];
}
