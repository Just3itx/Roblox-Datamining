-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local _Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)

local DomLocators = require(AppChat.Utils.DomLocators)
local Squads = require(AppChatParent.Squads)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)

local FFlagAppChatExtendConversationListRowDividers = require(AppChat.Flags.FFlagAppChatExtendConversationListRowDividers)
local FFlagAppChatRemoveConversationListDivider = require(AppChat.Flags.FFlagAppChatRemoveConversationListDivider)
local FFlagAppChatUseBindingConversationFacePile = require(AppChat.Flags.FFlagAppChatUseBindingConversationFacePile)

local FFlagAppChatTimestampInSubtitleConversationRow = require(AppChat.Flags.FFlagAppChatTimestampInSubtitleConversationRow)

local ConversationFacePile = require(AppChat.Components.Cells.ConversationFacePile)
local ConversationFacePileBinding = require(script.Parent.ConversationFacePileBinding)
local ConversationRowSubtitle = require(script.Parent.ConversationRowSubtitle)
local useGetOneToOneFriendIdFromConversationId = require(AppChat.Hooks.useGetOneToOneFriendIdFromConversationId)
local useIsRobloxSubscriberBinding = require(AppChatParent.UserProfiles).Hooks.useIsRobloxSubscriberBinding

local SquadButtonSourceEnum = Squads.Enums.SquadButtonSourceEnum
local SquadComponentAccessWrapper = Squads.SquadComponentAccessWrapper
local SquadJoinButton = Squads.SquadJoinButton
local var1 = React.memo(ConversationFacePile)

local function SubscriptionBadge(tbl1)
    local var2 = Foundation.Hooks.useTokens()

    return React.createElement(Foundation.View, {
        tag = "size-400-400",
        Name = "subscriptionBadge",
        LayoutOrder = 2,
        testId = "conversation-row-subscription-badge",
        Visible = tbl1.visible
    }, {
        icon = React.createElement(Foundation.Icon, {
            name = Foundation.Enums.IconName.RobloxPlus,
            size = Foundation.Enums.IconSize.Small,
            style = var2.Color.Content.Emphasis
        })
    })
end

local function LegacySubscriptionBadgeHost(tbl1)
    local var2 = SignalsReact.useSignalState(tbl1.itemSignal)
    local var3 = useGetOneToOneFriendIdFromConversationId(var2.id)
    local visible = useIsRobloxSubscriberBinding(var3)

    return React.createElement(SubscriptionBadge, { visible = visible })
end

local function LegacyConversationFacePileHost(tbl1)
    local var2 = SignalsReact.useSignalState(tbl1.itemSignal)
    local var3 = SignalsReact.useSignalState(var2.presentationSignal)

    return React.createElement(
        var1,
        {
            conversationId = var2.id,
            onActivated = tbl1.onActivated,
            localUserId = var3.localUserId,
            selectable = false
        }
    )
end

local function SquadButtonHost(tbl1)
    local var2 = SignalsReact.useSignalState(tbl1.itemSignal)

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = "row align-x-right align-y-center auto-xy", LayoutOrder = 0 }

    local tbl3 = { wrapper = 0 }
    local createElement2 = React.createElement
    local var3 = SquadComponentAccessWrapper
    local tbl4 = {
        parentChannelId = var2.id
    }
    local tbl5 = {
        button = React.createElement(SquadJoinButton, {
            conversationId = var2.id,
            isFullWidth = false,
            isInCard = false,
            layoutOrder = 0,
            onActivated = tbl1.onActivated,
            Selectable = false,
            shouldAnimate = false,
            squadButtonSource = SquadButtonSourceEnum.ConversationEntry,
            squadLocation = tbl1.squadLocation,
            testId = if FFlagDebugAppChatEnableDomLocators and tbl1.locatorTitle then DomLocators.chatLandingConversationEntrySquadButton(tbl1.locatorTitle) else nil
        })
    }
    tbl3.wrapper = createElement2(var3, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end

return React.memo(function(tbl1) -- name: ConversationRowView
    local var2 = Foundation.Hooks.useTokens()

    local uDim = UDim.new(0, tbl1.pagePaddingLeft)
    local uDim2 = UDim.new(0, tbl1.pagePaddingRight)
    local bool1 = tbl1.showBackground ~= false

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        backgroundStyle = var2.Color.None,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, tbl1.entryHeight),
        testId = if FFlagDebugAppChatEnableDomLocators then tbl1.testId else nil
    }
    local tbl3 = { cell = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        Name = "cell",
        tag = { ["size-full"] = true, ["bg-surface-0"] = bool1 },
        backgroundStyle = if bool1 then nil else var2.Color.None,
        selection = { Selectable = true },
        onActivated = tbl1.onRowActivated,
        stateLayer = bool1 and {
            affordance = Foundation.Enums.StateLayerAffordance.Background
        } or nil,
        ref = tbl1.rowRef
    }
    local tbl5 = {
        debugCellContainer = if tbl1.debugCellValue then React.createElement("Folder", {}, { debugCell = React.createElement("StringValue", { Value = tbl1.debugCellValue }) }) else nil,
        content = 0
    }

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        tag = "row align-y-center gap-small size-full",
        padding = {
            left = uDim,
            right = if FFlagAppChatExtendConversationListRowDividers then nil else uDim2
        }
    }
    local tbl7 = {
        avatar = React.createElement(Foundation.View, { tag = "size-1000-1000", LayoutOrder = 0 }, {
            facePile = if FFlagAppChatUseBindingConversationFacePile then React.createElement(ConversationFacePileBinding, { itemSignal = tbl1.itemSignal }) else React.createElement(LegacyConversationFacePileHost, { itemSignal = tbl1.itemSignal, onActivated = tbl1.onRowActivated })
        }),
        body = 0
    }

    local createElement4 = React.createElement
    local view4 = Foundation.View
    local tbl8 = { tag = "col fill size-0-full clip", Name = "body", LayoutOrder = 1 }

    local tbl9 = { mainContent = 0, divider = 0 }
    local createElement5 = React.createElement
    local view5 = Foundation.View
    local tbl10 = {
        tag = "row align-y-center fill gap-small size-full-0 clip",
        Name = "mainContent",
        LayoutOrder = 1,
        padding = FFlagAppChatExtendConversationListRowDividers and { right = uDim2 } or nil
    }

    local tbl11 = { info = 0, rightContent = 0 }
    local createElement6 = React.createElement
    local view6 = Foundation.View
    local tbl12 = { tag = "col align-y-center fill gap-xxsmall size-0-full clip", LayoutOrder = 1 }

    local tbl13 = {
        titleContainer = React.createElement(
            Foundation.View,
            {
                tag = "row align-y-center gap-xxsmall size-full-0 auto-y clip",
                Name = "titleContainer",
                LayoutOrder = 1
            },
            {
                title = React.createElement(Foundation.Text, {
                    tag = "shrink auto-xy text-title-large text-align-x-left text-truncate-split content-default",
                    Name = "title",
                    Text = tbl1.title,
                    LayoutOrder = 1
                }),
                subscriptionBadge = if FFlagAppChatUseBindingConversationFacePile then React.createElement(SubscriptionBadge, { visible = tbl1.showSubscriptionBadge }) else React.createElement(LegacySubscriptionBadgeHost, { itemSignal = tbl1.itemSignal })
            }
        ),
        subtitle = if FFlagAppChatTimestampInSubtitleConversationRow then nil else React.createElement(Foundation.Text, {
            tag = "size-full-0 auto-y text-body-small text-align-x-left text-truncate-end content-default",
            Text = tbl1.subtitleText,
            LayoutOrder = 2
        }),
        subtitleRow = if FFlagAppChatTimestampInSubtitleConversationRow then React.createElement(
            ConversationRowSubtitle,
            {
                subtitleText = tbl1.subtitleText,
                timestampText = tbl1.timestampText,
                LayoutOrder = 2
            }
        ) else nil
    }
    tbl11.info = createElement6(view6, tbl12, tbl13)

    local createElement7 = React.createElement
    local view7 = Foundation.View
    local tbl14 = { tag = "row align-y-center size-0-full auto-x", LayoutOrder = 2 }

    local tbl15 = {
        squadButton = if tbl1.showSquadButton then React.createElement(SquadButtonHost, {
            itemSignal = tbl1.itemSignal,
            locatorTitle = tbl1.locatorTitle,
            onActivated = tbl1.onSquadActivated,
            squadLocation = tbl1.squadLocation
        }) else nil,
        timestampCluster = React.createElement(Foundation.View, {
            tag = "row align-y-center gap-xsmall auto-xy",
            Name = "timestampCluster",
            Visible = tbl1.showTimestamp,
            LayoutOrder = 1
        }, {
            timestamp = if FFlagAppChatTimestampInSubtitleConversationRow then nil else React.createElement(Foundation.Text, {
                tag = "auto-xy text-body-small content-default",
                Name = "timeStamp",
                Text = tbl1.timestampText,
                LayoutOrder = 1,
                testId = "conversation-row-timestamp"
            }),
            unreadDot = React.createElement(Foundation.View, {
                tag = "size-200-200 radius-circle bg-action-emphasis",
                Name = "unreadDot",
                Visible = tbl1.showUnread,
                LayoutOrder = 2
            })
        })
    }
    tbl11.rightContent = createElement7(view7, tbl14, tbl15)
    tbl9.mainContent = createElement5(view5, tbl10, tbl11)

    tbl9.divider = if FFlagAppChatRemoveConversationListDivider then nil else React.createElement(
        Foundation.View,
        { tag = "size-full-0 auto-y", Name = "divider", LayoutOrder = 2 },
        {
            line = React.createElement(Foundation.Divider)
        }
    )
    tbl7.body = createElement4(view4, tbl8, tbl9)
    tbl5.content = createElement3(view3, tbl6, tbl7)
    tbl3.cell = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end)
