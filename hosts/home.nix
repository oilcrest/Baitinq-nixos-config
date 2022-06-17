{ config, lib, pkgs, inputs, user, hostname, secrets, ... }:
let
  dotfiles = ../dotfiles;
in
{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [
    scrot
    qemu
    redshift
    custom.xwinwrapr
    discord
    mpv
    sxiv
    dwm
    st
    dmenu
    unclutter
    clipmenu
    dunst
    sxhkd
    feh
    custom.smart-wallpaper
    custom.dwmbar
    numlockx
    surf
    pavucontrol
    light
    polkit_gnome
    progress
    qbittorrent
    xorg.xev
    statix
    custom.anime-downloader
  ];

  programs = {
    git = {
      enable = true;
      userName = "Baitinq";
      userEmail = "manuelpalenzuelamerino@gmail.com";
    };

    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        https-everywhere
        bypass-paywalls-clean
      ];
      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;
        settings = {
          "general.autoScroll" = true;
        };
      };
    };

    obs-studio = { enable = true; };

    zsh = {
      enable = true;
      zplug = {
        enable = true;
        plugins = [
          {
            name = "zsh-users/zsh-autosuggestions";
          } # Simple plugin installation
          {
            name = "zsh-users/zsh-syntax-highlighting";
          } # Simple plugin installation
          { name = "chrissicool/zsh-256color"; } # Simple plugin installation
          {
            name = "fsegouin/oh-my-zsh-agnoster-mod-theme";
            tags = [ "as:theme" "depth:1" ];
          } # Installations with additional options. For the list of options, please refer to Zplug README.
        ];
      };
      shellAliases = {
        ls = "ls --color";
        l = "ls -l";
        ll = "ls -la";
        weather = "(){ curl -s v2.wttr.in/$1 }";
        vim = "nvim";
        q = "exit";
        c = "clear";
        extract = ''
          () {
            if [ -f $1 ] ; then
              case $1 in
                *.tar.bz2)   tar xvjf $1    ;;
                *.tar.gz)    tar xvzf $1    ;;
                *.tar.xz)    tar Jxvf $1    ;;
                *.bz2)       bunzip2 $1     ;;
                *.rar)       rar x $1       ;;
                *.gz)        gunzip $1      ;;
                *.tar)       tar xvf $1     ;;
                *.tbz2)      tar xvjf $1    ;;
                *.tgz)       tar xvzf $1    ;;
                *.zip)       unzip -d `echo $1 | sed 's/\(.*\)\.zip/\1/'` $1;;
                *.Z)         uncompress $1  ;;
                *.7z)        7z x $1        ;;
                *)           echo "don't know how to extract '$1'" ;;
              esac
            else
              echo "'$1' is not a valid file!"
            fi
          }'';
      };

      initExtra = ''
        #when going up go up only beggining of curr word history
        bindkey '\e[A' history-search-backward
        bindkey '\e[B' history-search-forward
        #ctrl + arrow forward/backward word
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        #alt + arrow forward/backward word
        bindkey "^[[1;3C" forward-word
        bindkey "^[[1;3D" backward-word
        #ctrl + delete delete whole word
        bindkey '^H' backward-kill-word
        #alt + delete delete whole word
        bindkey "\e\x7f" backward-kill-word
      '';
    };

    vscode = {
      enable = true;
      mutableExtensionsDir = false; #needed for bug with installing extensions
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        esbenp.prettier-vscode
      ];
    };
  };

  home.file = {
    ".bash_profile".source = dotfiles + "/.bash_profile";
    ".xinitrc".source = dotfiles + "/.xinitrc";
    ".Xresources".source = dotfiles + "//.Xresources/";
    ".bashrc".source = dotfiles + "/.bashrc";
    ".config/zathura/zathurarc".source = dotfiles + "/zathurarc";
    ".config/sxhkd/".source = dotfiles + "/sxhkd";
    ".config/dunst/dunstrc".source = dotfiles + "/dunstrc";
    ".config/dwmbar".source = dotfiles + "/dwmbar/";

    ".scripts/".source = dotfiles + "/scripts/";
  };

  home.file = {
    "./Images/Wallpapers".source = pkgs.fetchFromGitHub {
      owner = "Baitinq";
      repo = "Wallpapers";
      rev = "291f9a4cf78a6ad862da151139ea026ea72968e5";
      sha256 = "sha256-YKpIno5QSJM/GGp5DwQeuhKmTU5S96+IhLr0O0V8PDI=";
    };
  };
}
