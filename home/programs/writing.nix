{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    zotero

    libreoffice-fresh
  ];
}
