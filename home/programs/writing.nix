{config, pkgs, ...}: {
    home.packages = with pkgs; [
        zotero

        libreoffice-qt
    ];
}