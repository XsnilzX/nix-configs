{
  config,
  pkgs,
  ...
}: {
  sops.defaultSopsFile = ./../secrets/nixspo.yaml;

  sops.secrets."eduroam-env" = {
    # wer die Datei lesen darf; NetworkManager läuft als root
    owner = "root";
    group = "root";
    mode = "0400";
  };

  sops.secrets."eduroam-ca.crt" = {
    owner = "root";
    group = "root";
    mode = "0444";
    path = "/etc/ssl/certs/eduroam-ca.crt";
  };

  # NetworkManager einschalten
  networking.networkmanager.enable = true;

  # eduroam-Profil; Pfad aus sops nehmen
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

      # Häng von deiner Uni ab – hier ein typisches PEAP/MSCHAPv2-Setup
      "802-1x" = {
        eap = "peap"; # oder [ "ttls" ]
        identity = "$EDUROAM_ID";
        anonymous-identity = "$EDUROAM_ANON_ID"; # optional
        password = "$EDUROAM_PW";
        phase2-auth = "mschapv2"; # oder "pap" bei TTLS
        # evtl. zusätzlich:
        ca-cert = config.sops.secrets."eduroam-ca.crt".path;
      };

      ipv4.method = "auto";
      ipv6.method = "auto";
    };
  };
}
