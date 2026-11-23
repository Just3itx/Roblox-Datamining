-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local matchAllRegex = require(script.Parent.matchAllRegex)
local Cryo = require(scriptParentParent.Cryo)
local RegExp = require(scriptParentParent.RegExp)

local StringTrim = require(scriptParentParent.StringUtilities).StringTrim

local Regex = require(script.Parent.Regex)
local _Types = require(script.Parent.Types)
local Constants = require(script.Parent.Constants)

local tbl1 = {
    protocolPatterns = { "https?" },
    protocolStrict = false,
    subdomainPatterns = { "www" },
    subdomainStrict = true,
    domainsPatterns = { Constants.ANY_DOMAIN_PATTERN },
    pathPatterns = nil,
    trimPunctuation = false
}

local module = {}
module.__index = module

function module.new(arg1)
    local var1 = Cryo.Dictionary.union(tbl1, arg1 or {})

    local var2 = Regex.oneOf(var1.protocolPatterns) .. Regex.COLON .. Regex.SLASH .. Regex.SLASH
    local var3 = Regex.oneOf({ Regex.negativeLookbehind(Regex.ALPHANUMERIC), var2 })
    local var4 = Regex.negativeLookahead(var2)

    local var5 = Regex.oneOf(var1.subdomainPatterns) .. Regex.DOT
    local var6 = Regex.oneOf(var1.domainsPatterns)

    local var7 = if var1.pathPatterns == nil then "" else Regex.oneOf(var1.pathPatterns)
    local var8 = Regex.zeroOrMore({ Regex.SLASH .. Regex.oneOrMore(var4 .. Constants.PATH_CHAR) }) .. Regex.zeroOrOneOf(Regex.SLASH)

    local var9 = Regex.zeroOrOneOf(Regex.QUESTION .. Regex.zeroOrMore(var4 .. Constants.QUERY_CHAR))
    local var10 = Regex.zeroOrOneOf(Regex.HASH .. Regex.zeroOrMore(var4 .. Constants.FRAGMENT_CHAR))

    local var11 = Regex.oneOf({ Regex.lookahead(var2), Regex.negativeLookahead(Regex.ALPHANUMERIC), Regex.STRING_END })

    local capture = Regex.capture

    if var1.protocolStrict then
        var3 = var2
    end

    local var12 = capture(var3) .. Regex.capture(if var1.subdomainStrict then Regex.oneOf(var5) else Regex.zeroOrOneOf(var5)) .. Regex.capture(var6) .. Regex.capture(Regex.capture(var7) .. var8) .. Regex.capture(var9) .. Regex.capture(var10) .. var11
    local tbl2 = {
        _urlPattern = RegExp(var12, "m"),
        _trimPunctuation = var1.trimPunctuation,
        match = module.match
    }
    setmetatable(tbl2, module)
    return tbl2
end

function module.default()
    return module.new(tbl1)
end

function module.match(tbl2, str1: string)
    local tbl3 = {}
    local num1 = 0
    local success, result = pcall(function()
        for _, value in (matchAllRegex(str1:lower(), tbl2._urlPattern)) do
            local startIndex = num1 + value.index
            local var2 = startIndex + #value.matchedText - 1
            num1 = var2
            if tbl2._trimPunctuation and not value.matchedText:match("%b()$") then
                local var3 = StringTrim(value.matchedText, "%?%.%!%,%;%:%(%)", { right = true })
                if var3 ~= value.matchedText then
                    value = matchAllRegex(var3, tbl2._urlPattern)[1]
                end

                var2 = startIndex + #var3 - 1
            end

            local var3, var4, domain, var6, matchedPath, var8, var9 = unpack(value.capturedGroups)
            local fullText = str1:sub(startIndex, var2)
            local num2 = #var3 + 1 + #var4 + #domain
            local num3 = num2 + #var6
            local num4 = num3 + #var8
            local path = fullText:sub(num2, num3 - 1)
            local str4 = fullText:sub(num3, num4 - 1)
            local str5 = fullText:sub(num4, num4 + #var9 - 1)

            table.insert(tbl3, {
                startIndex = startIndex,
                endIndex = var2,
                matchedPath = matchedPath,
                url = {
                    fullText = fullText,
                    protocol = StringTrim(var3, ":/", { right = true }),
                    subdomain = StringTrim(var4, ".", { right = true }),
                    domain = domain,
                    path = path,
                    query = if str4 == "" then nil else StringTrim(str4, "?", { left = true }),
                    fragment = if str5 == "" then nil else StringTrim(str5, "#", { left = true })
                }
            })
        end
        return tbl3
    end)

    if success then
        return result or {}
    end

    warn("UrlMatcher:match failed: " .. tostring(result))
    return {}
end

return module
