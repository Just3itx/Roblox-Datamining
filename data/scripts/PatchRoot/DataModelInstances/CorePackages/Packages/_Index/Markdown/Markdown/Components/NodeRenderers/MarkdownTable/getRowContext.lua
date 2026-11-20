-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")

local mergeContexts = require(Markdown.Utils.mergeContexts)
local _Types = require(Markdown.Types)

local function getRowContext(arg1, arg2)
    if arg1.name ~= "TABLE_HEADER" then
        return arg2
    end

    return mergeContexts(arg2, { textStyles = { bold = true } })
end

return getRowContext
