{pkgs, ...}:{
  programs.git = {
    enable = true;
    userName = "Richard Taesler";
    userEmail = "officiall.xdragonyt@gmail.com";
    lfs.enable = true;
  };
}