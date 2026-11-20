-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UtilsParent = script:FindFirstAncestor("Utils").Parent

local _Types = require(UtilsParent.Types)

local NodeTypeConfig = require(script.Parent.NodeTypeConfig)

local function getNodeTypeConfig(arg1)
    local var1 = NodeTypeConfig[arg1.type]
    if var1 then
        return var1
    end

    warn(`No node type config found for node: {arg1.name} {arg1.text} of type: {arg1.type}`)
    return nil
end

return getNodeTypeConfig
