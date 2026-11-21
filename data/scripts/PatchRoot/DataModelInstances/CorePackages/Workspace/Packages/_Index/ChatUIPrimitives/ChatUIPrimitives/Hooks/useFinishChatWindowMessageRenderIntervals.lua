-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local React = require(ChatUIPrimitivesParent.React)

local ExpChatPerfTracker = require(ChatUIPrimitives.Telemetry.ExpChatPerfTracker)

local function useFinishChatWindowMessageRenderIntervals(func1: (...any) -> (...any))
    return React.useCallback(function()
        local messageId = func1() or "UNKNOWN_MESSAGE_ID"
        ExpChatPerfTracker.finish(ExpChatPerfTracker.Events.MessageReceiveToWindowRenderInterval, { messageId = messageId })

        ExpChatPerfTracker.finish(ExpChatPerfTracker.Events.MessageSendToWindowRenderInterval, { messageId = messageId })
    end, { func1 })
end

return useFinishChatWindowMessageRenderIntervals
