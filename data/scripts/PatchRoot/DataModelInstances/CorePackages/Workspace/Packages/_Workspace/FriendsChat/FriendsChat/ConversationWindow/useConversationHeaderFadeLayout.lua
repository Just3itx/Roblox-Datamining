-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

local ConversationHeaderFadeLayout = require(script.Parent.ConversationHeaderFadeLayout)
local getMessageFadeSequence = require(script.Parent.getMessageFadeSequence)

local function useConversationHeaderFadeLayout(tbl1)
    local transparencyValue = tbl1.transparencyValue
    local conversationId = tbl1.conversationId

    local headerHeight, var2 = React.useBinding(0)
    local var3, var4 = React.useBinding(0)
    local viewportHeight, var6 = React.useBinding(0)

    local onHeaderAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize.Y)
    end, {})
    local onMessageViewportAbsoluteSizeChanged = React.useCallback(function(arg1)
        var6(arg1.AbsoluteSize.Y)
    end, {})
    local onMessageCanvasPositionChanged = React.useCallback(function(vector2: Vector2, num1: number)
        var4(math.clamp(vector2.Y, 0, num1))
    end, {})

    local headerLayoutPadding = React.useMemo(function()
        return ConversationHeaderFadeLayout.getHeaderOverlapPadding(headerHeight)
    end, { headerHeight })
    local headerVisibleHeight = React.useMemo(function()
        return ConversationHeaderFadeLayout.getHeaderVisibleHeight(headerHeight, transparencyValue)
    end, { headerHeight, transparencyValue })
    local contentTopPadding = React.useMemo(function()
        return ConversationHeaderFadeLayout.getContentTopPadding(headerHeight, headerVisibleHeight, var3)
    end, { headerHeight, headerVisibleHeight, var3 })
    local messageFadeSequence = React.useMemo(function()
        return React.joinBindings(
            {
                headerHeight = headerHeight,
                headerVisibleHeight = headerVisibleHeight,
                viewportHeight = viewportHeight
            }
        ):map(
            function(tbl2)
                local var13 = if tbl2.headerHeight > 0 then tbl2.headerVisibleHeight / tbl2.headerHeight else 0

                return getMessageFadeSequence(tbl2.headerHeight, tbl2.viewportHeight, var13)
            end
        )
    end, { headerHeight, headerVisibleHeight, viewportHeight })
    local headerInteractable = React.useMemo(function()
        return ConversationHeaderFadeLayout.getHeaderInteractable(transparencyValue)
    end, { transparencyValue })

    React.useEffect(function()
        var4(0)
    end, { conversationId })

    return {
        onHeaderAbsoluteSizeChanged = onHeaderAbsoluteSizeChanged,
        onMessageViewportAbsoluteSizeChanged = onMessageViewportAbsoluteSizeChanged,
        onMessageCanvasPositionChanged = onMessageCanvasPositionChanged,
        headerHeight = headerHeight,
        headerLayoutPadding = headerLayoutPadding,
        headerVisibleHeight = headerVisibleHeight,
        contentTopPadding = contentTopPadding,
        messageFadeSequence = messageFadeSequence,
        headerInteractable = headerInteractable
    }
end

return useConversationHeaderFadeLayout
