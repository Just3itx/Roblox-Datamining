-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StyleParent = script:FindFirstAncestor("Style").Parent
local ArgCheck = require(StyleParent.ArgCheck)
local Dash = require(StyleParent.Dash)
local React = require(StyleParent.React)
local DesignTokenContext = require(script.Parent.DesignTokenContext)

local function useDesignTokens(func1: ((...any) -> (...any))?)
    local var1 = React.useContext(DesignTokenContext)
    local var2 = func1 or Dash.identity

    ArgCheck.assert(var1, "Design Tokens not found, ensure AppStyleProvider has been configured correctly.")

    return var2(var1)
end

return useDesignTokens
