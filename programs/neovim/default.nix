{ pkgs, lib, ... }:
let
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
        ${lib.strings.fileContents ./plugins/which-key.lua}
        ${lib.strings.fileContents ./plugins/toggleterm.lua}
        ${lib.strings.fileContents ./plugins/telescope.lua}
        EOF
      ''
    ];

    # Some packages required to run plugins
    extraPackages = languageServers;

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
      {
            plugin = nvim-treesitter.withPlugins (plugins: with plugins; [
              tree-sitter-python
              tree-sitter-cpp
              tree-sitter-c
              tree-sitter-haskell
              tree-sitter-rust
              tree-sitter-latex
              tree-sitter-markdown
              tree-sitter-json
              tree-sitter-json5
              tree-sitter-lua
              tree-sitter-nix
          ]);
          config = "lua require('nvim-treesitter')";
      }

      nvim-tree-lua               # File Tree

      # Misc
      impatient-nvim              # Improves startup time
      which-key-nvim              # Keymaps and suggestions about them
      delimitMate                 # Auto closing brackets
      vim-commentary              # Comment with `gc_`
      toggleterm-nvim             # Toggle Terminal
      vim-gitgutter               # Git Diffs in the sign column
      telescope-nvim              # Telescope
      telescope-ui-select-nvim    # Telescope extension
      luasnip                     # Snippet Engine
      cmp_luasnip                 # Snippet engine integration with cmp-nvim

      # EyeCandies
      indent-blankline-nvim       # Indentation guides
      nvim-web-devicons           # Icons
      lualine-nvim                # Better Status Bar
      lualine-lsp-progress        # Show loading progress inside statusbar
      onedarkpro-nvim
    ];
  };
}
