{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
      qtile = "qtile";
      rofi  = "rofi";
      alacritty = "alacritty";
      btop = "btop";
      nvim = "nvim";
  };
in

{
  imports = [
    ./modules/neovim.nix
  ];

  home.username = "kr";
  home.homeDirectory = "/home/kr";
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "kxxian";
        email = "kristianryanbulos@gmail.com";
      };
    };
  };
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    initExtra = ''
      ${pkgs.pfetch}/bin/pfetch
    '';
    shellAliases = {
       btw = "echo i use nixos, btw";
    };
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
  }) configs; 
}
