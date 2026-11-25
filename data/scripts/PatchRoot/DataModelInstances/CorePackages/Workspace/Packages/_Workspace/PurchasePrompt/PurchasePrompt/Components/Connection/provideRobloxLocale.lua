-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local LocalizationContextProvider = require(script.Parent.LocalizationContextProvider)

local Localization = require(PurchasePromptParent.RobloxAppLocales).Localization

return function(arg1)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    return Roact.createElement(LocalizationContextProvider, { localizationContext = localization }, { PurchasePromptApp = arg1() })
end
