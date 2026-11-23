-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local InputHandlers = require(AppChatParent.InputHandlers)
local React = require(AppChatParent.React)
local _ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local SharedFlags = require(AppChatParent.SharedFlags)
local SquadExternalContractProvider = require(AppChatParent.SquadsCore.SquadExternalContractProvider)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local ConversationActionType = require(AppChat.Analytics.Enums.ConversationActionType)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local ChatConversationTelemetryEvents = require(script.Parent.ChatConversationTelemetryEvents)

local leaveSquad = require(AppChatParent.SquadsCore.Thunks).leaveSquad
local SquadPromptType = require(AppChatParent.SquadsCore.Enums).SquadPromptType
local useCurrentSquadId = require(AppChatParent.SquadsCore.Hooks).useCurrentSquadId
local useCurrentSquadParentChannelId = require(AppChatParent.SquadsCore.Hooks).useCurrentSquadParentChannelId
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local EventNames = require(AppChatParent.SquadsCore.EventNames)

local ScheduledSquadSheet = require(AppChatParent.Squads.ScheduledSquadSheet)
local ScheduledSquadActionEnum = require(AppChatParent.Squads.Enums).ScheduledSquadActionEnum
local ScheduledSquadActionSourceEnum = require(AppChatParent.Squads.Enums).ScheduledSquadActionSourceEnum
local SquadButtonClickIntentionEnum = require(AppChatParent.Squads.Enums).SquadButtonClickIntentionEnum
local SquadButtonSourceEnum = require(AppChatParent.Squads.Enums).SquadButtonSourceEnum

local IconName = Foundation.Enums.IconName
local Menu = Foundation.Menu
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local useTokens = Foundation.Hooks.useTokens

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot

local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = SharedFlags.FFlagPartyDevAPIToRespectThirdPartySettingsEnabled

return React.memo(function(tbl1)
    local var1 = useTelemetry(ChatConversationTelemetryLayer.Context)
    local var2 = useDispatch()
    local var3 = useTokens()
    local var4 = useLocalization({
        joinParty = "Feature.Squads.Label.JoinParty",
        moreText = "CommonUI.Features.Label.More",
        scheduleAParty = "Feature.Squads.Action.ScheduleAParty",
        startParty = "Feature.Squads.Label.StartParty",
        viewParty = "Feature.Squads.Label.ViewParty"
    })

    local squadId = useCurrentSquadId()
    local var6 = useCurrentSquadParentChannelId()
    local var7 = React.useContext(SquadExternalContractContext)
    local var8 = not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var7.useIsChatEnabled()

    local isOpen, var10 = React.useState(false)
    local var11, var12 = React.useState(false)
    local var5, var14 = React.useState(tbl1.tooltipText and tbl1.tooltipText ~= "")

    local var15 = React.useRef(nil)

    local customEventHandlers = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                arg1.cancelled = true
                var12(false)
            end)
        }
        return result
    end, { var12 })

    local var17 = useAppFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = var11,
        customEventHandlers = customEventHandlers
    })

    local ref = React.useCallback(function(current)
        var15.current = current
        if type(var17) == "function" then
            var17(current)
        end
    end, { var17 })

    React.useEffect(function()
        if not var15 or not var15.current then
            return
        end
        var15.current.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        var15.current.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
        var15.current.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        var15.current.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        var15.current.SelectionGroup = true
    end, { var11 })

    local onPressedOutside = React.useCallback(function()
        var12(false)
    end, {})

    local var20 = React.useCallback(function()
        var10(true)

        var7.fireSquadAnalytics(EventNames.ScheduledSquadAction, {
            actionType = ScheduledSquadActionEnum.ScheduleParty,
            conversationId = tbl1.conversationId,
            source = ScheduledSquadActionSourceEnum.ChatConversationMoreMenu,
            squadId = squadId,
            squadLocation = var7.squadLocation
        })
    end, {
        var7.setSquadPrompt,
        tbl1.conversationId,
        squadId,
        var7.squadLocation,
        var7.fireSquadAnalytics
    })

    local var21 = React.useCallback(function()
        if squadId and tbl1.conversationId ~= var6 then
            var2(leaveSquad(SquadPromptType.JoinAnotherSquad, var7.setSquadPrompt, function()
                tbl1.navigateToSquadLobby(tbl1.conversationId)
            end, var7.squadLocation, var8))
        else
            tbl1.navigateToSquadLobby(tbl1.conversationId)
        end

        var7.fireSquadAnalytics(EventNames.EnterSquadButtonPressed, {
            conversationId = tbl1.conversationId,
            squadButtonSource = SquadButtonSourceEnum.ChatConversationMoreMenu,
            squadId = squadId,
            squadLocation = var7.squadLocation,
            userIntention = if tbl1.conversation and tbl1.conversation.hasGroupUp and tbl1.conversationId == var6 then SquadButtonClickIntentionEnum.View elseif tbl1.conversation and tbl1.conversation.hasGroupUp then SquadButtonClickIntentionEnum.Join else SquadButtonClickIntentionEnum.Create
        })
    end, {
        tbl1.navigateToSquadLobby,
        tbl1.conversationId,
        tbl1.conversation and tbl1.conversation.hasGroupUp,
        squadId,
        var6,
        var7,
        var8
    })

    local onActivated = React.useCallback(function(arg1)
        if arg1 == "createJoinViewParty" then
            var21()
        elseif arg1 == "scheduleParty" then
            var20()
        end

        var12(false)
    end, { var21, var20 })

    local var9 = React.useCallback(function()
        var1.emit(
            ChatConversationTelemetryEvents.ConversationMoreMenuBtnClicked,
            {
                action = if var11 then ConversationActionType.CloseMoreMenu else ConversationActionType.OpenMoreMenu
            }
        )
        var12(not var11)
    end, { var11, var1 })

    local var13 = React.useCallback(function()
        var14(false)
    end, {})

    local items = React.useMemo(function()
        local result = {}

        table.insert(result, {
            icon = "icons/menu/groups",
            id = "createJoinViewParty",
            isDisabled = false,
            isChecked = false,
            text = if tbl1.conversation and tbl1.conversation.hasGroupUp and tbl1.conversationId == var6 then var4.viewParty elseif tbl1.conversation and tbl1.conversation.hasGroupUp then var4.joinParty else var4.startParty
        })

        table.insert(
            result,
            {
                icon = IconName.Calendar,
                id = "scheduleParty",
                isDisabled = false,
                isChecked = false,
                text = var4.scheduleAParty
            }
        )

        return result
    end, { tbl1.conversation and tbl1.conversation.hasGroupUp, tbl1.conversationId, var6 })

    local var26 = React.useRef(nil)
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = "auto-xy align-y-center" }

    local tbl3 = {
        MoreMenuButton = React.createElement(Foundation.IconButton, {
            icon = {
                name = Foundation.Enums.IconName.PlusLarge,
                variant = if var11 then Foundation.Enums.IconVariant.Filled else Foundation.Enums.IconVariant.Regular
            },
            variant = if var11 then Foundation.Enums.ButtonVariant.Standard else Foundation.Enums.ButtonVariant.Utility,
            isCircular = true,
            LayoutOrder = tbl1.layoutOrder,
            onActivated = var9,
            size = Foundation.Enums.InputSize.Medium,
            testId = "ChatConversationMoreMenuButton",
            ref = var26
        }),
        ScheduledSquadSheet = React.createElement(ScheduledSquadSheet, {
            conversationId = tbl1.conversationId,
            isOpen = isOpen,
            onClose = function()
                var10(false)
            end
        }),
        Menu = React.createElement(Menu, {
            anchorRef = var26,
            items = items,
            isOpen = var11,
            onActivated = onActivated,
            onPressedOutside = onPressedOutside,
            ref = ref,
            side = PopoverSide.Top
        }),
        Tooltip = React.createElement(Foundation.Popover.Root, { isOpen = var5 }, {
            Anchor = React.createElement(Foundation.Popover.Anchor, { anchorRef = var26 }),
            Content = React.createElement(Foundation.Popover.Content, {
                align = {
                    position = PopoverAlign.Start,
                    offset = 0
                },
                backgroundStyle = var3.Inverse.Surface.Surface_0,
                hasArrow = true,
                onPressedOutside = var13
            }, {
                TooltipText = React.createElement(
                    Foundation.Text,
                    {
                        Text = tbl1.tooltipText,
                        tag = "auto-xy text-wrap padding-small content-inverse-emphasis text-body-small"
                    }
                )
            })
        })
    }

    return createElement(view, tbl2, tbl3)
end)
