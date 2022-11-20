# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.configurationLimit = 0;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # Opciones estéticas del GRUB
  boot.loader.grub.gfxmodeEfi = "1920x1080";
  boot.loader.timeout = 10;

  networking.hostName = "abraxas"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "es";
  };

  # Terminal por defecto
  environment.sessionVariables.TERMINAL = [ "kitty" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.autorun = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.displayManager.autoLogin.enable = false;
  services.xserver.displayManager.autoLogin.user = "woolean";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  # Tema de SDDM
  #services.xserver.displayManager.sddm.theme = "${(pkgs.fetchFromGitLab {
  #  owner = "";
  #  repo = "";
  #  rev = "";
  #  sha256 = "";
  #})}";

  # Configuración de LightDM
  #services.xserver.displayManager.sddm.theme = "Monochrome KDE";
  #services.xserver.displayManager.lightdm.greeters.enso.iconTheme.name = "Papirus-Dark";

  # Configure keymap in X11
  services.xserver.layout = "es";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  
  # Activar keyring
  services.gnome.gnome-keyring.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.woolean = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
  
  # Usar ZSH como shell
  programs.zsh.enable = true;
  programs.zsh.syntaxHighlighting.enable = true; 
  programs.zsh.enableCompletion = true;
  programs.zsh.enableBashCompletion = true;

  users.extraUsers.woolean = {
  	shell = pkgs.zsh;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #giladas gui
    firefox
    brave
    lxappearance
    gnome3.gedit
    libreoffice
    gnome3.simple-scan #scanner
    qbittorrent
    vlc
    pcmanfm
    pavucontrol
    xfce.xfce4-screenshooter
    galculator
    mate.atril 
    i3blocks
    gparted
    dmenu
    gimp
    kitty
    arandr
    j4-dmenu-desktop
    gnome.gnome-disk-utility

    #iconos y temas
    paper-icon-theme
    qogir-icon-theme
    qogir-theme
    papirus-icon-theme
    material-icons

    #Fuentes
    #font-awesome
    #font-awesome_4
    #mno16
    #fantasque-sans-mono
    #noto-fonts
    #terminus_font
    #cascadia-code
    #hasklig
    #monoid
    
    #CLI
    udiskie #montar discos automáticamente
    gcc #compilador c
    gdb #debugger
    git 
    wget 
    vim 
    neofetch
    htop
    zathura
    picom
    unzip 
    unrar
    p7zip
    zip #crear archivos zip
    xclip 
    dbus
    dconf
    exa # reemplazo de ls con más opciones
    feh #ver imagenes y poner wallpapers
    fd # reemplazo de find. 
    xfontsel
    sysstat
    yad
    xdotool
    ranger
    xorg.xev
    playerctl
    dosfstools
    alsaUtils
    envsubst # Para el script del volumen en i3blocks
    gnumake
    autotiling
    gnome.file-roller
    xcompmgr #compositor reemplazo de picom
    ntfs3g
    ncurses #libreria ncurses para c

    #Software propietario
    spotify
    discord
    zoom-us

    #Programación
    neovim
    python3
    nodejs
    jdk
    codeblocks
    vscode
  ];

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    font-awesome_4
    font-awesome
    hasklig
    mno16
    fantasque-sans-mono
    noto-fonts
    terminus_font
    cascadia-code
    monoid
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Servicios de impresora
  services.printing.drivers = [ pkgs.epson_201207w ];

  #Drivers de Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

