
{ pkgs, config, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.05";
  home.username = "ezntek";
  home.homeDirectory = "/home/ezntek";

  home.packages = with pkgs; [
    # coding
    python3Full nodejs_20 rustc cargo exa bat rust-analyzer python311Packages.poetry-core
    # fonts
    noto-fonts noto-fonts-cjk noto-fonts-emoji fira-code fira-code-symbols
    # life
    libreoffice-fresh whatsapp-for-linux
    # utils
    libsForQt5.qt5ct ripgrep dunst gnome.gnome-software xdg-user-dirs btop unzip fontforge htop pavucontrol librewolf kitty git rofi
    tree libnotify scrot lxappearance arandr
    # more gui utils
    xfce.thunar xfce.parole networkmanagerapplet gimp mate.atril mate.eom mate.pluma
    # misc
    python311Packages.virtualenv cava afetch macchina lightlocker xfce.xfce4-screenshooter picom-jonaburg qogir-icon-theme papirus-icon-theme plasma5Packages.kdeconnect-kde
    # libs
    libyaml
    # vscode
    vscode
  ];
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
    theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
		"*" = {
		    bg-col = mkLiteral "#1e1e2e";
		    bg-col-light = mkLiteral "#1e1e2e";
		    border-col = mkLiteral "#cba6f7";
		    selected-col = mkLiteral "#1e1e2e";
		    blue = mkLiteral "#cba6f7";
		    fg-col = mkLiteral "#cdd6f4";
		    fg-col-2 = mkLiteral "#cba6f7";
		    grey = mkLiteral "#6c7086";

		    width = 600;
		    font = "Iosevka Dlig SS20 14";
		};

		"#element-text" = {
		    background-color = mkLiteral "inherit";
		    text-color =       mkLiteral "inherit";
		};

		"#element-icon" = {
		    background-color = mkLiteral "inherit";
		    text-color =       mkLiteral "inherit";
		};

		"#mode-switcher" = {
		    background-color = mkLiteral "inherit";
		    text-color =       mkLiteral "inherit";
		};

		"#window" = {
		    height = mkLiteral "360px";
		    border = mkLiteral "4px";
		    border-color = mkLiteral "@border-col";
		    background-color = mkLiteral "@bg-col";
		    border-radius = mkLiteral "12px";
		};

		"#mainbox" = {
		    background-color = mkLiteral "@bg-col";
		};

		"#inputbar" = {
		    children = map mkLiteral [ "prompt" "entry" ];
		    background-color = mkLiteral "@bg-col";
		    border-radius = mkLiteral "5px";
		    padding = mkLiteral "2px";
		};

		"#prompt" =  {
		    background-color = mkLiteral "@blue";
		    padding = mkLiteral "6px";
		    text-color = mkLiteral "@bg-col";
		    border-radius = mkLiteral "3px";
		    margin = mkLiteral "20px 0px 0px 20px";
		};

		"#textbox-prompt-colon" = {
		    expand = false;
		    str = ":";
		};

		"#entry" = {
		    padding = mkLiteral "6px";
		    margin = mkLiteral "20px 0px 0px 10px";
		    text-color = mkLiteral "@fg-col";
		    background-color = mkLiteral "@bg-col";
		};

		"#listview" = {
		    border = mkLiteral "0px 0px 0px";
		    padding = mkLiteral "6px 0px 0px";
		    margin = mkLiteral "10px 0px 0px 20px";
		    columns = 2;
		    lines = 5;
		    background-color = mkLiteral "@bg-col";
		};

		"#element" = {
		    padding = mkLiteral "5px";
		    background-color = mkLiteral "@bg-col";
		    text-color = mkLiteral "@fg-col"  ;
		};

		"#element-icon" = {
		    size = mkLiteral "25px";
		};

		"#element selected" = {
		    background-color =  mkLiteral "@selected-col" ;
		    text-color = mkLiteral "@fg-col-2" ;
		};

		"#mode-switcher" = {
		    spacing = 0;
		};

		"#button" = {
		    padding = mkLiteral "10px";
		    background-color = mkLiteral "@bg-col-light";
		    text-color = mkLiteral "@grey";
		    vertical-align = mkLiteral "0.5"; 
		    horizontal-align = mkLiteral "0.5";
		};

		"#button selected" =  {
		  background-color = mkLiteral "@bg-col";
		  text-color = mkLiteral "@blue";
		};

		"#message" = {
		    background-color = mkLiteral "@bg-col-light";
		    margin = mkLiteral "2px";
		    padding = mkLiteral "2px";
		    border-radius = mkLiteral "5px";
		};

		"#textbox" =  {
		    padding = mkLiteral "6px";
		    margin = mkLiteral "20px 0px 0px 20px";
		    text-color = mkLiteral "@blue";
		    background-color = mkLiteral "@bg-col-light";
		};
	};
  };
}
