-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)

local DomLocators = require(AppChat.Utils.DomLocators)
local Squads = require(AppChatParent.Squads)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)

local FFlagAppChatExtendConversationListRowDividers = require(AppChat.Flags.FFlagAppChatExtendConversationListRowDividers)
local FFlagAppChatRemoveConversationListDivider = require(AppChat.Flags.FFlagAppChatRemoveConversationListDivider)

local FFlagAppChatTimestampInSubtitleConversationRow = require(AppChat.Flags.FFlagAppChatTimestampInSubtitleConversationRow)

local ConversationFacePile = require(AppChat.Components.Cells.ConversationFacePile)
local ConversationRowSubtitle = require(script.Parent.ConversationRowSubtitle)
local useConversationRowPresentation = require(script.Parent.useConversationRowPresentation)

local SquadButtonSourceEnum = Squads.Enums.SquadButtonSourceEnum
local SquadComponentAccessWrapper = Squads.SquadComponentAccessWrapper
local SquadJoinButton = Squads.SquadJoinButton
local var1 = React.memo(ConversationFacePile)

return React.memo(React.forwardRef(function(tbl1, arg1) -- name: ConversationRow
    local var2 = useConversationRowPresentation({
        conversationId = tbl1.conversationId,
        entryHeight = tbl1.entryHeight,
        isSquadEnabled = tbl1.isSquadEnabled,
        isWideMode = tbl1.isWideMode,
        showBackground = tbl1.showBackground,
        onActivated = tbl1.onActivated,
        onSquadJoinButtonActivated = tbl1.onSquadJoinButtonActivated,
        fireImpressionEvent = tbl1.fireImpressionEvent,
        fireClickEvent = tbl1.fireClickEvent
    })
    local var3 = Foundation.Hooks.useTokens()

    local rowRef = var2.rowRef
    local ref = React.useCallback(function(current)
        rowRef.current = current
        if type(arg1) == "function" then
            arg1(current)
        elseif arg1 ~= nil then
            arg1.current = current
        end
    end, { arg1, rowRef })

    if not var2.hasConversation then
        return nil
    end

    local uDim = UDim.new(0, var2.pagePaddingLeft)
    local uDim2 = UDim.new(0, var2.pagePaddingRight)
    local showBackground = var2.showBackground

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        backgroundStyle = var3.Color.None,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, var2.entryHeight),
        testId = if FFlagDebugAppChatEnableDomLocators then var2.testId else nil
    }
    local tbl3 = { cell = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        Name = "cell",
        Size = if FFlagAppChatExtendConversationListRowDividers then nil else UDim2.fromScale(1, 1),
        tag = { ["size-full"] = true, ["bg-surface-0"] = showBackground },
        backgroundStyle = if showBackground then nil else var3.Color.None,
        selection = { Selectable = true },
        onActivated = var2.onRowActivated,
        stateLayer = showBackground and {
            affordance = Foundation.Enums.StateLayerAffordance.Background
        } or nil,
        ref = ref
    }
    local tbl5 = {
        debugCellContainer = if tbl1.debugCellValue then React.createElement("Folder", {}, { debugCell = React.createElement("StringValue", { Value = tbl1.debugCellValue }) }) else nil,
        content = 0
    }

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        Size = if FFlagAppChatExtendConversationListRowDividers then nil else UDim2.fromScale(1, 1),
        tag = "row align-y-center gap-small size-full",
        padding = {
            left = uDim,
            right = if FFlagAppChatExtendConversationListRowDividers then nil else uDim2
        }
    }
    local tbl7 = {
        avatar = React.createElement(Foundation.View, { tag = "size-1000-1000", LayoutOrder = 0 }, {
            facePile = React.createElement(var1, {
                conversationId = var2.conversationId,
                onActivated = var2.onRowActivated,
                participants = var2.participants,
                localUserId = tbl1.localUserId,
                selectable = false
            })
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

    local tbl11 = {
        info = React.createElement(
            Foundation.View,
            { tag = "col align-y-center fill gap-xxsmall size-0-full clip", LayoutOrder = 1 },
            {
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
                            Text = var2.title,
                            LayoutOrder = 1
                        }),
                        subscriptionBadge = React.createElement(
                            Foundation.View,
                            {
                                tag = "size-400-400",
                                Name = "subscriptionBadge",
                                LayoutOrder = 2,
                                Visible = var2.showSubscriptionBadge
                            },
                            {
                                icon = React.createElement(Foundation.Icon, {
                                    name = Foundation.Enums.IconName.RobloxPlus,
                                    size = Foundation.Enums.IconSize.Small,
                                    style = var3.Color.Content.Emphasis
                                })
                            }
                        )
                    }
                ),
                subtitle = if FFlagAppChatTimestampInSubtitleConversationRow then nil else React.createElement(Foundation.Text, {
                    tag = "size-full-0 auto-y text-body-small text-align-x-left text-truncate-end content-default",
                    Text = var2.subtitleText,
                    LayoutOrder = 2
                }),
                subtitleRow = if FFlagAppChatTimestampInSubtitleConversationRow then React.createElement(
                    ConversationRowSubtitle,
                    {
                        subtitleText = var2.subtitleText,
                        timestampText = var2.timestampText,
                        LayoutOrder = 2
                    }
                ) else nil
            }
        ),
        rightContent = 0
    }

    local createElement6 = React.createElement
    local view6 = Foundation.View
    local tbl12 = {
        tag = "row align-y-center size-0-full auto-x",
        AutomaticSize = Enum.AutomaticSize.X,
        LayoutOrder = 2
    }
    local tbl13 = { squadButton = 0, timestampCluster = 0 }
    local var5

    if var2.showSquadButton then
        local createElement7 = React.createElement
        local view7 = Foundation.View
        local tbl14 = { tag = "row align-x-right align-y-center auto-xy", LayoutOrder = 0 }

        local tbl15 = { wrapper = 0 }
        local createElement8 = React.createElement
        local var6 = SquadComponentAccessWrapper
        local tbl16 = {
            parentChannelId = var2.conversationId
        }
        local tbl17 = {
            button = React.createElement(SquadJoinButton, {
                conversationId = var2.conversationId,
                isFullWidth = false,
                isInCard = false,
                layoutOrder = 0,
                onActivated = var2.onSquadActivated,
                Selectable = false,
                shouldAnimate = false,
                squadButtonSource = SquadButtonSourceEnum.ConversationEntry,
                squadLocation = var2.squadLocation,
                testId = if FFlagDebugAppChatEnableDomLocators and var2.locatorTitle then DomLocators.chatLandingConversationEntrySquadButton(var2.locatorTitle) else nil
            })
        }
        tbl15.wrapper = createElement8(var6, tbl16, tbl17)
        var5 = createElement7(view7, tbl14, tbl15)
    else
        var5 = nil
    end

    tbl13.squadButton = var5

    tbl13.timestampCluster = React.createElement(Foundation.View, {
        tag = "row align-y-center gap-xsmall auto-xy",
        Name = "timestampCluster",
        Visible = var2.showTimestamp,
        LayoutOrder = 1
    }, {
        timestamp = if FFlagAppChatTimestampInSubtitleConversationRow then nil else React.createElement(
            Foundation.Text,
            {
                tag = "auto-xy text-body-small content-default",
                Name = "timeStamp",
                Text = var2.timestampText,
                LayoutOrder = 1
            }
        ),
        unreadDot = React.createElement(Foundation.View, {
            tag = "size-200-200 radius-circle bg-action-emphasis",
            Name = "unreadDot",
            Visible = var2.showUnread,
            LayoutOrder = 2
        })
    })
    tbl11.rightContent = createElement6(view6, tbl12, tbl13)
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
end))
