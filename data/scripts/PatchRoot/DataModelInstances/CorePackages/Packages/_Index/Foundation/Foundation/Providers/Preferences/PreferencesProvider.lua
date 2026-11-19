-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local PreferencesContext = require(scriptParent.PreferencesContext)

local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    preferredTextSize = Enum.PreferredTextSize.Medium,
    preferredTransparency = 1,
    reducedMotion = false,
    scale = 1
}

local function PreferencesProvider(arg1)
    local value = React.useMemo(function()
        return withDefaults({
            preferredTextSize = arg1.preferredTextSize,
            preferredTransparency = arg1.preferredTransparency,
            reducedMotion = arg1.reducedMotion
        }, tbl1)
    end, { arg1.preferredTextSize, arg1.preferredTransparency, arg1.reducedMotion })

    return React.createElement(PreferencesContext.Provider, { value = value }, arg1.children)
end

return PreferencesProvider
