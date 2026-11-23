-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local SignalsReact = require(AppChatParent.SignalsReact)
local SocialCarousel = require(AppChatParent.SocialCarousel)
local ViewRecycler = require(AppChatParent.ViewRecycler)

local ChatLandingModalContainer = require(script.Parent.ChatLandingModal.ChatLandingModalContainer)
local ConversationGroupsEntryContainer = require(script.Parent.ConversationGroupsEntryContainer)
local ConversationListItemKind = require(script.Parent.ConversationListItemKind)
local ConversationRow = require(script.Parent.ConversationRow.ConversationRow)
local ConversationRowBindingHost = require(script.Parent.ConversationRow.ConversationRowBindingHost)
local PartyQuickStartContainer = require(script.Parent.PartyQuickStartContainer)

local FFlagAppChatUseBindingViewRecyclerConversationRow = require(AppChat.Flags.FFlagAppChatUseBindingViewRecyclerConversationRow)

local Constants = SocialCarousel.Constants
local View = Foundation.View
local tbl1 = {
    readiness = ViewRecycler.RecyclableViewReadiness.ReadyOnCommit
}

local function selectCanvasSize(arg1): UDim2
    return UDim2.new(1, 0, 0, arg1.height)
end

local function selectCanvasBackgroundStyle(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.backgroundStyle
end

local function GroupLinkItemView(arg1)
    local var1 = SignalsReact.useSignalState(arg1.itemSignal)
    return React.createElement(ConversationGroupsEntryContainer, { entryHeight = var1.entryHeight })
end

local function QuickStartItemView(arg1)
    local var1 = SignalsReact.useSignalState(arg1.itemSignal)
    return React.createElement(PartyQuickStartContainer, { entryHeight = var1.entryHeight })
end

local function SocialCarouselItemView(arg1)
    local var1 = SignalsReact.useSignalState(arg1.itemSignal)
    return React.createElement(SocialCarousel.Entry, {
        customTileList = var1.customTileList,
        roduxKey = "ChatAppReducer",
        hideCarouselHeader = true,
        source = if var1.isInExperience then Constants.ANALYTICS.SRC.PARTY_PAGE_IN_EXP else Constants.ANALYTICS.SRC.PARTY_PAGE_UA,
        unifiedLogging = var1.unifiedLogging
    })
end

local recyclableView = ViewRecycler.createRecyclableView(function(arg1) -- name: StatefulConversationItemView
    local var1 = SignalsReact.useSignalState(arg1.itemSignal)
    local var2 = SignalsReact.useSignalState(var1.presentationSignal)

    return React.createElement(ConversationRow, {
        conversationId = var1.id,
        entryHeight = var2.entryHeight,
        isSquadEnabled = var2.isSquadEnabled,
        isWideMode = var2.isWideMode,
        onActivated = var2.onActivated,
        onSquadJoinButtonActivated = var2.onSquadJoinButtonActivated,
        fireImpressionEvent = var2.fireImpressionEvent,
        fireClickEvent = var2.fireClickEvent,
        showBackground = var2.showBackground,
        localUserId = var2.localUserId,
        debugCellValue = if var2.isDebugEnabled then var1.id else nil
    })
end, tbl1)

local recyclableView2 = ViewRecycler.createRecyclableView(function(arg1) -- name: BindingConversationItemView
    return React.createElement(ConversationRowBindingHost, { itemSignal = arg1.itemSignal })
end)

local recyclableView3 = ViewRecycler.createRecyclableView(function(arg1) -- name: CanvasPaddingItemView
    local var1 = SignalsReact.useSignalBinding(function(arg2): UDim2
        return selectCanvasSize(arg1.itemSignal(arg2))
    end)
    local backgroundStyle = SignalsReact.useSignalBinding(function(arg2)
        return (selectCanvasBackgroundStyle((arg1.itemSignal(arg2))))
    end)
    return React.createElement(View, { Size = var1, backgroundStyle = backgroundStyle, BorderSizePixel = 0 })
end)
local freeze = table.freeze

local tbl2 = {
    [ConversationListItemKind.CanvasBottomPadding] = recyclableView3,
    [ConversationListItemKind.CanvasTopPadding] = recyclableView3,
    [ConversationListItemKind.ChatLandingModal] = ViewRecycler.createRecyclableView(function(_) -- name: ChatLandingModalItemView
        return React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                ChatLandingModal = React.createElement(ChatLandingModalContainer)
            }
        )
    end)
}

local Conversation = ConversationListItemKind.Conversation

if not FFlagAppChatUseBindingViewRecyclerConversationRow then
    recyclableView2 = recyclableView
end

tbl2[Conversation] = recyclableView2

tbl2[ConversationListItemKind.GroupLink] = ViewRecycler.createRecyclableView(GroupLinkItemView, tbl1)
tbl2[ConversationListItemKind.QuickStartLink] = ViewRecycler.createRecyclableView(QuickStartItemView, tbl1)

tbl2[ConversationListItemKind.SocialCarousel] = ViewRecycler.createRecyclableView(SocialCarouselItemView, tbl1)
local var1 = freeze(tbl2)

return table.freeze({
    canvasBottomPadding = function(height, backgroundStyle)
        return {
            id = "CanvasBottomPadding",
            kind = ConversationListItemKind.CanvasBottomPadding,
            height = height,
            backgroundStyle = backgroundStyle
        }
    end,
    canvasTopPadding = function(height, backgroundStyle)
        return {
            id = "CanvasTopPadding",
            kind = ConversationListItemKind.CanvasTopPadding,
            height = height,
            backgroundStyle = backgroundStyle
        }
    end,
    chatLandingModal = function()
        return {
            id = "UnfilteredThreadsFtux",
            kind = ConversationListItemKind.ChatLandingModal
        }
    end,
    conversation = function(arg1, presentationSignal)
        return {
            id = tostring(arg1),
            kind = ConversationListItemKind.Conversation,
            presentationSignal = presentationSignal
        }
    end,
    getItemKey = function(arg1)
        return arg1.id
    end,
    getItemType = function(arg1)
        local var2 = var1[arg1.kind]
        local kind = arg1.kind
        assert(var2 ~= nil, `ConversationListViewRecycler: unknown item kind "{tostring(kind)}"`)
        return var2
    end,
    groupLink = function(entryHeight)
        return {
            id = "ConversationGroupsEntryContainer",
            kind = ConversationListItemKind.GroupLink,
            entryHeight = entryHeight
        }
    end,
    quickStart = function(entryHeight)
        return {
            id = "PartyQuickStartContainer",
            kind = ConversationListItemKind.QuickStartLink,
            entryHeight = entryHeight
        }
    end,
    socialCarousel = function(customTileList, isInExperience, unifiedLogging)
        return {
            id = "SocialCarousel",
            kind = ConversationListItemKind.SocialCarousel,
            customTileList = customTileList,
            isInExperience = isInExperience,
            unifiedLogging = unifiedLogging
        }
    end
})
