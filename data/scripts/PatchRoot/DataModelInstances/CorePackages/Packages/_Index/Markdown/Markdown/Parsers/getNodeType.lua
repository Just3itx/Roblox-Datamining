-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local NodeType = require(Markdown.Enums.NodeType)

local function getNodeType(str1: string, arg1)
    local var1 = arg1.nodeConfiguration[str1]
    if var1 then
        return var1.type
    end
    warn(`No node configuration found for {str1}`)
    return NodeType.Block
end

return getNodeType
