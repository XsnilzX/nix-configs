{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    zotero

    libreoffice-fresh
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
  ];
}
