-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local GuiService = game:GetService("GuiService")

local scriptParent = script.Parent
local Constants = require(scriptParent.Constants)
local GeneratedTranslations = require(scriptParent.GeneratedTranslations)

local function createUIBloxLocalizationTable(guiService: GuiService)
    if GuiService:FindFirstChild(Constants.LOCALIZATION_TABLE_NAME) then
        return
    end

    local localizationTable = Instance.new("LocalizationTable")
    localizationTable.Name = Constants.LOCALIZATION_TABLE_NAME
    localizationTable.Archivable = false
    localizationTable.SourceLocaleId = "en-us"
    localizationTable:SetEntries(GeneratedTranslations)
    localizationTable.Parent = guiService
end

createUIBloxLocalizationTable(GuiService)

local translator = GuiService.UIBloxLocalization:GetTranslator("en-us")

local tbl1 = ({})

local function getTranslatorForLocale(localeId: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = tbl1[localeId]
    if var1 then
        return var1
    end

    local translator2 = GuiService.UIBloxLocalization:GetTranslator(localeId)
    tbl1[localeId] = translator2

    return translator2
end

local function getTranslator() -- Luacid: Inlined by compiler; 1 call site recovered
    return getTranslatorForLocale(LocalizationService.RobloxLocaleId)
end

local function formatByKeyWithFallback(key: string, arg1, arg2)
    local success, result = pcall(function()
        return arg2:FormatByKey(key, arg1)
    end)

    if success then
        return result
    elseif arg2.LocaleId == "zh-cjv" then
        return ""
    end
    return translator:FormatByKey(key, arg1)
end

local module = {}

function module.FormatByKey(_, key, arg1)
    return formatByKeyWithFallback(key, arg1, (getTranslator()))
end

function module.FormatByKeyForLocale(_, key, localeId, arg1)
    return formatByKeyWithFallback(key, arg1, (getTranslatorForLocale(localeId)))
end

return module
