local vim = vim
local utils = require('rust-tools.utils.utils')

local M = {}

local function get_params()
    return vim.lsp.util.make_position_params()
end

local function handler(_, result, ctx)
    if result == nil then return end
	vim.lsp.util.apply_text_edits(result, ctx.bufnr, vim.lsp
                                      .get_client_by_id(ctx.client_id)
                                      .offset_encoding)
end

function M.on_enter()
	utils.request(0, "experimental/onEnter", get_params(), handler)
end

return M
