-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local PreferencesContext = require(scriptParent.PreferencesContext)

local React = require(FoundationParent.React)

local function usePreferences()
    return (React.useContext(PreferencesContext))
end

return usePreferences
