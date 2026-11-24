-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)

local getIconRichText = Foundation.Utility.getIconRichText
local IconName = Foundation.Enums.IconName

local FFlagAbuseReportTranslateColorWrapper = require(GenericAbuseReporting.Flags.FFlagAbuseReportTranslateColorWrapper)
local FFlagUpdateTranslateInReportRevamp = SharedFlags.FFlagUpdateTranslateInReportRevamp

local function getWrappedText(tbl1, str1: string)
    local var1 = "{" .. tbl1.type .. "Start}"
    local var2 = "{" .. tbl1.type .. "End}"

    if tbl1.type == "link" then
        if str1:find(var1) == nil or str1:find(var2) == nil then
            return str1, nil
        end

        return string.gsub(str1, `{var1}(.-){var2}`, "%1 " .. getIconRichText(IconName.ArrowUpRightFromSquare)), tbl1
    elseif tbl1.type == "strong" then
        local var3 = string.gsub(str1, var1, "<b>")
        return string.gsub(var3, var2, "</b>"), nil
    end
    warn("Unknown wrapper type: " .. tostring(tbl1.type))
    return str1, nil
end

local function getWrappedTextByKey(str1: string, tbl1, str2: string, str3: string?, bool1: boolean?)
    local var1 = string.gsub(str1, "%p", "%%%0")
    local var2 = "{" .. var1 .. "Start}"
    local var3 = "{" .. var1 .. "End}"

    if tbl1.type ~= "link" then
        if tbl1.type ~= "strong" then
            return str2, nil
        end

        local var4 = string.gsub(str2, var2, "<b>")
        return string.gsub(var4, var3, "</b>"), nil
    end

    if str2:find(var2) == nil or str2:find(var3) == nil then
        return str2, nil
    end
    local var4 = (if bool1 then "<u>%1</u>" else "%1") .. " " .. getIconRichText(IconName.ArrowUpRightFromSquare)
    if tbl1.variant == "link" and str3 then
        var4 = `<font color="{str3}">{var4}</font>`
    end
    return string.gsub(str2, `{var2}(.-){var3}`, var4), tbl1
end

local str1 = if FFlagAbuseReportTranslateColorWrapper then "[%w_%.%-]+" else "%w+"
local str2 = "{" .. str1 .. "Start}"
local str3 = "{" .. str1 .. "End}"

local function stripWrapperTags(str4: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (str4:gsub(str2 .. "(.-)(" .. str3 .. ")", "%1"):gsub(str2, ""):gsub(str3, ""))
end

local var1 = nil

local function resolveParams(tbl1, params)
    if params == nil then
        return nil
    end

    local result = ({})
    for k, param in pairs(params) do
        if type(param) == "string" then
            result[k] = param
        else
            result[k] = var1(tbl1, param)
        end
    end
    return result
end

var1 = function(tbl1, arg1)
    if arg1 == nil then
        return ""
    end

    if type(arg1) == "string" then
        return arg1
    end

    local translate = arg1["$translate"]
    local params = arg1.params
    local var2 = if FFlagUpdateTranslateInReportRevamp then resolveParams(tbl1, params) else nil
    local var3 = tbl1[translate] or translate

    if FFlagUpdateTranslateInReportRevamp and var2 ~= nil then
        var3 = var3:gsub("{(.-)}", var2)
    elseif params ~= nil then
        var3 = var3:gsub("{(.-)}", params)
    end

    return (stripWrapperTags(var3))
end

return {
    mergeTranslationParams = function(arg1, tbl1)
        if type(arg1) == "string" then
            return arg1
        end

        local params = ({})
        if arg1.params then
            for k, param in pairs(arg1.params) do
                params[k] = param
            end
        end
        for k, value in pairs(tbl1) do
            params[k] = value
        end
        return {
            ["$translate"] = arg1["$translate"],
            params = params,
            wrappers = arg1.wrappers
        }
    end,
    translateIntoString = var1,
    translateIntoRichTextString = function(tbl1, arg1, str4: string?, bool1: boolean?)
        if arg1 == nil then
            return "", nil
        elseif type(arg1) == "string" then
            return arg1, nil
        elseif type(arg1) ~= "table" then
            return tostring(arg1), nil
        else
            local translate = arg1["$translate"]
            if not translate or type(translate) ~= "string" then
                return "", nil
            end

            local params = arg1.params
            local var2 = if FFlagUpdateTranslateInReportRevamp then resolveParams(tbl1, params) else nil
            local var3 = tbl1[translate] or translate
            local var4 = nil

            if FFlagUpdateTranslateInReportRevamp and var2 ~= nil then
                var3 = var3:gsub("{(.-)}", var2)
            elseif params ~= nil then
                var3 = var3:gsub("{(.-)}", params)
            end

            if FFlagAbuseReportTranslateColorWrapper then
                if arg1.wrappers then
                    for k, wrapper in pairs(arg1.wrappers) do
                        local var5
                        var3, var5 = getWrappedTextByKey(k, wrapper, var3, str4, bool1)

                        if var5 ~= nil and var4 == nil then
                            var4 = var5
                        end
                    end
                end

                return stripWrapperTags(var3), var4
            end

            if arg1.wrappers then
                for _, wrapper in pairs(arg1.wrappers) do
                    local var5
                    var3, var5 = getWrappedText(wrapper, var3)

                    if var5 ~= nil and var4 == nil then
                        var4 = var5
                    end
                end
            end

            return var3, var4
        end
    end
}
