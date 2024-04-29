# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModprobeConfig = ''
    options thinkpad_acpi fan_control=1
  '';
  boot.kernelParams = [
    "quiet" "splash" "loglevel=3"
  ];

  networking.hostName = "ThunkVegetablePeeler"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "ter-v32n";
    packages = with pkgs; [ terminus_font ];
    useXkbConfig = true; # use xkb.options in tty.
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-vaapi-driver
    libvdpau-va-gl
  ];

  services.xserver.dpi = 120;
  services.libinput = {
    touchpad.tapping = false;
  };

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
  services.xserver.desktopManager = {
    xterm.enable = false;
    xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
  };

  services.displayManager.defaultSession = "none+leftwm";
  services.xserver.windowManager.leftwm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "colemak";
  services.xserver.xkb.options = "compose:caps";
  services.picom.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  #sound.enable = true;
  #hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
	["bluez5.enable-hw-volume"] = true,
	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '')
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.ezntek = { 
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "tty" "lp" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ firefox mate.atril xfce.thunar xfce.ristretto xfce.mousepad mupdf ];
    initialPassword = "etr#2398";
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    btop
    htop
    zip
    unzip
    p7zip
    xz papirus-icon-theme qogir-icon-theme cloudflare-warp 
    fastfetch xclip xsel networkmanagerapplet xfce.xfce4-screensaver kwalletmanager
    (rofi.override { plugins = [ rofi-emoji ]; })
    sysfsutils pciutils
  ];

  systemd.packages = [pkgs.cloudflare-warp];

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    SSH_ASKPASS = lib.mkForce "";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [
    {
      groups = ["wheel"];
      keepEnv = true;
      persist = true;
    }
    {
      users = ["root"];
      noPass = true;
      keepEnv = true;
    }
  ];

  # List services that you want to enable:
  security.pam.services.lightdm.enableKwallet = true;
  security.pam.services.kwallet.enableKwallet = true;
  services.warp-svc.enable = true;

  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.dbus.enable = true;
  services.touchegg.enable = true;

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

