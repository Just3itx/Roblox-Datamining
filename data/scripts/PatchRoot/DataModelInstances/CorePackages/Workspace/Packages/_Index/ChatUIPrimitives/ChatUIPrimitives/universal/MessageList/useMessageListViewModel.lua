-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local ViewRecycler = require(ChatUIPrimitivesParent.ViewRecycler)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)
local Signals = require(ChatUIPrimitivesParent.Signals)

local Sizing = require(script.Parent.Parent.Sizing)
local BubbleItemFrame = require(script.Parent.Bubble.BubbleItemFrame)
local MessageBubbleItem = require(script.Parent.Bubble.MessageBubbleItem)
local DiscussionItemFrame = require(script.Parent.Discussion.DiscussionItemFrame)
local MessageDiscussionItem = require(script.Parent.Discussion.MessageDiscussionItem)
local InlineItemFrame = require(script.Parent.Inline.InlineItemFrame)
local MessageInlineItem = require(script.Parent.Inline.MessageInlineItem)
local HeaderItem = require(script.Parent.HeaderItem)
local SystemItem = require(script.Parent.SystemItem)
local TimestampItem = require(script.Parent.TimestampItem)
local groupMessages = require(script.Parent.groupMessages)
local isScrollInput = require(script.Parent.isScrollInput)
local projectMessageEnvelope = require(script.Parent.projectMessageEnvelope)
local useKeepEndOnResize = require(script.Parent.useKeepEndOnResize)
local useMessageListLayout = require(script.Parent.useMessageListLayout)
local usePropSignal = require(ChatUIPrimitives.Hooks.usePropSignal)
local FFlagExpChatMessageListScrollParity = require(ChatUIPrimitives.Flags.FFlagExpChatMessageListScrollParity)
local FIntExpChatMessageListOverscanRows = require(ChatUIPrimitives.Flags.FIntExpChatMessageListOverscanRows)
local _Types = require(script.Parent.Parent.Types)

local var1 = ViewRecycler.ChatPreset.create()
local tbl1 = { viewportFraction = 1 }

local function getRowKey(arg1)
    return arg1.id
end

local tbl2 = {
    readiness = ViewRecycler.RecyclableViewReadiness.ReadyOnCommit,
    hideWhilePending = true
}

local function createItemView(arg1, arg2) -- Luacid: Inlined by compiler; 9 call sites recovered
    return (ViewRecycler.createRecyclableView(function(arg3)
        return React.createElement(arg2, {}, { Item = React.createElement(arg1, { itemSignal = arg3.itemSignal }) })
    end, tbl2))
end

local tbl3 = { kind = "header", id = "$header" }

local tbl4 = { kind = "endSpacer", id = "$endSpacer" }

local header = createItemView(HeaderItem.Component, function(tbl5) -- name: HeaderFrame
    return React.createElement(React.Fragment, nil, tbl5.children)
end)

local endSpacer = ViewRecycler.createRecyclableView(function() -- name: EndSpacer
    return React.createElement(Foundation.View, { tag = "size-full-200", testId = "message-list-end-spacer" })
end, tbl2)

local tbl5 = {
    inline = {
        message = createItemView(MessageInlineItem, InlineItemFrame),
        timestamp = createItemView(TimestampItem, InlineItemFrame),
        system = createItemView(SystemItem, InlineItemFrame),
        header = header
    },
    bubble = {
        message = createItemView(MessageBubbleItem, BubbleItemFrame),
        timestamp = createItemView(TimestampItem, BubbleItemFrame),
        system = createItemView(SystemItem, BubbleItemFrame),
        header = header,
        endSpacer = endSpacer
    },
    discussion = {
        message = createItemView(MessageDiscussionItem, DiscussionItemFrame),
        system = createItemView(SystemItem, DiscussionItemFrame),
        header = header,
        endSpacer = endSpacer
    }
}

local function useMessageListViewModel(tbl6)
    local var2 = React.useMemo(function()
        local tbl7 = {}
        return Signals.createComputed(function(arg1)
            local tbl8 = {}
            local result = {}
            for _, source in tbl6.getMessageEnvelopes(arg1) do
                local var2 = tbl7[source.stableId]
                local rendered = if var2 ~= nil and var2.source == source then var2.rendered else projectMessageEnvelope(source)
                tbl8[source.stableId] = { source = source, rendered = rendered }

                table.insert(result, rendered)
            end
            tbl7 = tbl8
            return result
        end)
    end, { tbl6.getMessageEnvelopes })
    local var3 = usePropSignal(tbl6.maxGroupSize)
    local var4 = usePropSignal(tbl6.maxGroupGapMs)
    local var5 = usePropSignal(tbl6.groupingEnabled)

    local shouldInsertTimestampRows = tbl6.displayMode ~= "discussion"

    local var6 = React.useMemo(function()
        local tbl7 = {}
        return Signals.createComputed(function(arg1)
            local var6 = var2(arg1)
            local var7 = if var5(arg1) == false then groupMessages.ungroupedRows(var6, tbl7) else groupMessages.groupMessages(
                var6,
                var3(arg1),
                var4(arg1),
                tbl7,
                { shouldInsertTimestampRows = shouldInsertTimestampRows }
            )
            tbl7 = var7
            return var7
        end)
    end, {
        var2,
        var3,
        var4,
        var5,
        shouldInsertTimestampRows
    })
    local var7 = SignalsReact.useSignalState(var6)

    local itemType = React.useCallback(function(arg1)
        local var8 = tbl5[tbl6.displayMode]
        if var8 == nil then
            error("Invalid display mode: " .. tbl6.displayMode)
        end
        local var9 = var8[arg1.kind]
        if var9 == nil then
            error("Invalid row kind: " .. arg1.kind)
        end
        return var9
    end, { tbl6.displayMode })

    local var9 = Sizing.useMeasured()
    local sizing = Sizing.useResolvedSizing(if var9 then var9.density else "regular", if var9 then var9.widthUnits else 1)

    local layout = useMessageListLayout(if tbl6.displayMode == "discussion" then sizing.discussion.estimatedRowHeight else nil)
    local scrollBarThickness = sizing.list.scrollBarThickness
    local scrollBarInset = sizing.list.scrollBarInset
    local scrollBarColor = sizing.list.scrollBarColor

    local onUserScrollInput = tbl6.onUserScrollInput
    local scrollingFrameProps = React.useMemo(function()
        local tbl7 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = scrollBarThickness,
            VerticalScrollBarInset = scrollBarInset,
            ScrollBarImageColor3 = scrollBarColor
        }
        if onUserScrollInput ~= nil then
            local var12 = onUserScrollInput
            tbl7[React.Event.InputBegan] = function(_, arg1)
                if isScrollInput(arg1, false) then
                    var12()
                end
            end
            tbl7[React.Event.InputChanged] = function(_, arg1)
                if isScrollInput(arg1, true) then
                    var12()
                end
            end
        end
        return tbl7
    end, {
        scrollBarThickness,
        onUserScrollInput,
        scrollBarInset,
        scrollBarColor
    })
    local bool2 = tbl6.header ~= nil
    local bool3 = tbl6.displayMode == "bubble" or tbl6.displayMode == "discussion"
    local var13 = React.useMemo(function()
        local var13 = var7
        if bool2 or bool3 then
            var13 = table.clone(var7)
        end
        if bool2 then
            table.insert(var13, 1, tbl3)
        end
        if bool3 then
            table.insert(var13, tbl4)
        end
        return { items = var13, getItemKey = getRowKey }
    end, { var7, bool2, bool3 })

    local listRef = React.useRef(nil)

    local var15, scrollingFrameRef = React.useState(nil)
    local var17 = React.useRef(tbl6.initialScrollPosition)
    if FFlagExpChatMessageListScrollParity then
        useKeepEndOnResize(var15, listRef)
    end
    local onNearOldestMessage = tbl6.onNearOldestMessage
    local onNearNewestMessage = tbl6.onNearNewestMessage
    local listProps = React.useMemo(function()
        local var18 = table.clone(var1)
        if var17.current == "start" then
            var18.initialScrollAlignment = ViewRecycler.ScrollAlignment.Start
        end
        var18.listRef = listRef
        var18.scrollingFrameRef = scrollingFrameRef
        var18.scrollingFrameProps = scrollingFrameProps
        var18.data = var13
        var18.layout = layout
        var18.axis = ViewRecycler.Axis.Y
        var18.itemType = itemType
        var18.overscan = FIntExpChatMessageListOverscanRows
        if onNearOldestMessage ~= nil then
            var18.onStartReached = onNearOldestMessage
            var18.startReachedThreshold = tbl1
        end
        if onNearNewestMessage ~= nil then
            var18.onEndReached = onNearNewestMessage
            var18.endReachedThreshold = tbl1
        end
        return var18
    end, {
        var13,
        layout,
        itemType,
        scrollingFrameProps,
        onNearOldestMessage,
        onNearNewestMessage
    })

    local var19 = React.useRef(false)
    React.useEffect(function()
        local current = listRef.current
        if var19.current or current == nil then
            return
        end
        var19.current = true
        if var17.current ~= "start" then
            return
        end
        current.scrollToStart()
    end, { var15 })

    local onCanvasPositionChanged = tbl6.onCanvasPositionChanged
    React.useEffect(function()
        if var15 == nil or onCanvasPositionChanged == nil then
            return nil
        end
        local var20 = var15
        local var21 = onCanvasPositionChanged
        local function report() -- Luacid: Inlined by compiler; 1 call site recovered
            var21(var20.CanvasPosition)
        end

        report()
        local connection = var20:GetPropertyChangedSignal("CanvasPosition"):Connect(report)
        return function()
            connection:Disconnect()
        end
    end, { var15, onCanvasPositionChanged })

    return {
        sizing = sizing,
        isMeasured = var9 ~= nil,
        listProps = listProps
    }
end

return useMessageListViewModel
