-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle

local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local FriendCountLabel = require(script.Parent.FriendCountLabel)
local MemberEntry = require(script.Parent.MemberEntry)
local GetSelectedUsersStore = require(AppChat.Stores.GetSelectedUsersStore)

return React.memo(function(tbl1) -- name: SelectedMembersBar
    local style = useStyle()
    local scrollingFrameRef = React.useRef(nil)

    local selectedUsersStore = GetSelectedUsersStore(false)
    local var3 = useSignalState(selectedUsersStore.getMaxSize())

    local var4 = React.useMemo(function()
        local result = {}
        for index = 1, var3 do
            result[`user-{index}`] = React.createElement(MemberEntry, { index = index, style = style })
        end

        return result
    end, { var3 })

    React.useEffect(function()
        if scrollingFrameRef.current then
            scrollingFrameRef.current.ScrollBarThickness = 0
            scrollingFrameRef.current.Selectable = false
        end
    end, { scrollingFrameRef })

    return React.createElement(
        Foundation.View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "row size-full-0 auto-y flex-y-fill padding-x-small gap-medium"
        },
        {
            FriendCountContainer = React.createElement(
                Foundation.View,
                { tag = "auto-xy padding-y-small", LayoutOrder = 1 },
                {
                    FriendCount = React.createElement(FriendCountLabel)
                }
            ),
            UserScrollBar = React.createElement(
                Foundation.ScrollView,
                {
                    tag = "fill auto-y",
                    LayoutOrder = 2,
                    scroll = {
                        scrollBarVisibility = Foundation.Enums.ScrollBarVisibility.None,
                        ScrollingDirection = Enum.ScrollingDirection.X,
                        AutomaticCanvasSize = Enum.AutomaticSize.XY
                    },
                    scrollingFrameRef = scrollingFrameRef
                },
                React.createElement(Foundation.View, { tag = "row size-full padding-x-xsmall gap-medium align-y-center" }, var4)
            )
        }
    )
end)
