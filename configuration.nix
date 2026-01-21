{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Manila";

  services.displayManager.ly.enable = true;

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
  };
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.feh}/bin/feh --bg-fill --randomize ~/.wallpapers/*  &
  '';

  services.picom = {
    enable = true;
    backend = "glx";
  };

  services.printing.enable = true;

  hardware.bluetooth.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.kr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input"]; 
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  programs.nix-ld.enable = true; 
  programs.nix-ld.libraries = with pkgs; [
    rpclib
    stderred
    stylua
  ];

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim 
    neovim
    wget
    xclip
    btop
    tlp
    git
    unzip
    cmatrix
    gnumake
    flameshot
    alacritty
    picom
    chromium
    brave
    obs-studio
    vlc
    rofi
    feh
    pcmanfm
    pfetch
    gvfs
    brightnessctl
    pavucontrol
    arandr
    autorandr
    lxappearance
    libreoffice
    nodejs_24
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      # TLP_DEFAULT_MODE = "BAT";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };   

  services.openssh.enable = true;

  services.blueman.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  boot.loader.systemd-boot.configurationLimit = 5;
  system.stateVersion = "25.11"; 
}

