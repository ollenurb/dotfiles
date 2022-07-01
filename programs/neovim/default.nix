{ pkgs, lib, ... }:
let
  # taken from https://breuer.dev/blog/nixos-home-manager-neovim
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
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
    rust-analyzer             # Rust
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
        ${lib.strings.fileContents ./plugins/toggleterm.lua}
        ${lib.strings.fileContents ./plugins/telescope.lua}
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
      # Language Server Protocol
      nvim-lspconfig              # Every LSP default config
      cmp-nvim-lsp                # cmp suggestions from Language Servers
      cmp-buffer                  # cmp suggestions from Buffers
      cmp-path                    # cmp suggestions from path
      cmp-cmdline                 # cmp suggestions from command line
      cmp-treesitter              # cmp suggestions form tree-sitter
      nvim-cmp                    # Autosuggestions
      lspkind-nvim                # Better kinds (show type on autosuggestions)
      rust-tools-nvim             # Better Rust LSP default config
      trouble-nvim                # Better LSP code actions

      # Syntax highlighting/language-specific
      nvim-treesitter             # Better Syntax Highlighting
      nvim-tree-lua               # File Tree

      # Misc
      impatient-nvim              # Improves startup time
      which-key-nvim              # Keymaps and suggestions about them
      delimitMate                 # Auto closing brackets
      vim-commentary              # Comment with `gc_`
      tabular                     # Tabularize stuff  # TODO: Keymaps should be created
      vim-better-whitespace       # Shows Whitespaces
      toggleterm-nvim             # Toggle Terminal
      vim-gitgutter               # Git Diffs in the sign column
      telescope-nvim              # Telescope
      telescope-ui-select-nvim
      luasnip                     # Snippet Engine
      cmp_luasnip                 # Snippet engine integration with cmp-nvim


      # EyeCandies
      nvim-web-devicons              # Icons
      lualine-nvim                   # Better Status Bar
      lualine-lsp-progress           # Show loading progress inside statusbar
      (plugin "ful1e5/onedark.nvim") # Colorscheme
    ];
  };
}
