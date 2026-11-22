-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local SignalsReact = require(scriptParentParent.SignalsReact)

local GetThemeBackgroundStore = require(scriptParent.Stores.GetThemeBackgroundStore)
local _ThemeBackgroundTypes = require(scriptParent.ThemeBackgroundTypes)

local function useThemeBackground()
    return SignalsReact.useSignalState(GetThemeBackgroundStore(false).getThemeBackground)
end

return useThemeBackground
