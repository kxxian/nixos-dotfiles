{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "amdgpu" ];   

  services.thermald.enable = true;

  boot.kernelParams = [
    "amdgpu.dpm=1"
    "amdgpu.runpm=1"
    "idle=nomwait"
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];   
  hardware.graphics = {
    enable = true;
  };   

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
    yt-dlp
    rofi
    feh
    pcmanfm
    pfetch
    gvfs
    telegram-desktop
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

  # services.auto-cpufreq.enable = true;

  # services.tlp = {
  #   enable = true;
  #   settings = {
  #
  #     CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #
  #     CPU_BOOST_ON_AC = 1;
  #     CPU_BOOST_ON_BAT = 0;
  #
  #     CPU_MAX_PERF_ON_AC = 100;
  #     CPU_MAX_PERF_ON_BAT = 40;
  #
  #     START_CHARGE_THRESH_BAT0 = 40;
  #     STOP_CHARGE_THRESH_BAT0 = 80;
  #   };
  # };

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

