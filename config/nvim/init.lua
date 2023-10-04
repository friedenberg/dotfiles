
vim.cmd [[
  source ~/.config/nvim/load_plugin_file.vim
  call plug#begin()
  call LoadPluginFile('~/.vim/plugins')
  call LoadPluginFile('~/.vim/plugins.local')
  call plug#end()
]]

vim.cmd("set signcolumn=yes")
vim.cmd("colorscheme solarized")
vim.cmd("set cursorline")

vim.cmd('source ~/.vimrc.common')

vim.diagnostic.config({ virtual_text = false })

vim.opt.listchars = {
  tab = "  ",
}

local lsp_util = require("lsp_util")

vim.api.nvim_create_user_command(
  'ApplyImports',
  function(opts)
    local client = lsp_util.get_lsp_client()

    if client == nil then
      return
    end

    local caps = client.server_capabilities

    local codeActionProvider = caps["codeActionProvider"]

    if codeActionProvider == nil then
      return
    end

    local codeActionKinds = codeActionProvider["codeActionKinds"]

    if codeActionKinds == nil then
      return
    end

    if vim.list_contains(codeActionKinds, "source.organizeImports") == false then
      return
    end

    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
  end,
  {}
)

vim.api.nvim_create_user_command(
  'Format',
  function(opts)
    local tryLspFormat = function()
      local client = lsp_util.get_lsp_client()

      if client == nil then
        return false
      end

      local caps = client.server_capabilities

      if caps["documentFormattingProvider"] ~= true then
        return false
      end

      vim.lsp.buf.format{async = false}

      return true
    end

    if tryLspFormat() == false then
      vim.cmd("call FormatViaEqualsPrg()")
    end
  end,
  {}
)
 
 vim.api.nvim_create_user_command(
   'ApplyImportsAndFormat',
   function(opts)
     vim.cmd.ApplyImports()
     vim.cmd.Format()
   end,
   {}
 )

vim.api.nvim_create_user_command(
  'Test',
  function(opts)
    if #vim.lsp.get_active_clients() == 0 then
      vim.cmd("call TestViaTestPrg()")
    else
      vim.cmd.Echo("Not implemented")
    end
  end,
  {}
)

vim.api.nvim_create_user_command(
  'Build',
  function(opts)
    if #vim.lsp.get_active_clients() == 0 then
      vim.cmd("make")
    else
      vim.diagnostic.setqflist()
    end
  end,
  {}
)

local function set_keymaps(map)
  local opts = { noremap=true, silent=true }
  for i, v in ipairs(map) do
    vim.keymap.set(v[1], v[2], v[3], opts)
  end
end

set_keymaps{
  {'n', '<leader>f', vim.cmd.ApplyImportsAndFormat},
  {'n', '<leader>b', vim.cmd.Build},
  {'n', '<leader>t', vim.cmd.Test},
  {'n', '<C-k>', vim.lsp.buf.hover},
}
-- buf_set_keymaps({
--   {'n', '<leader>f', '<Cmd>lua vim.cmd.ApplyImportsAndFormat()<CR>'},
--   {'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>'},
--   {'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>'},
--   {'n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>'},
--   {'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>'},
--   {'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>'},
--   {'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>'},
--   {'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>'},
--   {'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'},
--   {'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>'},
--   {'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>'},
--   {'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>'},
--   {'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'},
--   {'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'},
--   {'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'},
--   {'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>'},
-- })
