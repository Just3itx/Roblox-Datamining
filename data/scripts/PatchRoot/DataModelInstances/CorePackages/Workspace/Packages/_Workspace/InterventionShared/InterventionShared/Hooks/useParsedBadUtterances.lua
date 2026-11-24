-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local LocalPlayer = game:GetService("Players").LocalPlayer

local Cryo = require(InterventionSharedParent.Cryo)

local LocalizationService = game:GetService("LocalizationService")
local var1 = require(InterventionSharedParent.RobloxAppLocales).Localization.new(LocalizationService.RobloxLocaleId)
local useLocalization = require(InterventionSharedParent.Localization).Hooks.useLocalization

local _Types = require(InterventionShared.Utils.Types)

local function useParsedBadUtterances(tbl1, tbl2)
    local labelTranslationKey = if tbl2 then tbl2.labelTranslationKey else nil
    local shouldAddPlayerName = if tbl2 then tbl2.shouldAddPlayerName else nil
    local tbl3 = {}
    local tbl4 = ({})

    if labelTranslationKey and labelTranslationKey ~= "" then
        tbl4[labelTranslationKey] = "Feature.NotApproved." .. labelTranslationKey
    end

    for _, value in tbl1 do
        local utteranceText = value.utteranceText

        if LocalPlayer and shouldAddPlayerName then
            utteranceText = var1:Format("Feature.InExperienceIntervention.Label.Player", { username = LocalPlayer.Name, evidence = utteranceText })
        end

        table.insert(tbl3, utteranceText)

        tbl4[value.labelTranslationKey] = "Feature.NotApproved." .. value.labelTranslationKey
    end

    local var2 = useLocalization(tbl4)

    local tbl5 = ({})
    for value, _ in tbl4 do
        local var3 = var2[value]

        if var3 and var3 ~= "" then
            tbl5[var3] = true
        end
    end

    return {
        textItems = Cryo.List.reverse(tbl3),
        abuseTypes = Cryo.Dictionary.keys(tbl5)
    }
end

return useParsedBadUtterances
