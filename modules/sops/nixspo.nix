{config, ...}: {
  imports = [./default.nix];

  sops.secrets = {
    "user_password_hash" = {
      sopsFile = ../../secrets/nixspo.yaml;
      neededForUsers = true;
    };

    "ssh_keys/biggi/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/biggi";
      mode = "0600";
    };

    "ssh_keys/github_key/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/github_key";
      mode = "0600";
    };

    "ssh_keys/gitlab_finf/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/gitlab_finf";
      mode = "0600";
    };

    "ssh_keys/gitlab_unihannover/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/gitlab_unihannover";
      mode = "0600";
    };

    "ssh_keys/home34b_key/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/home34b_key";
      mode = "0600";
    };

    "ssh_keys/homelab/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/homelab";
      mode = "0600";
    };

    "ssh_keys/huggingface/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/huggingface";
      mode = "0600";
    };

    "ssh_keys/swp/private" = {
      sopsFile = ../../secrets/nixspo.yaml;
      owner = config.users.users.xsnilzx.name;
      path = "/home/xsnilzx/.ssh/swp";
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
