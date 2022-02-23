local vim = vim
local utils = require('rust-tools.utils.utils')

local M = {}

local function get_params()
    local position_params = vim.lsp.util.make_position_params()
    local params = {
        textDocument = position_params.textDocument,
        positions = {position_params.position}
    }
    return params
end

local function handler(_, result, ctx)
    if result == nil then return end
    local _, start = next(result)
    local location = {
        uri = ctx.params.textDocument.uri,
        range = {["start"] = start}
    }
    vim.lsp.util.jump_to_location(location, vim.lsp
                                      .get_client_by_id(ctx.client_id)
                                      .offset_encoding)
end

function M.matching_brace()
    utils.request(0, 'experimental/matchingBrace', get_params(), handler)
end

return M
