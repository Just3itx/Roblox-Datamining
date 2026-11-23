-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local addMessage = require(script.Parent.Parent.Parent.Utils.addMessage)

local RobloxUrlMap = require(script.Parent.RobloxUrlMap)
local Constants = require(script.Parent.Constants)
local FFlagAppChatFullPlaintextBeforeGameCards = require(AppChat.Flags.FFlagAppChatFullPlaintextBeforeGameCards)
local FFlagAppChatShareLinkV2Fallbacks = require(AppChat.Flags.FFlagAppChatShareLinkV2Fallbacks)

local UrlMatching = require(AppChatParent.UrlMatching)
local Cryo = require(AppChatParent.Cryo)
local AppCommonLibText = require(AppChatParent.AppCommonLib).Text

local UrlProcessor = UrlMatching.UrlProcessor
local Constants2 = UrlMatching.Constants
local Regex = UrlMatching.Regex

local var1 = Regex.DASH .. Constants.LOCALE_COUNTRY_PATTERN

local var2 = Regex.zeroOrOneOf(Regex.SLASH .. Constants.LOCALE_LANGUAGE_PATTERN .. Regex.zeroOrOneOf(var1))
local domainsPatterns = Cryo.List.map(Constants.ROBLOX_DOMAIN_PATTERNS, function(str1: string)
    return str1 .. var2
end)
local urlProcessor = UrlProcessor.new({
    domainsPatterns = domainsPatterns,
    protocolStrict = false,
    subdomainPatterns = { Constants2.ANY_DOMAIN_NAME },
    subdomainStrict = false,
    trimPunctuation = true
}, RobloxUrlMap)

local function prepareMatchesForMessages(tbl1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return Cryo.List.filterMap(tbl1, function(arg1)
        local result = arg1.result
        if result == nil then
            return nil
        elseif result.shareLink and result.shareLink.version == 2 then
            return Cryo.Dictionary.join(arg1, {
                result = Cryo.Dictionary.join(
                    result,
                    {
                        shareLink = Cryo.Dictionary.join(result.shareLink, { url = str1:sub(arg1.startIndex, arg1.endIndex) })
                    }
                )
            })
        end
        return arg1
    end)
end

return function(str1: string)
    local tbl1 = {}
    local var4 = urlProcessor:process(str1)

    if FFlagAppChatShareLinkV2Fallbacks then
        var4 = prepareMatchesForMessages(var4, str1)
    end

    if FFlagAppChatFullPlaintextBeforeGameCards then
        local var5 = addMessage(tbl1, str1)
        for _, value in var4 do
            table.insert(var5, value.result)
        end
        return var5
    end
    if var4 == nil or #var4 == 0 then
        return addMessage(tbl1, str1)
    end

    local num1 = 1
    for _, value in var4 do
        tbl1 = addMessage(tbl1, AppCommonLibText.Trim(str1:sub(num1, value.startIndex - 1)))

        table.insert(tbl1, value.result)
        num1 = value.endIndex + 1
    end

    return addMessage(tbl1, AppCommonLibText.Trim(str1:sub(num1)))
end
