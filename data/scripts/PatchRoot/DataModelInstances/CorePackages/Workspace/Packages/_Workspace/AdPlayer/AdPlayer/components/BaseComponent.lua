-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local AdPlayerParent = script:FindFirstAncestor("AdPlayer").Parent
local React = require(AdPlayerParent.React)
local FoundationProvider = require(AdPlayerParent.Foundation).FoundationProvider

local Localization = require(AdPlayerParent.InExperienceLocales).Localization
local LocalizationProvider = require(AdPlayerParent.Localization).LocalizationProvider

local localization = Localization.new(LocalizationService.RobloxLocaleId)

return function(arg1)
    return React.createElement(
        LocalizationProvider,
        { localization = localization },
        {
            foundationProvider = React.createElement(FoundationProvider, {}, arg1.children)
        }
    )
end
