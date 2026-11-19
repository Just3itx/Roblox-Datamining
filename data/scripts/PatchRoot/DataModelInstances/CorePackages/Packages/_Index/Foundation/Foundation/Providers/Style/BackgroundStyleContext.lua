-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:00:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local _Types = require(Foundation.Components.Types)
local useTokens = require(Foundation.Providers.Style.useTokens)

local context = React.createContext(nil)

function useBackgroundStyle()
    local var1 = React.useContext(context)
    local var2 = useTokens()

    if var1 == nil then
        return var2.Color.Surface.Surface_0
    end

    return var1
end

return {
    useBackgroundStyle = useBackgroundStyle,
    Provider = context.Provider
}
