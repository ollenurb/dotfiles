{ config, pkgs, ... }:

let
    # Define common programs 
    eza = "${pkgs.eza}/bin/eza";
    zathura = "${pkgs.zathura}/bin/zathura";
    fd = "${pkgs.fd}/bin/fd";
    grep = "${pkgs.ripgrep}/bin/rg";
    fzf = "${pkgs.fzf}/bin/fzf";
    bat = "${pkgs.bat}/bin/bat";

    # Define a script to apply the current system state
    applySystem = pkgs.writeShellScript "apply-system" ''
      pushd ~/.dotfiles
      host=$(hostname)
      sudo nixos-rebuild switch --flake .#$host
      popd
    '';

    # Define a script to open pdf searching the whole system
    pdfOpen = pkgs.writeShellScript "pdfopen" ''
      selected_file=$(${fd} --type f -e pdf . $HOME | ${fzf})
      if [ -n "$selected_file" ]; then
        nohup ${zathura} "$selected_file" >/dev/null 2>&1 &
      fi
    '';
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;

    # Setup custom aliases
    shellAliases = {
      apply-system = "${applySystem}";
      options-nixos = "man configuration.nix";
      options-home = "man home-configuration.nix";
      ls = "ls --color=auto";
      l = "eza -l --icons";
      grep = grep;
      fcd = "cd ''$(${fd} --type d | ${fzf})";
      bat = "bat --theme=OneHalfDark";
      pdfopen = "${pdfOpen}";
    };

    # Setup custom prompt
    initExtra = ''
        PROMPT="%B%F{red}λ%f %F{244}%f %F{cyan}%1~%f%b "
    '';

    # Add plugins
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
    ];

  };
}
