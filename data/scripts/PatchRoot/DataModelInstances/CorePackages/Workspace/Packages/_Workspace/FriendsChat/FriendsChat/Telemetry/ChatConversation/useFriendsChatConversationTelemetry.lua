-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)

local ChatConversationTelemetryEvents = require(FriendsChatParent.AppChat.ChatConversationTelemetryEvents)
local ChatConversationTelemetryLayer = require(FriendsChatParent.AppChat.ChatConversationTelemetryLayer)
local ConversationExitType = require(FriendsChatParent.AppChat.ConversationExitType)
local useTelemetry = require(FriendsChatParent.AppChat.useTelemetry)

local FFlagFriendsChatScreenExitLoadedMessageCount = require(FriendsChat.Flags.FFlagFriendsChatScreenExitLoadedMessageCount)

local function useFriendsChatConversationTelemetry(tbl1)
    local emit = useTelemetry(ChatConversationTelemetryLayer.Context).emit

    local var1 = React.useRef(emit)
    var1.current = emit
    local var2 = React.useRef(tbl1.getLoadedMessageCount)
    var2.current = tbl1.getLoadedMessageCount

    local conversationId = tbl1.conversationId

    React.useEffect(function()
        var1.current(ChatConversationTelemetryEvents.ScreenRendered, { loadedMessageCount = var2.current() })
    end, { conversationId })

    React.useEffect(function()
        return function()
            var1.current(ChatConversationTelemetryEvents.ScreenExit, {
                conversationExitType = ConversationExitType.Default,
                loadedMessageCount = if FFlagFriendsChatScreenExitLoadedMessageCount then var2.current() else nil
            })
        end
    end, {})

    return {
        fireInfoButtonClicked = React.useCallback(function()
            var1.current(ChatConversationTelemetryEvents.ConversationInfoBtnClicked, {})
        end, {})
    }
end

return useFriendsChatConversationTelemetry
