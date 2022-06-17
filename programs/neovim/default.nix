{ pkgs, lib, ... }:
let
  # taken from https://breuer.dev/blog/nixos-home-manager-neovim
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimutils.buildvimpluginfrom2nix {
    pname = "${lib.strings.sanitizederivationname repo}";
    version = ref;
    src = builtins.fetchgit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  # always installs latest version
  plugin = pluginGit "HEAD";

  # Language Servers to be installed
  languageServers = with pkgs; [
    metals                    # Scala
    haskell-language-server   # Haskell
  ];

in
{
  programs.neovim = {
    enable      = true;
    withPython3 = true;
    vimAlias    = true;
    viAlias     = true;

    # Configurations are stored in separate files
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        lua << EOF
        ${lib.strings.fileContents ./init.lua}
        ${lib.strings.fileContents ./lsp.lua}
        ${lib.strings.fileContents ./plugins/lualine.lua}
        ${lib.strings.fileContents ./plugins/cmp-nvim.lua}
        ${lib.strings.fileContents ./plugins/nvim-tree.lua}
        ${lib.strings.fileContents ./plugins/treesitter.lua}
        ${lib.strings.fileContents ./plugins/which-key.lua}
        EOF
      ''
    ];

    # Some packages required to run plugins
    extraPackages = with pkgs; [
      tree-sitter
      gcc
      nodejs
    ] ++ languageServers;

    # Fetch plugins from pkgs or git using the (plugin) function
    plugins = with pkgs.vimPlugins; [
      # Language Server Protocol - Related
      nvim-lspconfig
      cmp-nvim-lsp      # cmp suggestions from Language Servers
      cmp-buffer        # cmp suggestions from Buffers
      cmp-path          # cmp suggestions from path
      cmp-cmdline       # cmp suggestions from command line
      cmp-treesitter    # cmp suggestions form tree-sitter
      nvim-cmp
      lspkind-nvim
      neoformat

      # Syntax highlighting/language-specific
      nvim-ts-rainbow
      nvim-treesitter
      vim-nix
      vim-markdown
      nvim-tree-lua

      # Fuzzy Finder
      telescope-nvim

      # Misc
      which-key-nvim
      delimitMate # auto bracket
      vim-commentary
      vim-fugitive
      tabular
      vimwiki
      vim-better-whitespace
      toggleterm-nvim
      vim-gitgutter

      # EyeCandies
      onedark-nvim
      nvim-web-devicons
      lualine-nvim
    ];
  };
}
