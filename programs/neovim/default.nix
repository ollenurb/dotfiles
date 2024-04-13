{ pkgs, lib, ... }:
let
  # Language Servers to be installed
  languageServers = with pkgs; [
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
    extraConfig = ''
      lua << EOF
      if not vim.g.vscode then
          ${builtins.readFile ./init.lua}
          ${builtins.readFile ./lsp.lua}
          ${builtins.readFile ./lsp.lua}
          ${builtins.readFile ./plugins/shade.lua}
          ${builtins.readFile ./plugins/lualine.lua}
          ${builtins.readFile ./plugins/cmp-nvim.lua}
          ${builtins.readFile ./plugins/nvim-tree.lua}
          ${builtins.readFile ./plugins/which-key.lua}
          ${builtins.readFile ./plugins/toggleterm.lua}
          ${builtins.readFile ./plugins/telescope.lua}
          ${builtins.readFile ./plugins/treesitter.lua}
      end
      EOF
    '';

    # Some packages required to run plugins
    extraPackages = [ pkgs.xclip ] ++ languageServers;

    # Fetch plugins from pkgs or git using the (plugin) function
    plugins = with pkgs.vimPlugins; [
      # LSP - Autocompletion related
      nvim-lspconfig              # Every LSP default config
      cmp-nvim-lsp                # cmp suggestions from Language Servers
      cmp-buffer                  # cmp suggestions from Buffers
      cmp-path                    # cmp suggestions from path
      cmp-cmdline                 # cmp suggestions from command line
      cmp-treesitter              # cmp suggestions form tree-sitter
      cmp_luasnip                 # Snippet engine integration with cmp-nvim
      nvim-cmp                    # Autosuggestions
      luasnip                     # Snippet Engine
      lspkind-nvim                # Better kinds (show type on autosuggestions)
      rust-tools-nvim             # Better Rust LSP default config
      # trouble-nvim                # Better LSP code actions

      # Syntax highlighting/language-specific
      {
          plugin = nvim-treesitter.withPlugins (plugins: with plugins; [
            tree-sitter-python
            tree-sitter-cpp
            tree-sitter-rust
            tree-sitter-latex
            tree-sitter-markdown
            tree-sitter-json
            tree-sitter-json5
            tree-sitter-lua
            tree-sitter-nix
            tree-sitter-glsl
          ]);
      }

      nvim-tree-lua               # File Tree

      # Misc
      impatient-nvim              # Improves startup time
      which-key-nvim              # Keymaps and suggestions about them
      delimitMate                 # Auto closing brackets
      vim-commentary              # Comment with `gc_`
      toggleterm-nvim             # Toggle Terminal
      telescope-nvim              # Telescope
      telescope-ui-select-nvim    # Telescope extension

      # EyeCandies
      Shade-nvim                  # Dim inactive windows
      indent-blankline-nvim       # Indentation guides
      nvim-web-devicons           # Icons
      lualine-nvim                # Better Status Bar
      lualine-lsp-progress        # Show loading progress inside statusbar
      catppuccin-nvim
    ];
  };
}
