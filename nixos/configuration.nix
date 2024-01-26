# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  # allow nonfree shit
  nixpkgs.config.allowUnfree = true;

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;

  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    
    gfxmodeEfi = "1920x1080"; 
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NixBox"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
    font = "ter-v28n";     
    keyMap = "colemak";
    useXkbConfig = false; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "colemak";
  services.xserver.xkbOptions = "compose:caps";

  # other x11 shit
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;  

  services.xserver.windowManager = {
    qtile = {
      enable = true;
      extraPackages = python3Packages: with python3Packages; [
        qtile-extras
        psutil
        pyxdg
      ];
    };
  };

  services.xserver.displayManager.lightdm = {
      background = /home/ezntek/Downloads/nix-snowflake-dark.png;
      greeters.gtk = {
        theme = {
	  name = "Catppuccin-Mocha-Compact-Sapphire-Dark";
	};
	iconTheme = {
	  name = "Papirus-dark";
	};
	cursorTheme = {
	  name = "Qogir";
	};
      };
  };
  # shell
  programs.zsh.enable = true;
  # fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
  ];

  # Disable Sudo because doas > sudo
  security.sudo.enable = false;

  # Doas
  security.doas.enable = true;
  security.doas.extraRules = [
    {
      groups = [ "wheel" ];
      persist = true;
      keepEnv = true;
    }
  ];  

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;  
  };

  # flatpak
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
  };

  services.flatpak.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ezntek = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "cdrom" "lp" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      vim
      libyaml
    ];
    shell = pkgs.zsh;
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neofetch
    doas
    nushell
    zsh
    home-manager
    terminus_font
    wireplumber
    pipewire
    python311Full
    python312
    xorg.xinit
    (pkgs.catppuccin-gtk.override {
      accents = [ "mauve" "sapphire" "pink" ];
      size = "compact";
      tweaks = [ "rimless" "normal" ];
      variant = "mocha";
    })
    gcc
    meson
    gnumake
    autoconf
    automake
    binutils
    bison
    debugedit
    findutils
    gawk
    libtool
    papirus-icon-theme
    qogir-icon-theme
  ];

  # bluetooth
  hardware.bluetooth.enable = true;

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
	  ["bluez5.enable-sbc-xq"] = true,
	  ["bluez5.enable-msbc"] = true,
	  ["bluez5.enable-hw-volume"] = true,
	  ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
	}
    '';
  };

  programs.ssh.askPassword = "";

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

  services.blueman.enable = true;
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

