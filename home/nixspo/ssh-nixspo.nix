{config, ...}: let
  sshPath = "${config.home.homeDirectory}/.ssh";
in {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "git-uni" = {
        hostname = "gitlab.uni-hannover.de";
        user = "git";
        identityFile = "${sshPath}/gitlab_unihannover";
        identitiesOnly = true;
      };
      "git-finf" = {
        hostname = "git.finf.uni-hannover.de";
        user = "git";
        identityFile = "${sshPath}/gitlab_finf";
        identitiesOnly = true;
      };
      "homelab" = {
        hostname = "10.0.20.10";
        user = "xsnilzx";
        identityFile = "${sshPath}/homelab";
        identitiesOnly = true;
      };
      "github" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${sshPath}/github_key";
        identitiesOnly = true;
      };
      "home34b" = {
        hostname = "192.168.178.10";
        user = "richard";
        identityFile = "${sshPath}/home34b_key";
        identitiesOnly = true;
      };
      "biggi" = {
        hostname = "10.0.20.8";
        user = "richard";
        identityFile = "${sshPath}/biggi";
        identitiesOnly = true;
      };
      "huggingface" = {
        hostname = "hf.co";
        user = "git";
        identityFile = "${sshPath}/huggingface";
        identitiesOnly = true;
      };
      "sra" = {
        hostname = "lab.sra.uni-hannover.de";
        user = "ric.taesler";
        identityFile = "${sshPath}/sra";
        identitiesOnly = true;
      };
    };
  };
}
