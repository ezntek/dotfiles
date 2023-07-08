{ pkgs, config, ... }: {
  # basic settings
  home.stateVersion = "23.11";
  home.username = "ezntek";
  home.homeDirectory = "/home/ezntek";

  # some packages
  home.packages = with pkgs; [
    # fonts
    noto-fonts noto-fonts-cjk noto-fonts-emoji fira-code fira-code-symbols
    
    # life
    libreoffice-fresh whatsapp-for-linux
    
    # utils
    libsForQt5.qt5ct du-dust dunst gnome.gnome-software xdg-user-dirs btop unzip fontforge htop
    pavucontrol librewolf kitty xfce.xfce4-terminal git rofi libnotify scrot lxappearance arandr
    
    # more gui utils
    xfce.thunar xfce.parole networkmanagerapplet gimp mate.atril mate.eom mate.pluma

    # toolchain + cli stuff

    python3Full nodejs_20 rust-analyzer python311Packages.poetry-core
    rustc exa cargo bat ripgrep
  
    # misc
    python311Packages.virtualenv cava onefetch afetch bottom macchina lightlocker
    xfce.xfce4-screenshooter picom-jonaburg qogir-icon-theme papirus-icon-theme
    plasma5Packages.kdeconnect-kde
    
    # vscode
    vscode

    # fonts
    noto-fonts noto-fonts-cjk noto-fonts-emoji fira-code fira-code-symbols source-han-mono
    source-han-serif

    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];  
    })
  ];
  
  # configs
  qt.platformTheme = "qt5ct";

  # rofi
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Papirus-dark";
      show-icons = true;
      terminal = "kitty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "  Apps ";
      display-run = "   Run ";
      display-window = "  Window";
      display-Network = "  Network";
      sidebar-mode = true;
    };
    theme =
      import ./rofi.nix { inherit config; };
  };

  # git
  programs.git = {
    enable = true;
    userName = "ezntek";
    userEmail = "eason@ezntek.com";
  };
}
