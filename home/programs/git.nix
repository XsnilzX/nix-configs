{pkgs, ...}: {
  programs.git = {
    enable = true;
    user.Name = "Richard Taesler";
    user.Email = "officiall.xdragonyt@gmail.com";
    lfs.enable = true;
  };
}
