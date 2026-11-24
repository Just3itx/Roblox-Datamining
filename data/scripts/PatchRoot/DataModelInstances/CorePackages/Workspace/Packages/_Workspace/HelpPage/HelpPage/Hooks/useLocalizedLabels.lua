-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local React = require(scriptParentParentParent.React)
local Localization = require(scriptParentParentParent.Localization)
local useLocalization = Localization.Hooks.useLocalization
local LocalizationRoactContext = Localization.LocalizationRoactContext
local FFlagHelpPageCCL = require(scriptParentParent.Flags.FFlagHelpPageCCL)

local function useTranslator()
    local var1, var2 = React.useState(nil)

    React.useEffect(function()
        local localPlayer = Players.LocalPlayer
        if localPlayer == nil then
            return
        end

        local bool1 = false
        task.spawn(function()
            local success, result = pcall(function(): Translator
                return LocalizationService:GetTranslatorForPlayerAsync(localPlayer)
            end)
            if success and not bool1 then
                var2(result)
            end
        end)

        return function()
            bool1 = true
        end
    end, {})

    return var1
end

local function getExperienceLocalizedLabel(translator, str1: string)
    local success, result = pcall(function()
        return translator:FormatByKey(str1)
    end)
    if success and type(result) == "string" and result ~= "" then
        return result
    end

    local success2, result2 = pcall(function()
        return translator:Translate(game, str1)
    end)
    return if success2 and type(result2) == "string" and result2 ~= "" then result2 else nil
end

local function useLocalizedLabels(tbl1, arg1)
    if not FFlagHelpPageCCL then
        return useLocalization(tbl1)
    end

    local var1 = React.useContext(LocalizationRoactContext)
    local genericAction = useLocalization({ genericAction = "InGame.HelpMenu.GenericAction" }).genericAction
    local var2 = useTranslator()
    local var3 = arg1 or var2
    local result = ({})

    for value, value2 in tbl1 do
        if value2 == "" then
            result[value] = genericAction
        else
            local success, result2 = pcall(function()
                return var1:Format(value2)
            end)
            if success and type(result2) == "string" and result2 ~= "" then
                result[value] = result2
            elseif var3 ~= nil then
                local experienceLocalizedLabel = getExperienceLocalizedLabel(var3, value2)

                if experienceLocalizedLabel == nil then
                    result[value] = value2
                else
                    result[value] = experienceLocalizedLabel
                end
            else
                result[value] = value2
            end
        end
    end

    return result
end

return useLocalizedLabels
