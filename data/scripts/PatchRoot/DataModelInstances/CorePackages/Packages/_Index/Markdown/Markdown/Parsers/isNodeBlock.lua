-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local NodeType = require(Markdown.Enums.NodeType)
local _Types = require(Markdown.Types)

local function isNodeBlock(arg1): boolean
    return not (arg1.name == "TAG") and (arg1.type == NodeType.Block or arg1.type == NodeType.TextBlock)
end

return isNodeBlock
