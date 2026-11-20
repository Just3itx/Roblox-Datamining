-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local getBaseTileMediaCorners = require(script.Parent.getBaseTileMediaCorners)
local useTokens = require(Foundation.Providers.Style.useTokens)

return React.memo(function(tbl1) -- name: BaseTileMediaCorner
    local var1 = useTokens()
    return React.createElement("UICorner", getBaseTileMediaCorners(var1, tbl1.isContained))
end)
