{machine, ...}: {
  sops = {
    age.sshKeyPaths =
      if machine == "nixhael"
      then ["/etc/ssh/ssh_host_ed25519_key"]
      else [];
    age.keyFile =
      if machine != "nixhael"
      then "/var/lib/sops-nix/key.txt"
      else null;
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
