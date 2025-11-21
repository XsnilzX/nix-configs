{ config, ... }:

{
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    # Hier können gemeinsame Einstellungen rein
  };
}