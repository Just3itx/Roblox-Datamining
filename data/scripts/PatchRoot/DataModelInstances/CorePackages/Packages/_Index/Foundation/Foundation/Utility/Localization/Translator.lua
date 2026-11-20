-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = script.Parent.Parent.Parent

local LocalizationService = require(scriptParentParentParent.Utility.Wrappers).Services.LocalizationService

local Constants = require(scriptParent.Constants)
local GeneratedTranslations = require(scriptParentParentParent.Generated.Translations.GeneratedTranslations)
local devAssert = require(scriptParentParentParent.Utility.devAssert)
local var1 = require(scriptParentParentParent.Utility.getMainGui)()
devAssert(var1 ~= nil, "MainGui not found")

local HttpService = game:GetService("HttpService")
local localizationTableName = Constants.LOCALIZATION_TABLE_NAME .. HttpService:GenerateGUID(false)

local function createFoundationLocalizationTable(parent): LocalizationTable
    local var3 = parent:FindFirstChild(localizationTableName)
    if var3 ~= nil and var3:IsA("LocalizationTable") then
        var3:SetEntries(GeneratedTranslations)
        return var3
    end

    local localizationTable = Instance.new("LocalizationTable")
    localizationTable.Name = localizationTableName
    localizationTable.Archivable = false
    localizationTable.SourceLocaleId = "en-us"
    localizationTable:SetEntries(GeneratedTranslations)
    localizationTable.Parent = parent
    return localizationTable
end

local localizationTable = createFoundationLocalizationTable(var1)

local tbl1 = ({})

local function getTranslatorForLocale(arg1)
    if localizationTable == nil or localizationTable.Parent == nil then
        localizationTable = createFoundationLocalizationTable(var1)
        tbl1 = {}
    end

    local var3 = tbl1[arg1]
    if var3 then
        return var3
    end

    local translator = var1:FindFirstChild(localizationTableName):GetTranslator(arg1)

    tbl1[arg1] = translator

    return translator
end

local function getTranslator() -- Luacid: Inlined by compiler; 1 call site recovered
    return (getTranslatorForLocale(LocalizationService.RobloxLocaleId))
end

local function formatByKeyWithFallback(arg1, arg2, arg3)
    local success, result = pcall(function()
        return arg3:FormatByKey(arg1, arg2)
    end)

    if success then
        return result
    elseif arg3.LocaleId == "zh-cjv" then
        return ""
    end
    return getTranslatorForLocale("en-us"):FormatByKey(arg1, arg2)
end

local module = {}

function module.FormatByKey(_, arg1, arg2)
    return formatByKeyWithFallback(arg1, arg2, (getTranslator()))
end

function module.FormatByKeyForLocale(_, arg1, arg2, arg3)
    return formatByKeyWithFallback(arg1, arg3, (getTranslatorForLocale(arg2)))
end

return module
