{
  programs.git = {
    enable = true;
    settings = {
      core.hooksPath = ".githooks";
      user.name = "Richard Taesler";
      user.email = "officiall.xdragonyt@gmail.com";
    };
    lfs.enable = true;
  };
}
