-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local None = Dash.None

local context = React.createContext(None)

return {
    Provider = context.Provider,
    useStyleSheet = function()
        local var1 = React.useContext(context)
        return if var1 == None then nil else var1
    end
}
