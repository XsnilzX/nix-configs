{ config, lib, ... }:
let
  sshPath = "${config.home.homeDirectory}/.ssh";
in
{
  programs.ssh = {
    enable = true;
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
      "biggi" = {
        hostname = "10.0.20.8";
        user = "richard";
        identityFile = "${sshPath}/biggi";
        identitiesOnly = true;
      };
      "swp" = {
        hostname = "git.se.uni-hannover.de";
        user = "git";
        identityFile = "${sshPath}/swp";
        identitiesOnly = true;
      };
    };
  };
}