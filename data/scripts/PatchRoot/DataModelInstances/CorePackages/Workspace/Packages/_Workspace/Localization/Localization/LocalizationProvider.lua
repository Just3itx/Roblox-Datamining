-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationParent = script:FindFirstAncestor("Localization").Parent

local React = require(LocalizationParent.React)
local LocalizationRoactContext = require(script.Parent.LocalizationRoactContext)

local function LocalizationProvider(arg1)
    return React.createElement(LocalizationRoactContext.Provider, { value = arg1.localization }, arg1.children)
end

return LocalizationProvider
