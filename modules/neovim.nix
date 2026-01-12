{ config, pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        fzf
        ripgrep
        fd
        curl
        lazygit
        lua
        gcc
        tree-sitter
        nil
        nixpkgs-fmt
    ];

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
    };
}
