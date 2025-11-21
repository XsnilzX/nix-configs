{ config, ... }:

{
  imports = [ ./default.nix ];
  
  sops.secrets = {
    "user_password_hash" = {
      sopsFile = ../../secrets/nixspo.yaml;
      neededForUsers = true;
    };
    
    "ssh_keys/personal/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/id_ed25519";
      mode = "0600";
    };
    
    "ssh_keys/github/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/id_ed25519_github";
      mode = "0600";
    };
    
    # "github_token" = {
    #   sopsFile = ../../secrets/common.yaml;
    #   owner = config.users.users.xsnilzx.name;
    # };
  };
  
  users.users.xsnilzx = {
    hashedPasswordFile = config.sops.secrets.user_password_hash.path;
  };
}