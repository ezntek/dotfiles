{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  nixpkgs.config.allowUnfree = true;
  home.username = "ezntek";
  home.homeDirectory = "/home/ezntek";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # fonts
    nerdfonts source-sans source-han-serif source-han-sans
    source-serif inter noto-fonts noto-fonts-color-emoji
    jetbrains-mono cascadia-code recursive font-awesome

    # GUI utilities
    obsidian inkscape armcord signal-desktop beeper
    libreoffice-fresh kdenlive thunderbird gimp
    obs-studio prismlauncher vlc nextcloud-client
    kitty

    # LSPs
    pyright

    # archives
    zip xz unzip p7zip

    # programming
    python3Full rustc cargo go llvm clang
    
    # utilities
    ripgrep jq eza fzf bat exfatprogs
    iperf3 aria2 

    # misc
    tree file which cowsay zstd lm_sensors gtklock
    gucharmap brightnessctl

    # theme
    (catppuccin-gtk.override {
      accents = [ "sapphire" ];
      size = "standard";
      tweaks = [ "rimless" "normal" ];
      variant = "macchiato";
    })

    # wm
    nitrogen nwg-look qt5ct lxappearance
    dunst libnotify powertop pamixer pavucontrol xfce.xfce4-screenshooter qogir-icon-theme papirus-icon-theme 

    (polybar.override {
      pulseSupport = true;
    })

    (writeScriptBin "fan" "echo level $1 > /proc/acpi/ibm/fan")
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ezntek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "Eason Qin";
    userEmail = "eason@ezntek.com";
    extraConfig = {
      credential.helper = "store";
      credential.guiPrompt = false;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      la = "ls -la";
      ll = "ls -lah";
      grep = "rg";
      cat = "bat";
      scat = "/nix/store/asqa3kfq3maclk7cqqhrjvp7vriw6ahy-coreutils-9.5/bin/cat";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = ''
      [┌](white)$time$git_branch$git_status$rust$c$python$zig$package
      └[$directory](bold blue)$character
      '';
      character = {
        success_symbol = "[>>](bold white)";
        error_symbol = "[>>](bold red)";
      };
      time = {
        style = "cyan";
        disabled = false;
        time_format = "%T";
        format = ''[\[](bold white)[$time]($style)[\]](bold white)'';
      };
      git_branch = {
        style = "green";
        format = ''[\[](bold white)on [$symbol$branch(:$remote_branch)]($style)'';
      };
      git_status = {
        up_to_date = "";
        style = "yellow";
        modified = "*";
        format = '' ([\($all_status$ahead_behind\)]($style))[\]](bold white)'';
      };
      package = {
        disabled = false;
        format = ''[\[](bold white)[$symbol$version]($style)[\]](bold white)'';
      };
      rust = {
        format = ''[\[](bold white)[$symbol$version]($style)[\]](bold white)'';
      };
      python = {
        style = "blue bold";
        format = ''[\[](bold white)[$\{symbol}$\{pyenv_prefix}($\{version})(\($virtualenv\))]($style)[\]](bold white)'';
      };
      c = {
        style = "blue bold";
        format = ''[\[](bold white)[$symbol($version(-$name))]($style)[\]](bold white)'';
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
