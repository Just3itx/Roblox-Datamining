-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceLocalesParent = script:FindFirstAncestor("InExperienceLocales").Parent

local LocalizationContext = require(InExperienceLocalesParent.Localization).LocalizationContext
local Signal = require(InExperienceLocalesParent.AppCommonLib).Signal

local Locales = game:GetService("CoreGui").RobloxGui.Modules.Common:FindFirstChild("Locales")

local function loadTables(locale: string)
    if not Locales then
        error("ERROR: Locales tables does not exist")
    end

    local relevantLanguages = LocalizationContext.getRelevantLanguages(locale)
    local result = ({})
    for _, value in ipairs(relevantLanguages) do
        local var1 = Locales:FindFirstChild(value)
        if var1 then
            result[value] = require(var1)
        end
    end
    return result
end

local module = ({})
module.__index = module

function module.new(locale: string)
    local tbl1 = {
        locale = locale,
        changed = Signal.new(),
        localizationContext = LocalizationContext.new((loadTables(locale)))
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:SetLocale(locale: string)
    self.locale = locale
    local tbl1 = loadTables(locale)
    self.localizationContext:addTranslations(tbl1)
    self.changed:fire()
end

function module:GetLocale()
    return self.locale
end

function module:Format(str1: string, tbl1)
    if not str1 then
        error("ERROR: NO STRING FOR KEY")
    end

    return (self.localizationContext:getString(self.locale, str1, tbl1))
end

return module
