-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ConversationOverlay = require(AppChatParent.AppChatNetworking).Constants.ConversationOverlay
local Logger = require(AppChat.Logger)
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

local tbl1 = {
    [ConversationOverlay.TrustedConnectionCreated] = true,
    [ConversationOverlay.AddTrustedConnectionU18] = true,
    [ConversationOverlay.TrustedConnectionRequestU18] = true
}

return function(str1: string): boolean
    local var1 = useSelector(function(arg1)
        return getDeepValue2(arg1, `ChatAppReducer.Modals.conversationOverlays.{str1}.modal_variant`) or ""
    end)
    local var2 = tbl1[var1]
    if not var2 and var1 ~= ConversationOverlay.None and var1 ~= "" then
        Logger:warning(`Unsupported ConversationOverlay modal variant: {var1} for conversationId: {str1}`)
    end

    return not not var2
end
