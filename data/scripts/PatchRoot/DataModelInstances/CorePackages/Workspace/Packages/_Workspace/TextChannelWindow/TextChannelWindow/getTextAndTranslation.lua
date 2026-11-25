-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local getFFlagExpChatProtectedChatInternalAPIs = require(scriptParentParent.SharedFlags).getFFlagExpChatProtectedChatInternalAPIs
local isWhitespaceOnly = require(script.Parent.isWhitespaceOnly)

local function getTextAndTranslation(arg1)
    local var1 = if getFFlagExpChatProtectedChatInternalAPIs() then arg1.TextInternal else arg1.Text
    local var2 = if getFFlagExpChatProtectedChatInternalAPIs() then arg1.TranslationInternal else arg1.Translation
    local var3 = var1 and not isWhitespaceOnly(var1) and var1 or ""

    if arg1.WasRewritten and arg1.RewrittenText and not isWhitespaceOnly(arg1.RewrittenText) then
        local rewrittenTranslation = arg1.RewrittenTranslation
        local rewrittenText = arg1.RewrittenText
        if rewrittenTranslation and rewrittenTranslation ~= "" then
            return rewrittenText, rewrittenTranslation
        end

        return rewrittenText, nil
    elseif var2 and var2 ~= "" then
        return var3, var2
    else
        return var3, nil
    end
end
return getTextAndTranslation
