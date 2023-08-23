{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      hop-nvim
      leap-nvim
      comment-nvim
      nvim-surround
      nvim-treesitter.withAllGrammars
      plenary-nvim
      vim-repeat
      tokyonight-nvim
      nvim-lspconfig
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      FixCursorHold-nvim
      neotest
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      cmp-calc
      cmp-omni
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lsp-signature-help
      cmp-tabnine
      cmp-nvim-lua
      friendly-snippets
      nvim-autopairs
      lspkind-nvim
      which-key-nvim
      trouble-nvim
      noice-nvim
      nvim-web-devicons
      nui-nvim
      nvim-notify
      nvim-ts-context-commentstring
      todo-comments-nvim
      nvim-treesitter-textobjects
      neorg
      flash-nvim
      null-ls-nvim
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
