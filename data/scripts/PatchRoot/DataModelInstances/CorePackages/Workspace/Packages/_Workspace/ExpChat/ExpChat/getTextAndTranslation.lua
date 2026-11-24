-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local isWhiteSpaceOnly = require(ExpChat.isWhiteSpaceOnly)
local getFFlagExpChatProtectedChatInternalAPIs = require(ExpChatParent.SharedFlags).getFFlagExpChatProtectedChatInternalAPIs

return function(arg1)
    local str1 = ""
    local str2 = ""
    local var1 = if arg1 then if getFFlagExpChatProtectedChatInternalAPIs() then arg1.TextInternal else arg1.Text else nil

    if not var1 or isWhiteSpaceOnly(var1) then
        var1 = str1
    elseif getFFlagExpChatProtectedChatInternalAPIs() then
        str2 = arg1.TranslationInternal
    else
        str2 = arg1.Translation
    end

    if arg1 and arg1.WasRewritten and arg1.RewrittenText and not isWhiteSpaceOnly(arg1.RewrittenText) then
        var1 = arg1.RewrittenText
        str2 = arg1.RewrittenTranslation
    end

    return var1, str2
end
