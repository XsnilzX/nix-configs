{
  config,
  pkgs,
  ...
}: let
  tTeleSecPem = builtins.fetchurl {
    url = "https://corporate-pki.telekom.de/crt/GlobalRoot_Class_2.crt";
    sha256 = "0li50lbin11y2h5vr625076wm3laakhpswsqpakyn42qimwgbqli";
  };
in {
  sops.defaultSopsFile = ./../secrets/nixspo.yaml;

  sops.secrets."eduroam-env" = {
    # wer die Datei lesen darf; NetworkManager läuft als root
    owner = "root";
    group = "root";
    mode = "0400";
  };

  environment.etc."ssl/certs/GlobalRoot_Class_2.crt".source = tTeleSecPem;

  networking.networkmanager.enable = true;

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [config.sops.secrets."eduroam-env".path];

    profiles.eduroam = {
      connection = {
        id = "eduroam";
        type = "wifi";
        autoconnect = true;
      };

      wifi = {
        ssid = "eduroam";
        mode = "infrastructure";
      };

      wifi-security = {
        key-mgmt = "wpa-eap";
      };

      "802-1x" = {
        eap = "peap";
        identity = "$EDUROAM_ID";
        anonymous-identity = "$EDUROAM_ANON_ID";
        password = "$EDUROAM_PW";
        phase2-auth = "mschapv2";
        ca-cert = "/etc/ssl/certs/GlobalRoot_Class_2.crt";
      };

      ipv4.method = "auto";
      ipv6.method = "auto";
    };
  };
}
