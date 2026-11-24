-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)
local _MessageList = require(FriendsChatParent.ChatUIPrimitives.MessageList)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)
local GetConversationStore = require(FriendsChatParent.AppChat.GetConversationStore)
local GetConversationMessageListStore = require(FriendsChatParent.AppChat.GetConversationMessageListStore)
local fetchOlderMessages = require(FriendsChatParent.AppChat.fetchOlderMessages)
local useChatPlatform = require(FriendsChatParent.ExpChatIntegration.useChatPlatform)

local FFlagFriendsChatPaginateOlderMessages = require(FriendsChat.Flags.FFlagFriendsChatPaginateOlderMessages)
local FIntFriendsChatBubbleMaxMessages = require(FriendsChat.Flags.FIntFriendsChatBubbleMaxMessages)

local useConversationEnvelopes = require(script.Parent.Parent.Message.BubbleEnvelopes.useConversationEnvelopes)
local getLocalUserId = require(script.Parent.Parent.Utils.getLocalUserId)
local useChatWindowReport = require(script.Parent.Parent.Utils.useChatWindowReport)
local useLocalize = require(script.Parent.Parent.Utils.useLocalize)
local _FriendsChatBubbleMessageListView = require(script.Parent.FriendsChatBubbleMessageListView)
local FriendsChatOsaSystemMessage = require(script.Parent.FriendsChatOsaSystemMessage)
local getOsaParticipantUserId = require(script.Parent.getOsaParticipantUserId)

local binding = React.createBinding(0)

local var1 = ExpChatShared.Logger:new(script.Name)

local function isSameOsaState(tbl1, tbl2): boolean
    return tbl1.hasRecord == tbl2.hasRecord and tbl1.osaUserId == tbl2.osaUserId and tbl1.hasOlderPage == tbl2.hasOlderPage
end

local function isBelowHideThreshold(chatWindowMessageHideRootFadeThreshold: number): boolean
    return chatWindowMessageHideRootFadeThreshold < ExpChatShared.Config.ChatWindowMessageHideRootFadeThreshold
end

local function getTopFadeSequence(tbl1): NumberSequence
    local var2 = tbl1[1]
    local var3 = tbl1[2]
    if var3 <= 0 or var2 <= var3 then
        return NumberSequence.new(0)
    end
    return NumberSequence.new(
        { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(var3 / var2, 0), NumberSequenceKeypoint.new(1, 0) }
    )
end

local function useFriendsChatBubbleMessageListViewModel(tbl1)
    local localize = useLocalize()
    local var3, var4 = React.useBinding(0)

    local onMaskAbsoluteSizeChanged = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize.Y)
    end, {})

    local maskRef = React.useRef(nil)
    React.useEffect(function()
        local current = maskRef.current
        if current then
            onMaskAbsoluteSizeChanged(current)
        end
    end, { onMaskAbsoluteSizeChanged })

    local var7, var8 = React.useBinding(0)
    local onCanvasPositionChanged = React.useCallback(function(vector2: Vector2)
        local num1 = math.clamp(vector2.Y, 0, 16)
        if num1 ~= var7:getValue() then
            var8(num1)
        end
    end, { var7, var8 })

    local topFade = React.useMemo(function()
        return React.joinBindings({ var3, var7 }):map(getTopFadeSequence)
    end, { var3, var7 })

    local conversationId = tbl1.conversationId
    local var11 = useConversationEnvelopes({ conversationId = conversationId, shouldReadMessages = tbl1.hasConversationId })
    local var12 = if FFlagFriendsChatPaginateOlderMessages and FIntFriendsChatBubbleMaxMessages == 0 then if tbl1.isRealConversation then conversationId else nil else nil
    local bool1 = var12 ~= nil
    local var13 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var13 = GetConversationStore(arg1).getConversation(conversationId, arg1)
            local var14 = if bool1 then GetConversationMessageListStore(arg1).getMetadata(conversationId, arg1) else nil
            return {
                hasRecord = var13 ~= nil,
                osaUserId = getOsaParticipantUserId(var13),
                hasOlderPage = not (var14 == nil or var14.nextPageCursor == nil) and not var14.fetchedOldest
            }
        end, isSameOsaState)
    end, { conversationId, bool1 })
    local var14 = SignalsReact.useSignalState(var13)
    local osaUserId = var14.osaUserId

    local initialScrollPosition = if osaUserId == nil then "end" elseif tbl1.shouldOpenToOsaSystemMessage then "start" else "end"

    local isReady = (not tbl1.isRealConversation or var14.hasRecord) and (initialScrollPosition == "end" or tbl1.hasLoadedNewestPage)

    local shouldOpenToOsaSystemMessage = tbl1.shouldOpenToOsaSystemMessage
    if FFlagFriendsChatPaginateOlderMessages then
        local var16 = React.useRef(nil)
        if isReady and (var16.current == nil or var16.current.conversationId ~= conversationId) then
            var16.current = {
                conversationId = conversationId,
                atDisclosure = tbl1.shouldOpenToOsaSystemMessage
            }
        end
        local current = var16.current
        if current ~= nil and current.conversationId == conversationId then
            shouldOpenToOsaSystemMessage = current.atDisclosure
        end
    end

    if bool1 and (not tbl1.hasLoadedNewestPage or not shouldOpenToOsaSystemMessage and var14.hasOlderPage) then
        osaUserId = nil
    end
    local chatWindowSettings = tbl1.chatWindowSettings
    local isSpatialUiEnabled = tbl1.isSpatialUIEnabled

    local header = React.useMemo(function()
        if osaUserId == nil then
            return nil
        end

        return React.createElement(FriendsChatOsaSystemMessage, {
            conversationId = conversationId,
            userId = osaUserId,
            chatWindowSettings = chatWindowSettings,
            isSpatialUIEnabled = isSpatialUiEnabled,
            localize = localize
        })
    end, {
        conversationId,
        osaUserId,
        chatWindowSettings,
        isSpatialUiEnabled,
        localize
    })

    local getTransparencyStore = useChatPlatform().getTransparencyStore
    local onUserScrollInput = React.useCallback(function()
        getTransparencyStore(false).resetAllTransparency()
    end, { getTransparencyStore })

    local localUserId = getLocalUserId()
    local messageListProps = React.useMemo(function()
        local func1

        if var12 == nil then
            func1 = nil
        else
            local var18 = var12
            func1 = function()
                fetchOlderMessages(var18):catch(function(arg1)
                    var1:warning(`Failed to fetch older messages for {var18}: {tostring(arg1)}`)
                end)
            end
        end
        return {
            displayMode = "bubble",
            getMessageEnvelopes = var11.getEnvelopes,
            maxGroupGapMs = 300000,
            observingUserId = if localUserId then tostring(localUserId) else nil,
            header = header,
            initialScrollPosition = initialScrollPosition,
            onUserScrollInput = onUserScrollInput,
            onCanvasPositionChanged = onCanvasPositionChanged,
            onNearOldestMessage = func1
        }
    end, {
        var11,
        localUserId,
        header,
        initialScrollPosition,
        onUserScrollInput,
        onCanvasPositionChanged,
        var12
    })

    local textTransparency = tbl1.textTransparency or binding
    local messagesVisible = React.useMemo(function()
        return textTransparency:map(isBelowHideThreshold)
    end, { textTransparency })

    local onSlotAbsoluteSizeChanged = useChatWindowReport(tbl1.onAbsoluteSizeChanged)
    local onSlotAbsolutePositionChanged = useChatWindowReport(tbl1.onAbsolutePositionChanged)

    return {
        layoutOrder = tbl1.layoutOrder,
        conversationId = conversationId,
        isReady = isReady,
        topInset = tbl1.topInset,
        textTransparency = textTransparency,
        messagesVisible = messagesVisible,
        topFade = topFade,
        maskRef = maskRef,
        onMaskAbsoluteSizeChanged = onMaskAbsoluteSizeChanged,
        onSlotAbsoluteSizeChanged = onSlotAbsoluteSizeChanged,
        onSlotAbsolutePositionChanged = onSlotAbsolutePositionChanged,
        onHovered = tbl1.onHovered,
        onUnhovered = tbl1.onUnhovered,
        messageListProps = messageListProps
    }
end

return useFriendsChatBubbleMessageListViewModel
