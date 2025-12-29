{config, ...}: {
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    # Hier können gemeinsame Einstellungen rein

    /*
    secrets."mail/fachrat-password" = {
      owner = "xsnilzx"; # dein User
    };

    secrets."mail/uni-password" = {
      owner = "xsnilzx";
    };

    secrets."mail/privat-password" = {
      owner = "xsnilzx";
    };
    */
  };
}
