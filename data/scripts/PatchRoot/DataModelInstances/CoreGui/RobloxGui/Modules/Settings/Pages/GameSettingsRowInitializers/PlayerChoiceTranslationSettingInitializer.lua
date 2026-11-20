-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Utility = require(RobloxGui.Modules.Settings.Utility)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization

local tbl1 = { "On", "Off" }

return function(arg1, arg2, callback)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    local var1 = localization:Format("Translation.PlayerChoiceSettings.GameSettings.PlayerChoiceSettingLabel")
    local var2 = localization:Format("Translation.PlayerChoiceSettings.GameSettings.PlayerChoiceSettingDescription")

    local num1 = if LocalizationService:GetIsLoadingInternalTranslations() then 1 else 2
    local playerChoiceTranslationFrame, playerChoiceSettingLabel, playerChoiceSettingMode = Utility:AddNewRow(arg1, var1, "Selector", tbl1, num1, nil, var2)
    arg1.PlayerChoiceTranslationFrame = playerChoiceTranslationFrame
    arg1.PlayerChoiceSettingLabel = playerChoiceSettingLabel
    arg1.PlayerChoiceSettingMode = playerChoiceSettingMode

    arg1.PlayerChoiceTranslationFrame.LayoutOrder = arg2.PlayerChoiceTranslationFrame

    arg1.PlayerChoiceSettingMode.IndexChanged:connect(function(arg3)
        local newIsLoadingInternalTranslations = arg3 == 1
        local bool1 = num1 == 1

        LocalizationService:IsLoadingInternalTranslationsSettingChanged(newIsLoadingInternalTranslations)

        callback("player_choice_translation", bool1, newIsLoadingInternalTranslations)
    end)

    return arg1.PlayerChoiceTranslationFrame, arg1.PlayerChoiceSettingLabel, arg1.PlayerChoiceSettingMode
end
