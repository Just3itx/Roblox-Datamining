-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Responsive = require(ChatUIPrimitivesParent.Responsive)

local Sizing = require(script.Parent.Parent.Sizing)
local HeaderItem = require(script.Parent.HeaderItem)
local MessageListClock = require(script.Parent.MessageListClock)
local MessageListView = require(script.Parent.MessageListView)
local ObservingUserContext = require(script.Parent.ObservingUserContext)
local useMessageListViewModel = require(script.Parent.useMessageListViewModel)

local function MessageListContent(arg1)
    local var1 = useMessageListViewModel(arg1)
    local observingUserId = if arg1.observingUserId == "" then nil else arg1.observingUserId
    local createElement = React.createElement
    local provider = ObservingUserContext.Context.Provider
    local tbl1 = { value = observingUserId }
    local tbl2 = { Sizing = 0 }
    local createElement2 = React.createElement
    local provider2 = Sizing.Context.Provider
    local tbl3 = {
        value = var1.sizing
    }
    local tbl4 = { Clock = 0 }
    local createElement3 = React.createElement
    local var2 = MessageListClock
    local tbl5 = {
        enabled = arg1.displayMode == "discussion"
    }
    local tbl6 = { Header = 0 }
    local createElement4 = React.createElement
    local provider3 = HeaderItem.Context.Provider
    local tbl7 = {
        value = arg1.header
    }
    local tbl8 = {
        Frame = React.createElement(Foundation.View, {
            Size = UDim2.fromScale(1, 1)
        }, {
            ResponsiveContainer = React.createElement(Responsive.ResponsiveContainerFrame),
            MessageListView = if var1.isMeasured then React.createElement(MessageListView, { listProps = var1.listProps }) else nil
        })
    }
    tbl6.Header = createElement4(provider3, tbl7, tbl8)
    tbl4.Clock = createElement3(var2, tbl5, tbl6)
    tbl2.Sizing = createElement2(provider2, tbl3, tbl4)
    return createElement(provider, tbl1, tbl2)
end

return React.memo(function(arg1) -- name: MessageList
    return React.createElement(Responsive.ResponsiveProvider, nil, { Content = React.createElement(MessageListContent, arg1) })
end)
