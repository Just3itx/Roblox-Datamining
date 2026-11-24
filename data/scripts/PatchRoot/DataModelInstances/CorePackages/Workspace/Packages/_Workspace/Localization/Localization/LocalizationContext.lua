-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.getBaseLanguage(arg1)
    return arg1:match("^(%w+)[-_]")
end

function module.new(_translations)
    local tbl1 = { _translations = _translations }

    setmetatable(tbl1, module)

    return tbl1
end

function module:addTranslations(_translations)
    self._translations = _translations
end

function module.getRelevantLanguages(str1: string): {string}
    local relevantLanguages = {}

    table.insert(relevantLanguages, str1)

    local baseLanguage = module.getBaseLanguage(str1)
    if baseLanguage then
        table.insert(relevantLanguages, baseLanguage)
    end

    table.insert(relevantLanguages, "en-us")
    return relevantLanguages
end

function module:_getSourceString(arg1, arg2)
    local _translation = self._translations[arg1]

    return if _translation then _translation[arg2] else nil
end

function module.getString(arg1, arg2, arg3, arg4)
    local var1 = arg1:_getSourceString(arg2, arg3)

    local baseLanguage = module.getBaseLanguage(arg2)
    local var2 = if baseLanguage then arg1:_getSourceString(baseLanguage, arg3) else nil
    local var3 = arg1:_getSourceString("en-us", arg3)

    local var4 = var1 or var2 or var3

    if not var4 then
        local str1 = ("Couldn't find value for translation key %q!\nTried these languages: %s, %s, %s"):format(
            arg3,
            arg2,
            baseLanguage,
            "en-us"
        )
        error(str1, 2)
    end

    if arg4 then
        return (var4:gsub("{(.-)}", arg4))
    end
    return var4
end

return module
