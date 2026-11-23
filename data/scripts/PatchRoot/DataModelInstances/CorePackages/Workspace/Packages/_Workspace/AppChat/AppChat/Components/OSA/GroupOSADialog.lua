-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local DateTime = require(AppChatParent.Time).DateTime

local Constants = require(AppChat.Constants)
local Conversation = require(AppChat.Models.Conversation)
local var1 = require(AppChat.Logger):new(script.Name)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local ReceivedConversation = require(AppChat.Conversations.Actions.ReceivedConversation)
local ConversationRoduxSeed = require(AppChat.Utils.ConversationRoduxSeed)

local useRecordModalSequenceResponseForConversation = require(AppChat.Hooks.useRecordModalSequenceResponseForConversation)

local Foundation = require(AppChatParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize

local ButtonVariant = Foundation.Enums.ButtonVariant
local BadgeVariant = Foundation.Enums.BadgeVariant
local EnumsOrientation = Foundation.Enums.Orientation
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local InputHandlers = require(AppChatParent.InputHandlers)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useDefaultFocusBehavior = require(AppChatParent.ReactFocusNavigation).useDefaultFocusBehavior

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local Responsive = require(AppChatParent.Responsive)
local useLastInput = Responsive.useLastInput

local UserRow = require(AppChatParent.UserList).UserRow

local UserProfiles = require(AppChatParent.UserProfiles)
local useUserProfilesFetch = UserProfiles.Hooks.useUserProfilesFetch
local getCombinedNameFromId = UserProfiles.Selectors.getCombinedNameFromId

local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useStore = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useStore
local useEffect = React.useEffect
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local API = AppChatNetworking.rodux.GetConversationDetails.API
local API2 = AppChatNetworking.rodux.RemoveUserFromConversation.API

local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local AppTelemetryLayer = require(AppChat.Telemetry.Layers.AppTelemetryLayer)

local ConversationListOverlayTelemetry = require(AppChat.Components.OSA.ConversationListOverlayTelemetry)
local ModalTelemetry = require(AppChat.Components.ModalTelemetry)
local SquadExternalContractContext = require(AppChatParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadPromptType = require(AppChatParent.SquadsCore.Enums).SquadPromptType

local shouldShowU13ChatOptInForConversation = require(AppChat.Utils.shouldShowU13ChatOptInForConversation)

local FFlagAppChatEnableU13ChatOptIn = require(AppChatParent.SharedFlags).FFlagAppChatEnableU13ChatOptIn

local FFlagFriendsChatEnableConversationConsent = require(AppChatParent.SharedFlags).FFlagFriendsChatEnableConversationConsent
local FFlagAppChatUseUserProfileHydration = require(AppChat.Flags.FFlagAppChatUseUserProfileHydration)
local useProfileName = require(AppChat.Hooks.useProfileName)
local DataStatus = require(AppChatParent.DataHydration).DataStatus
local osaViewDetailsUrl = game:DefineFastString(
    "AppChatGroupOsaViewDetailsUrl",
    "https://en.help.roblox.com/hc/en-us/articles/360000432483-Party-chat-In-App"
)

local InlineRichText = require(AppChatParent.InlineRichText)
local Renderer = InlineRichText.Renderer
local LinkBehavior = InlineRichText.Enums.LinkBehavior
local useAppPolicy = require(AppChat.Hooks.useAppPolicy)

local bool1 = game.PlaceId > 0

local tbl2 = { source = nil, createdAt = nil, title = "" }

local ConversationListOverlay = Constants.ModalSequence.ConversationListOverlay
local OsaContextCard = Constants.OptInVariant.OsaContextCard
local Accept = Constants.ModalAction.Accept

local tbl3 = {
    dialogSize = DialogSize.Medium,
    disablePortal = false,
    hasBackdrop = true,
    onClose = function() end,
    onJoin = function() end,
    onDecline = function() end
}

local function resolveModalVariant(arg1, arg2) -- Luacid: unused: defined but never referenced
    return arg1
        or (if shouldShowU13ChatOptInForConversation(arg2) then Constants.OptInVariant.ChatOptInInfoCard else OsaContextCard)
end

local function GroupOSADialog(tbl4)
    local var2 = Cryo.Dictionary.union(tbl3, tbl4)
    local var3 = if FFlagAppChatEnableU13ChatOptIn then var2.modalVariant else OsaContextCard
    local var4 = useDispatch()
    local var5 = useStore()
    local var6 = useLocalUserId()
    local var7 = useTokens()

    local var8 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)
    local linkerOptions = React.useMemo(function()
        return {
            evaluateLinkBehavior = function(_, _)
                return if var8 and not bool1 then LinkBehavior.Webview else LinkBehavior.Hide
            end
        }
    end, { var8 })

    local isDisabled, var11 = React.useState(false)
    useEffect(function()
        return function()
            var11(false)
        end
    end, {})

    local var12 = useTelemetry(AppTelemetryLayer.Context)
    useEffect(function()
        var12.emit(
            ConversationListOverlayTelemetry.Events.ModalRendered,
            {
                modalVariant = var3,
                conversationId = var2.conversationId,
                impressionId = var2.impressionId
            }
        )
    end, {
        var12,
        var2.impressionId,
        var2.conversationId,
        var3
    })

    local var13 = React.useContext(SquadExternalContractContext)

    local var14 = useGetConversationFromId(var2.conversationId)
    local var15 = var14 or tbl2
    if FFlagAppChatEnableU13ChatOptIn then
        local var16 = var3

        if var16 then
            var3 = var16
        elseif shouldShowU13ChatOptInForConversation(var15) then
            var3 = Constants
            var3 = var3.OptInVariant
            var3 = var3.ChatOptInInfoCard
        else
            var3 = OsaContextCard
        end
    end

    useEffect(function()
        if not var2.conversationId or var14 then
            return
        end

        if not FFlagFriendsChatEnableConversationConsent then
            var4(API(var2.conversationId)):catch(function(arg1)
                var1:warning("Error fetching conversation in GroupOSADialog: " .. tostring(arg1))
                var2.onClose()
            end)

            return
        end

        local var16 = GetConversationStore(false).getConversation(var2.conversationId, false)
        if var16 then
            var4(ReceivedConversation(ConversationRoduxSeed.normalizeStoreConversationForRodux(var16)))
        end

        if ConversationRoduxSeed.isFriendsPlaceholderConversationId(var2.conversationId) then
            return
        end

        var4(API(var2.conversationId)):catch(function(arg1)
            var1:warning("Error fetching conversation in GroupOSADialog: " .. tostring(arg1))
            if var16 == nil then
                var2.onClose()
            end
        end)
    end, {
        var4,
        var2.conversationId,
        var14,
        var2.onClose
    })

    local source = var15.source

    local var16 = useSelector(function(arg1)
        return getDeepValue2(arg1, `ChatAppReducer.ParticipantMetadata.{var2.conversationId or ""}`)
    end)

    useEffect(function()
        if source ~= "channels" or var2.conversationId == nil then
            return
        end
        var4(AppChatNetworking.rodux.GetConversationsParticipantsMetadata.API({ var2.conversationId })):catch(function()
            var1:warning("Error in GroupOSADialog -> GetConversationsParticipantsMetadata")
        end)
    end, { var4, var2.conversationId, source })

    local var17 = React.useMemo(function()
        if not var16 then
            return nil
        end
        for value, value2 in var16 do
            if value2.isInviter then
                return value
            end
        end
        return nil
    end, { var16 })

    local var18 = nil
    local var19 = nil
    if FFlagAppChatUseUserProfileHydration then
        var19 = useProfileName(var17)
    else
        var18 = useUserProfilesFetch(
            {
                userIds = var17 and { var17 } or {},
                query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
            }
        )
    end

    local var20 = React.useMemo(function()
        if not (var15 and var15.participants) then
            return {}
        end
        return Cryo.List.filter(var15.participants, function(arg1): boolean
            return tostring(arg1) ~= var6
        end)
    end, { var15, var6 })

    local creationDate = React.useMemo(function()
        if var15.createdAt then
            return DateTime.fromIsoDate(var15.createdAt):Format("MMM DD, YYYY")
        end
        var1:warning("Conversation createdAt not found for conversationId: " .. tostring(var2.conversationId))
        return " - "
    end, { var15, var2.conversationId })

    local data = if var18 then var18.data else nil
    local combinedName = if FFlagAppChatUseUserProfileHydration then var19.combinedName else nil
    local var22 = if FFlagAppChatUseUserProfileHydration then var19.status == DataStatus.NotReady and combinedName == nil elseif var18 then var18.loading else false

    local var9 = React.useMemo(function()
        if FFlagAppChatUseUserProfileHydration then
            return combinedName
        elseif not (var17 and data) then
            return nil
        end
        return getCombinedNameFromId(data, var17)
    end, { var17, data, combinedName })

    local bool2 = var15.conversationType == Conversation.Type.MULTI_USER_CONVERSATION

    local var24 = useLocalization({
        titleText = "Feature.Chat.Heading.YouWereInvitedToGroup",
        inviterTitleText = {
            "Feature.Chat.Heading.UserInvitedYouToJoinAGroup",
            combinedName = var9 or ""
        },
        inviterTitleTextOneToOne = {
            "Feature.Chat.Heading.UserInvitedYouToJoin",
            combinedName = var9 or ""
        },
        subtitleText = {
            "Feature.Chat.Description.ConversationInviteGroupCreatedOn",
            creation_date = creationDate
        },
        footerText = {
            "Feature.Chat.Description.OSAGroupDescriptionWithLinker",
            osaViewDetailsUrl = osaViewDetailsUrl
        },
        joinButtonText = "Feature.Chat.Action.GroupOSAJoin",
        declineButtonText = "Feature.Chat.Action.GroupOSADoNotJoin",
        blockedText = "Feature.Chat.Label.Blocked"
    })

    local var25 = React.useMemo(function()
        local result = ({})

        for layoutOrder, value2 in var20 do
            local entityId = tostring(value2)
            local var25 = var16 and var16[entityId]

            if not var25 then
                var1:debug("Metadata not found for participant: " .. entityId)
            end

            local isBlocked = var25 and var25.isBlocked

            local row = React.createElement(UserRow, {
                entityId = entityId,
                layoutMode = "wide",
                onActivated = var2.onViewUserProfile ~= nil and function()
                    var2.onClose()
                    var2.onViewUserProfile(entityId, {})
                end or nil
            })

            local str3 = "Participant_" .. entityId
            local createElement = React.createElement
            local view = Foundation.View
            local tbl5 = { tag = "size-full-0 auto-y", LayoutOrder = layoutOrder }
            local tbl6 = { Row = row, Badge = 0 }
            local var26

            if isBlocked then
                local createElement2 = React.createElement
                local view2 = Foundation.View

                local tbl7 = {
                    BadgeContent = React.createElement(Foundation.Badge, { text = var24.blockedText, variant = BadgeVariant.Warning })
                }
                var26 = createElement2(view2, { tag = "position-center-right anchor-center-right auto-xy", ZIndex = 2 }, tbl7) or nil
            else
                var26 = nil
            end

            tbl6.Badge = var26
            result[str3] = createElement(view, tbl5, tbl6)
        end

        return result
    end, {
        var20,
        var16,
        var24.blockedText,
        var2.onViewUserProfile,
        var2.onClose
    })

    local var26 = React.useCallback(function()
        var12.emit(ConversationListOverlayTelemetry.Events.ModalAction, {
            modalVariant = var3,
            action = ModalTelemetry.Enums.ModalActions.Dismiss,
            conversationId = var2.conversationId,
            impressionId = var2.impressionId
        })
        var2.onClose()
    end, {
        var2.onClose,
        var12,
        var2.impressionId,
        var2.conversationId,
        var3
    })
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    var26()
                    arg1:cancel()
                end)
            }
        }
    end, { var26 })

    local var28 = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false,
        eventHandlers = eventHandlers,
        eventMap = eventMap
    })

    local ref, var10 = useDefaultFocusBehavior(var28)

    local bool3 = useLastInput() == Responsive.Input.Directional

    local var31 = React.useCallback(function()
        var13.setSquadPrompt(var5, { hideCancelButton = true, promptType = SquadPromptType.Error })
    end, { var13.setSquadPrompt, var5 })

    local var32 = useRecordModalSequenceResponseForConversation(var2.conversationId)
    local onActivated = React.useCallback(function()
        if isDisabled then
            return
        end
        var11(true)

        local tbl5 = {
            modalVariant = var3,
            action = ModalTelemetry.Enums.ModalActions.PrimaryCta,
            conversationId = var2.conversationId,
            impressionId = var2.impressionId
        }
        var12.emit(ConversationListOverlayTelemetry.Events.ModalAction, tbl5)
        var32(Accept, ConversationListOverlay, nil, var3):andThen(function()
            var12.emit(
                ConversationListOverlayTelemetry.Events.ModalActionResult,
                Cryo.Dictionary.union(tbl5, { actionResult = ModalTelemetry.Enums.ModalActionResults.Success })
            )

            var2.onJoin()
        end):catch(function(arg1)
            var12.emit(
                ConversationListOverlayTelemetry.Events.ModalActionResult,
                Cryo.Dictionary.union(tbl5, { actionResult = ModalTelemetry.Enums.ModalActionResults.Failure })
            )

            var1:warning(`Error in GroupOSADialog Join-> RecordModalSequenceResponse: {tostring(arg1)}`)
            var31()
            var2.onClose()
        end)
    end, {
        var2.onJoin,
        var2.onClose,
        var31,
        var32,
        var4,
        var2.conversationId,
        var3,
        var12,
        var2.impressionId,
        isDisabled
    })

    local var21 = React.useCallback(function()
        if isDisabled then
            return
        end
        var11(true)

        local tbl5 = {
            modalVariant = var3,
            action = ModalTelemetry.Enums.ModalActions.SecondaryCta,
            conversationId = var2.conversationId,
            impressionId = var2.impressionId
        }
        var12.emit(ConversationListOverlayTelemetry.Events.ModalAction, tbl5)
        if not var2.conversationId then
            return
        end

        if var15.conversationType ~= Conversation.Type.MULTI_USER_CONVERSATION then
            var12.emit(
                ConversationListOverlayTelemetry.Events.ModalActionResult,
                Cryo.Dictionary.union(tbl5, { actionResult = ModalTelemetry.Enums.ModalActionResults.Success })
            )

            var2.onDecline()
            return
        end

        var4(API2(var2.conversationId, var6)):andThen(function()
            var12.emit(
                ConversationListOverlayTelemetry.Events.ModalActionResult,
                Cryo.Dictionary.union(tbl5, { actionResult = ModalTelemetry.Enums.ModalActionResults.Success })
            )

            var2.onDecline()
        end):catch(function(arg1)
            var12.emit(
                ConversationListOverlayTelemetry.Events.ModalActionResult,
                Cryo.Dictionary.union(tbl5, { actionResult = ModalTelemetry.Enums.ModalActionResults.Failure })
            )

            var1:warning(`Error in GroupOSADialog Decline -> RemoveUserFromConversation: {tostring(arg1)}`)

            var31()
            var2.onClose()
        end)
    end, {
        var2.onDecline,
        var2.onClose,
        var31,
        var4,
        var2.conversationId,
        var3,
        var15,
        var6,
        var12,
        var2.impressionId,
        isDisabled,
        var6
    })

    local bool4 = not var14
    local bool5 = var15.source == "channels" and var16 == nil

    if var17 == nil then
        var22 = false
    end

    local var35 = bool4 or bool5 or var22
    local text = if var9 then if bool2 then var24.inviterTitleText else var24.inviterTitleTextOneToOne else var24.titleText

    local var37 = React.useMemo(function()
        return React.createElement(Foundation.View, {
            tag = "col gap-medium size-full-0 auto-y margin-top-small"
        }, {
            Heading = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(0.6, 0, 0, var7.Size.Size_1100),
                    radius = Radius.Medium,
                    LayoutOrder = 1
                }
            ),
            Row1 = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(1, 0, 0, var7.Size.Size_1200),
                    radius = Radius.Medium,
                    LayoutOrder = 2
                }
            ),
            Row2 = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(1, 0, 0, var7.Size.Size_1200),
                    radius = Radius.Medium,
                    LayoutOrder = 3
                }
            ),
            Row3 = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(1, 0, 0, var7.Size.Size_1200),
                    radius = Radius.Medium,
                    LayoutOrder = 4
                }
            ),
            Footer = React.createElement(
                Skeleton,
                {
                    Size = UDim2.new(1, 0, 0, var7.Size.Size_800),
                    radius = Radius.Medium,
                    LayoutOrder = 5
                }
            )
        })
    end, { var7 })

    local var38 = React.useMemo(function()
        return React.createElement(Foundation.View, { tag = "col gap-medium size-full-0 auto-y" }, {
            DialogContentHeader = React.createElement(Dialog.Text, { Text = var24.subtitleText, LayoutOrder = 1 }),
            GroupMemberList = React.createElement(Foundation.View, { tag = "col size-full-0 auto-y", LayoutOrder = 2 }, var25),
            DialogContentFooter = React.createElement(Renderer, {
                text = var24.footerText,
                textStyle = var7.Color.Content.Default,
                fontStyle = var7.Typography.BodyMedium,
                linkerOptions = linkerOptions,
                wrapperProps = { tag = "size-full-0 auto-y", LayoutOrder = 3 }
            })
        })
    end, {
        var24.subtitleText,
        var24.footerText,
        var25,
        var7.Color.Content.Default,
        var7.Typography.BodyMedium,
        linkerOptions
    })

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl5 = {
        ref = var10,
        size = var2.dialogSize,
        onClose = if bool3 then nil else var26,
        hasBackdrop = var2.hasBackdrop,
        disablePortal = var2.disablePortal
    }
    local tbl6 = {
        DialogTitle = not var35 and React.createElement(Dialog.Title, { text = text, LayoutOrder = 1 }),
        DialogContent = 0,
        DialogActions = 0
    }

    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl7 = { LayoutOrder = 2 }

    if not var35 then
        var37 = var38
    end

    tbl6.DialogContent = createElement2(content, tbl7, var37)

    tbl6.DialogActions = not var35
        and React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            orientation = EnumsOrientation.Vertical,
            actions = {
                {
                    text = var24.joinButtonText,
                    variant = ButtonVariant.Emphasis,
                    ref = ref,
                    onActivated = onActivated,
                    isDisabled = isDisabled
                },
                {
                    text = var24.declineButtonText,
                    variant = ButtonVariant.Standard,
                    onActivated = var21,
                    isDisabled = isDisabled
                }
            }
        })
    return createElement(root, tbl5, tbl6)
end

return GroupOSADialog
