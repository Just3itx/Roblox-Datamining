-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Signals = require(AppChatParent.Signals)

local function createReplyingToStore()
    local getMessageId, var2 = Signals.createSignal(nil)

    return {
        getMessageId = getMessageId,
        setReplyingTo = function(str1: string)
            var2(str1)
        end,
        clear = function()
            var2(nil)
        end
    }
end
return createReplyingToStore
