{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    # Setup custom aliases
    shellAliases = {
      apply-system = "$HOME/.dotfiles/apply-system.sh";
      apply-home = "$HOME/.dotfiles/apply-home.sh";
      options-nixos = "man configuration.nix";
      options-home = "man home-configuration.nix";
      ls = "ls --color=auto";
      l = "exa -l --icons";
      grep = "${pkgs.ripgrep}/bin/rg";
      todo = "${pkgs.neovim}/bin/nvim $ZETTELKASTEN_HOME/organizer/TodoList.md";
      fcd = "cd ''$(${pkgs.fd}/bin/fd --type d | ${pkgs.fzf}/bin/fzf)";
    };

    # Setup custom prompt
    initExtra = ''
        PROMPT="%B%F{blue}λ%f %F{244}%f %F{cyan}%1~%f%b "
        ZETTELKASTEN_HOME="$HOME/zettelkasten"
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
