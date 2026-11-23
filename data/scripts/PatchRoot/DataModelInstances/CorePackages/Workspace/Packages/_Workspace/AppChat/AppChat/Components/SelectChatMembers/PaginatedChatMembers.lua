-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)

local FlatList = require(AppChatParent.VirtualizedList).FlatList

local num1 = game:DefineFastInt("AppChatPerfChatMembersPaginationWindowSize", 2)

local num2 = game:DefineFastInt("AppChatPerfChatMembersPaginationInitialRender", 8)

local num3 = game:DefineFastInt("AppChatPerfChatMembersPaginationOnEndReachedUnits", 1)

local function keyExtractor(arg1, arg2): string
    return tostring(arg1 or arg2)
end

local style = { ScrollBarThickness = 0, Name = "PaginatedChatMembers", BackgroundTransparency = 1 }

local contentContainerStyle = { BackgroundTransparency = 1 }

return React.memo(function(tbl3) -- name: PaginatedChatMembers
    local ref = React.useRef(nil)

    React.useEffect(function()
        if not ref.current then
            return
        end

        local nativeScrollRef = ref.current:getNativeScrollRef()
        if nativeScrollRef and nativeScrollRef._nativeRef and nativeScrollRef._nativeRef.current then
            nativeScrollRef._nativeRef.current.Selectable = false
        end
    end, {})

    local windowSize = num1
    local initialNumToRender = num2
    local onEndReachedThreshold = num3

    local onEndReached = React.useCallback(function()
        if tbl3.fetchMoreFriends then
            tbl3.fetchMoreFriends()
        end
    end, { tbl3.fetchMoreFriends })

    return React.createElement(Foundation.View, { tag = "size-full col gap-small" }, {
        Header = if tbl3.headerText then React.createElement(Foundation.Text, {
            tag = "size-full-0 auto-y text-align-x-left text-align-y-bottom text-title-large padding-x-medium",
            Text = tbl3.headerText,
            LayoutOrder = 1
        }) else nil,
        ListContainer = React.createElement(Foundation.View, {
            LayoutOrder = 2,
            tag = "size-full-0 fill"
        }, {
            List = React.createElement(FlatList, {
                style = style,
                contentContainerStyle = contentContainerStyle,
                renderItem = tbl3.renderItem,
                data = tbl3.userIds,
                windowSize = windowSize,
                initialNumToRender = initialNumToRender,
                onEndReachedThreshold = onEndReachedThreshold,
                onEndReached = onEndReached,
                keyExtractor = keyExtractor,
                ref = ref
            })
        })
    })
end)
