-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local Foundation = require(ChatUIPrimitivesParent.Foundation)
local useMessagePool = require(script.Parent.useMessagePool)
local useMessagesMap = require(script.Parent.useMessagesMap)
local BottomLockedScrollView = require(script.Parent.BottomLockedScrollView)
local TextLineEntry = require(script.Parent.TextLineEntry)
local BubbleEntry = require(script.Parent.BubbleEntry)
local _Types = require(ChatUIPrimitives.Types)
local FFlagExpChatLatestUsernameWithoutRender = require(ChatUIPrimitives.Flags.FFlagExpChatLatestUsernameWithoutRender)

local function createSlotElementFactory(arg1, getMessagesMap, fontFace, selectableRows: boolean?, selectionCursor, isTranslationSettingEnabled: boolean?, getLatestMessageId, reportLatestUsername: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2)
        return React.createElement(arg1, {
            getMessageId = arg2.getMessageId,
            getLayoutOrder = arg2.getLayoutOrder,
            getMessagesMap = getMessagesMap,
            fontFace = fontFace,
            selectableRows = selectableRows,
            selectionCursor = selectionCursor,
            isTranslationSettingEnabled = isTranslationSettingEnabled,
            getLatestMessageId = getLatestMessageId,
            reportLatestUsername = reportLatestUsername
        })
    end
end

local signal = Signals.createSignal({})

local tbl1 = {
    left = UDim.new(0, 8),
    right = UDim.new(0, 8)
}

return React.memo(function(tbl2) -- name: MessageLayoutContainer
    local var1 = tbl2.messagesSignal or signal

    local messageIdsSignal = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local result = {}

            for _, value in (var1(arg1)) do
                result[#result + 1] = value.messageId
            end
            return result
        end)
    end, { var1 })

    local getLatestMessageId = React.useMemo(function()
        if not tbl2.selectableRows then
            return nil
        end
        return Signals.createComputed(function(arg1)
            local var3 = messageIdsSignal(arg1)
            return var3[#var3]
        end)
    end, { messageIdsSignal, tbl2.selectableRows })

    if FFlagExpChatLatestUsernameWithoutRender then
        local onLatestUsernameChanged = tbl2.onLatestUsernameChanged
        React.useEffect(function()
            if getLatestMessageId == nil or onLatestUsernameChanged == nil then
                return nil
            end
            return Signals.createEffect(function(arg1)
                if getLatestMessageId(arg1) == nil then
                    onLatestUsernameChanged(nil)
                end
            end)
        end, { getLatestMessageId, onLatestUsernameChanged })
    end

    local getMessagesMap = useMessagesMap(var1)
    local var3 = if tbl2.layoutStyle == "bubble" then BubbleEntry else TextLineEntry

    local createSlotElement = React.useMemo(function()
        return createSlotElementFactory(
            var3,
            getMessagesMap,
            tbl2.fontFace,
            tbl2.selectableRows,
            tbl2.selectionCursor,
            tbl2.isTranslationSettingEnabled,
            getLatestMessageId,
            tbl2.onLatestUsernameChanged
        )
    end, {
        var3,
        getMessagesMap,
        tbl2.fontFace or false,
        tbl2.selectableRows or false,
        tbl2.selectionCursor or false,
        tbl2.isTranslationSettingEnabled or false,
        getLatestMessageId,
        tbl2.onLatestUsernameChanged or false
    })

    local var5 = useMessagePool({ messageIdsSignal = messageIdsSignal, createSlotElement = createSlotElement })

    local var6 = SignalsReact.useSignalState(var5)

    local children = React.useMemo(function()
        local var7 = table.clone(var6)
        var7["$layout"] = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2) })

        return var7
    end, { var6 })

    return React.createElement(
        Foundation.View,
        {
            tag = "fill padding-y-xsmall",
            Size = tbl2.Size or UDim2.fromScale(1, 1)
        },
        {
            scrollView = React.createElement(BottomLockedScrollView, {
                Size = UDim2.fromScale(1, 1),
                contentPadding = tbl2.contentPadding or tbl1,
                children = children,
                onScroll = tbl2.onScroll,
                selectableRows = tbl2.selectableRows
            })
        }
    )
end)
