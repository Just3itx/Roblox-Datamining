-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local useMemo = require(AuthCommonParent.React).useMemo

local useCapturedAuditContent = require(AuthCommon.Stores.AuditContentContext.AuditContentContext).useCapturedAuditContent

local GetFFlagEnableAuditSystem = require(AuthCommon.Flags.GetFFlagEnableAuditSystem)

local function parseTranslationKey(translationKey: string): (string, string)
    if not translationKey or translationKey == "" then
        return "", ""
    end
    local tbl1 = string.split(translationKey, ".")
    if not (#tbl1 >= 3) then
        return "", translationKey
    end

    local str1 = tbl1[1] .. "." .. tbl1[2]
    local tbl2 = {}
    for i = 3, #tbl1 do
        table.insert(tbl2, tbl1[i])
    end
    return str1, table.concat(tbl2, ".")
end

local function RegisterAuditContent(tbl1)
    if not GetFFlagEnableAuditSystem() then
        return nil
    end

    local translationKey = tbl1.translationKey
    local translatedSourceString = tbl1.translatedSourceString
    local parameters = tbl1.parameters

    local var1 = useMemo(function()
        if not (translationKey and translatedSourceString) then
            return nil
        end

        local translationNamespace, str1 = parseTranslationKey(translationKey)

        return if translationNamespace == "" then nil else {
            translationKey = str1,
            translationNamespace = translationNamespace,
            translatedSourceString = translatedSourceString,
            parameters = parameters
        }
    end, { translationKey, translatedSourceString, parameters })

    useCapturedAuditContent(translationKey, var1)

    return nil
end

return RegisterAuditContent
