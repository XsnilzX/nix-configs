{ config, ... }:

{
  imports = [ ./default.nix ];
  
  sops.secrets = {
    # User password
    "user_password_hash" = {
      sopsFile = ../../secrets/nixhael.yaml;
      neededForUsers = true;
    };
    
    # SSH Keys
    "ssh_keys/biggi/private" = {
      sopsFile = ../../secrets/nixhael.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/biggi";
      mode = "0600";
    };
    
    "ssh_keys/github/private" = {
      sopsFile = ../../secrets/nixhael.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/github";
      mode = "0600";
    };

    "ssh_keys/gitlab_finf/private" = {
      sopsFile = ../../secrets/nixhael.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/gitlab_finf";
      mode = "0600";
    };

    "ssh_keys/gitlab_uni/private" = {
      sopsFile = ../../secrets/nixhael.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/gitlab_uni";
      mode = "0600";
    };

    "ssh_keys/homelab/private" = {
      sopsFile = ../../secrets/nixhael.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/homelab";
      mode = "0600";
    };

    "ssh_keys/swp_key/private" = {
      sopsFile = ../../secrets/nixhael.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/swp_key";
      mode = "0600";
    };
    
    # Common tokens
    # "github_token" = {
    #   sopsFile = ../../secrets/common.yaml;
    #   owner = config.users.users.xsnilzx.name;
    # };
  };
  
  # User mit hashedPassword
  users.users.xsnilzx = {
    hashedPasswordFile = config.sops.secrets.user_password_hash.path;
  };
}