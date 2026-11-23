-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _Signals = require(AppChatParent.Signals)
local createSessionScopedSignal = require(AppChatParent.SignalsUtils).createSessionScopedSignal

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

local function createUnreadMessageCountStore()
    local getUnreadMessageCount, var2 = createSessionScopedSignal(0)

    return {
        getUnreadMessageCount = getUnreadMessageCount,
        receivedConversationMetadata = function(arg1)
            if arg1 and arg1.global_unread_message_count then
                var2(arg1.global_unread_message_count)
            end
        end,
        reset = function()
            var2(0)
        end
    }
end
return createUnreadMessageCountStore
