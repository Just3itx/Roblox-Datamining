-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildAdUpsell = require(BuildExperience.Flags.FFlagBuildAdUpsell)
local FFlagBuildAdUpsellPinned = require(BuildExperience.Flags.FFlagBuildAdUpsellPinned)
local FFlagBuildAdsManagerUniverseUrl = require(BuildExperience.Flags.FFlagBuildAdsManagerUniverseUrl)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)

local chatConstants = require(BuildExperience.Chat.chatConstants)
local ChatPermissionsContext = require(BuildExperience.Chat.ChatPermissionsContext)
local ChatScrollAnchorContext = require(BuildExperience.Chat.ChatScrollAnchorContext)
local _chatTypes = require(BuildExperience.Chat.chatTypes)

local ChatCardEmphasisPositionProvider = require(BuildExperience.Components.Chat.ChatCardEmphasis.ChatCardEmphasisPositionProvider)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)
local BuildEmptyState = require(BuildExperience.Components.BuildEmptyState.BuildEmptyState)
local var1 = CreatorAgentChat.experimentOverride.isEnabled()
local AgentSpecDebugSheet = if var1 then require(BuildExperience.Components.AgentSpecDebug.AgentSpecDebugSheet) else nil
local BuildOverflowMenuButton = require(BuildExperience.Components.BuildPillMenu.BuildOverflowMenuButton)
local PlayButton = require(BuildExperience.Components.PlayButton.PlayButton)
local BuyMoreRobuxCard = require(BuildExperience.Components.Chat.BuyMoreRobuxCard)
local ChatActions = require(BuildExperience.Components.Chat.ChatActions)
local ChatMessageList = require(BuildExperience.Components.Chat.ChatMessageList)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local AnswerFormContainer = if FFlagBuildExperienceAnswerForm then require(BuildExperience.Components.AnswerForm.AnswerFormContainer) else nil
local PushNotificationsUpsellCard = require(BuildExperience.Components.Chat.PushNotificationsUpsellCard)
local AdUpsellMilestoneContainer = if FFlagBuildAdUpsell then require(BuildExperience.Components.Ads.AdUpsellMilestone.AdUpsellMilestoneContainer) else nil
local CreateAdCampaignSheetContainer = if FFlagBuildAdUpsell then require(BuildExperience.Components.Ads.CreateAdCampaignSheet.CreateAdCampaignSheetContainer) else nil
local AdCampaignCreatedToast = if FFlagBuildAdUpsell then require(BuildExperience.Components.Ads.AdCampaignCreatedToast) else nil
local _GetBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore)

local _createBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore.createBuildOverflowMenuStore)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary
local _useChatSessionCore = require(BuildExperience.Chat.useChatSessionCore)
local FFlagEnableBuildAdPromotion = require(BuildExperience.Flags.FFlagEnableBuildAdPromotion)

local FFlagBuildExperienceChatAccordionScrollAnchor = require(BuildExperience.Flags.FFlagBuildExperienceChatAccordionScrollAnchor)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local _useGamePermissions = require(BuildExperience.useGamePermissions)
local useScrollPerformanceTracker = require(BuildExperience.Telemetry.useScrollPerformanceTracker)

local Divider = Foundation.Divider
local IconButton = Foundation.IconButton
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens

local function groupAdUpsellCardsByAnchorIndex(adUpsellCards)
    local result = {}
    for _, adUpsellCard in adUpsellCards do
        if adUpsellCard.anchorIndex ~= nil then
            local var2 = result[adUpsellCard.anchorIndex] or {}
            table.insert(var2, adUpsellCard)
            result[adUpsellCard.anchorIndex] = var2
        end
    end
    return result
end

local function renderAdUpsells(tbl1, tbl2, scrollingFrameRef, congratsText: string?)
    local var2 = table.clone(tbl2)
    if FFlagBuildAdUpsell and FFlagBuildAdUpsellPinned and tbl1.adUpsellCongratsAnchorIndex ~= nil then
        var2.AdUpsellCongrats = React.createElement(FoundationText, {
            LayoutOrder = tbl1.adUpsellCongratsAnchorIndex * chatConstants.MESSAGE_LAYOUT_ORDER_STRIDE + 1,
            Text = congratsText,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis",
            testId = "AdUpsellCongrats"
        })
    end

    if FFlagBuildAdUpsell and not FFlagBuildAdUpsellPinned then
        for value, value2 in (groupAdUpsellCardsByAnchorIndex(tbl1.adUpsellCards)) do
            local tbl3 = ({})
            local tbl4 = {}
            for _, value3 in value2 do
                table.insert(tbl4, value3.id)
                local id = value3.id
                tbl3[id] = React.createElement(AdUpsellMilestoneContainer, {
                    anchorId = value3.id,
                    order = value3.order,
                    isImpressed = value3.isImpressed,
                    congratsText = congratsText,
                    freePromotionsRemaining = if FFlagBuildAgentAdCampaignCard then tbl1.adUpsellFreePromotionsRemaining else nil,
                    isCreatePending = tbl1.isAdUpsellCreatePending,
                    isCreateDisabled = tbl1.isAdUpsellCreateDisabled,
                    isPageVisible = tbl1.isAdUpsellVisible,
                    onCreate = tbl1.onAdUpsellCreate,
                    onDismiss = tbl1.onAdUpsellDismiss,
                    onImpression = tbl1.onAdUpsellImpression,
                    scrollingFrameRef = scrollingFrameRef
                })
                if not FFlagBuildExperienceChatCardEmphasis then
                    continue
                end

                local id2 = value3.id
                tbl3[id2] = React.createElement(
                    ChatCardEmphasisPositionProvider,
                    {
                        messageOrder = value * chatConstants.MESSAGE_LAYOUT_ORDER_STRIDE + 1,
                        segmentOrder = value3.order
                    },
                    tbl3[value3.id]
                )
            end
            local str1 = `AdUpsellGroup:{table.concat(tbl4, "|")}`
            var2[str1] = React.createElement(View, {
                LayoutOrder = value * chatConstants.MESSAGE_LAYOUT_ORDER_STRIDE + 1,
                tag = "col gap-medium size-full-0 auto-y",
                testId = `AdUpsellGroup.{value}`
            }, tbl3)
        end
    end

    local tbl3 = ({})
    if FFlagBuildAdUpsell and FFlagBuildAdUpsellPinned then
        for _, adUpsellCard in tbl1.adUpsellCards do
            local id = adUpsellCard.id
            tbl3[id] = React.createElement(AdUpsellMilestoneContainer, {
                anchorId = adUpsellCard.id,
                order = adUpsellCard.order,
                isImpressed = adUpsellCard.isImpressed,
                freePromotionsRemaining = if FFlagBuildAgentAdCampaignCard then tbl1.adUpsellFreePromotionsRemaining else nil,
                isCreatePending = tbl1.isAdUpsellCreatePending,
                isCreateDisabled = tbl1.isAdUpsellCreateDisabled,
                isPageVisible = tbl1.isAdUpsellVisible,
                onCreate = tbl1.onAdUpsellCreate,
                onDismiss = tbl1.onAdUpsellDismiss,
                onImpression = tbl1.onAdUpsellImpression
            })
        end
    end

    return var2, tbl3
end

local function BuildChatPageView(tbl1)
    local var2 = FFlagBuildExperienceAnswerForm and tbl1.answerForm ~= nil
    local bool1 = false
    local var3 = nil
    if var1 then
        local var4
        bool1, var4 = React.useState(false)
        var3 = var4
    end
    local var4 = useLocalization({
        composerPlaceholder = LocalizationStrings.CHAT_COMPOSER_PLACEHOLDER,
        adUpsellCongrats = if FFlagBuildAdUpsell then tbl1.adUpsellFreePromotionsRemaining ~= 1
            and {
                LocalizationStrings.AD_UPSELL_CONGRATS,
                promotionCount = tbl1.adUpsellFreePromotionsRemaining
            }
            or LocalizationStrings.AD_UPSELL_CONGRATS_SINGULAR else nil,
        adCampaignCreated = if FFlagBuildAdUpsell then LocalizationStrings.ADS_STATS_CREATE_SUCCESS else nil,
        adCampaignCreatedView = if FFlagBuildAdUpsell then LocalizationStrings.AD_CAMPAIGN_CARD_VIEW else nil
    })
    local var5 = useTokens()
    local scrollingFrameRef = React.useRef(nil)
    useScrollPerformanceTracker("LuaApp_Build_Chat_Scroll", scrollingFrameRef)

    local var6 = React.useCallback(function(current)
        scrollingFrameRef.current = current
        tbl1.scrollingFrameRef(current)
    end, { tbl1.scrollingFrameRef })

    local var8 = ChatMessageList({
        isPageVisible = tbl1.isAdUpsellVisible,
        scrollingFrameRef = scrollingFrameRef,
        isAgentAdCampaignCreateDisabled = tbl1.isAgentAdCampaignCreateDisabled,
        messages = tbl1.messages,
        clockBinding = tbl1.clockBinding,
        localToolActions = tbl1.localToolActions,
        emptyState = if var2 then nil else React.createElement(BuildEmptyState),
        isHistoryLoading = tbl1.isHistoryLoading,
        onPlaytest = tbl1.onPlaytest,
        onPublish = tbl1.onPublish,
        isPlaytestLoading = tbl1.isPlaytestLoading,
        onAgentAdCampaignOfferSelected = if FFlagBuildAgentAdCampaignCard then tbl1.onAgentAdCampaignOfferSelected else nil,
        getAgentAdCampaignCardState = if FFlagBuildAgentAdCampaignCard then tbl1.getAgentAdCampaignCardState else nil,
        onAgentAdCampaignActive = if FFlagBuildAgentAdCampaignCard then tbl1.onAgentAdCampaignActive else nil
    })
    local bool2 = false
    for _, value in tbl1.messages do
        if value.kind == "user_message" then
            bool2 = true
            break
        end
    end

    local messageLayoutOrderStride = chatConstants.MESSAGE_LAYOUT_ORDER_STRIDE
    if tbl1.showPushNotificationsUpsell and bool2 and tbl1.isAssistantResponding then
        var8.PushNotificationsUpsell = React.createElement(PushNotificationsUpsellCard, {
            LayoutOrder = (#tbl1.messages + 1) * messageLayoutOrderStride,
            isRequestPending = tbl1.isPushNotificationsRequestPending,
            shouldOpenSettings = tbl1.shouldOpenPushNotificationsSettings,
            onNotifyMe = tbl1.onNotifyMe,
            onOpenSettings = tbl1.onOpenPushNotificationsSettings,
            onNotNow = tbl1.onNotNow
        })
    end

    local var9, tbl2 = renderAdUpsells(tbl1, var8, scrollingFrameRef, var4.adUpsellCongrats)

    if var2 then
        var9.AnswerForm = React.createElement(AnswerFormContainer, {
            LayoutOrder = (#tbl1.messages + 2) * chatConstants.MESSAGE_LAYOUT_ORDER_STRIDE,
            state = tbl1.answerForm,
            actions = tbl1.localToolActions,
            onSubmitText = tbl1.onSubmitAnswerText,
            onStop = tbl1.onStop,
            errorText = tbl1.composerErrorText,
            isReadOnly = tbl1.isChatReadOnly
        })
    end
    local var10 = FFlagBuildExperienceChatAccordionScrollAnchor
        and {
            ScrollAnchor = React.createElement(ChatScrollAnchorContext.Provider, { value = tbl1.anchorScrollToInstance }, var9)
        }
        or var9

    local var11 = FFlagBuildCheckGamePermissions
        and {
            Permissions = React.createElement(ChatPermissionsContext.Provider, { value = tbl1.chatPermissions }, var10)
        }
        or var10

    local createElement = React.createElement
    local var12 = View
    local tbl3 = {
        tag = {
            ["composition-content-body size-full-0 auto-y"] = true,
            ["col gap-medium"] = tbl1.showBuyMoreRobuxCard or FFlagBuildAdUpsellPinned and #tbl1.adUpsellCards > 0
        },
        testId = "BuildChatPage.ActionBody"
    }

    local tbl4 = { BuyMoreRobux = 0, AdUpsells = 0, Footer = 0 }
    local element

    if tbl1.showBuyMoreRobuxCard then
        element = React.createElement(BuyMoreRobuxCard, {
            LayoutOrder = 1,
            title = tbl1.buyMoreRobuxCardTitle,
            description = tbl1.buyMoreRobuxCardDescription,
            primaryActionText = tbl1.buyMoreRobuxCardPrimaryActionText,
            onPrimaryAction = tbl1.onBuyMoreRobuxCardPrimaryAction,
            secondaryActionText = tbl1.buyMoreRobuxCardSecondaryActionText,
            onSecondaryAction = tbl1.onBuyMoreRobuxCardSecondaryAction
        })
    else
        element = nil
    end

    tbl4.BuyMoreRobux = element

    tbl4.AdUpsells = if FFlagBuildAdUpsell and FFlagBuildAdUpsellPinned and #tbl1.adUpsellCards > 0 then React.createElement(
        View,
        {
            LayoutOrder = if tbl1.showBuyMoreRobuxCard then 2 else 1,
            tag = "col gap-medium size-full-0 auto-y",
            testId = "BuildChatPage.AdUpsells"
        },
        tbl2
    ) else nil
    local element2

    if var2 then
        element2 = nil
    else
        element2 = React.createElement(ChatActions, {
            LayoutOrder = if tbl1.showBuyMoreRobuxCard then if FFlagBuildAdUpsellPinned and #tbl1.adUpsellCards > 0 then 3 else 2 elseif FFlagBuildAdUpsellPinned and #tbl1.adUpsellCards > 0 then 2 else nil,
            modelPicker = if FFlagBuildExperienceModelPicker then tbl1.modelPicker else nil,
            composerText = tbl1.composerText,
            composerErrorText = tbl1.composerErrorText,
            onComposerChanged = tbl1.onComposerChanged,
            promptChips = tbl1.promptChips,
            isPromptChipsLoading = tbl1.isPromptChipsLoading,
            onPromptChipActivated = tbl1.onPromptChipActivated,
            onPromptChipExhausted = tbl1.onPromptChipExhausted,
            images = tbl1.composerImages,
            onImagesChanged = tbl1.onComposerImagesChanged,
            onRetryImage = tbl1.onRetryComposerImage,
            isSendBlocked = tbl1.isComposerSendBlocked,
            resourceAttachments = tbl1.composerResourceAttachments,
            onRemoveResourceAttachment = tbl1.onRemoveComposerResourceAttachment,
            placeholder = var4.composerPlaceholder,
            textBoxRef = tbl1.textBoxRef,
            isAssistantResponding = tbl1.isAssistantResponding,
            canStopAssistantResponse = tbl1.canStopAssistantResponse,
            canSendWhileResponding = tbl1.canSendWhileResponding,
            isReadOnly = tbl1.isChatReadOnly,
            onSend = tbl1.onSend,
            onStop = tbl1.onStop
        })
    end

    tbl4.Footer = element2
    local actionBody = createElement(var12, tbl3, tbl4)

    local createElement2 = React.createElement
    local var13 = View
    local tbl5 = {
        onAbsolutePositionChanged = tbl1.onPageMetricsChanged,
        onAbsoluteSizeChanged = tbl1.onPageMetricsChanged,
        tag = "col align-x-center size-full bg-surface-0",
        padding = {
            bottom = UDim.new(0, tbl1.paddingBottom)
        }
    }
    local tbl6 = {
        Header = 0,
        Messages = 0,
        AgentSpecSheet = 0,
        Actions = 0,
        AdCampaignSheet = 0,
        AgentAdCampaignSheet = 0,
        AdCampaignCreatedToast = 0
    }
    local createElement3 = React.createElement
    local var14 = View
    local tbl7 = { LayoutOrder = 1, tag = "col align-x-center size-full-0 auto-y bg-surface-0" }

    local tbl8 = { HeaderBar = 0, Divider = 0 }
    local createElement4 = React.createElement
    local var15 = View
    local tbl9 = {
        LayoutOrder = 1,
        tag = "composition-content-header row align-y-center gap-small size-full-0 auto-y padding-y-medium",
        testId = "BuildChatPage.HeaderBar"
    }

    local tbl10 = {
        Library = if FFlagBuildExperienceLibrary then React.createElement(IconButton, {
            LayoutOrder = 5,
            icon = IconName.SquaresGridPlus,
            isCircular = true,
            isDisabled = tbl1.isLibraryDisabled,
            onActivated = tbl1.onOpenLibrary,
            size = InputSize.Large,
            testId = "BuildChatPage.LibraryButton",
            variant = ButtonVariant.Utility
        }) else nil,
        Back = React.createElement(IconButton, {
            LayoutOrder = 1,
            icon = IconName.ChevronLargeLeft,
            isCircular = true,
            onActivated = tbl1.onClose,
            size = InputSize.Large,
            testId = "BuildChatPage.BackButton"
        }),
        Title = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = if tbl1.isNewGameTarget then chatConstants.BUILD_CHAT_PAGE_TITLE else tbl1.target.experienceName,
            tag = "fill text-heading-small text-align-x-left text-truncate-split content-emphasis"
        }),
        Play = React.createElement(PlayButton, {
            LayoutOrder = 3,
            activeIcon = IconName.PlaySmall,
            inActiveIcon = IconName.PlaySmall,
            isActive = true,
            isDisabled = tbl1.isNewGameTarget and not tbl1.hasPublishedTurn,
            isUnavailable = tbl1.isPlaytestDisabled,
            onActivated = tbl1.onPlayActivated,
            variant = ButtonVariant.Utility
        }),
        AgentSpec = 0,
        Overflow = 0
    }
    local var16

    if var1 and (not FFlagBuildExperienceModelPicker or tbl1.modelPicker == nil) then
        local createElement5 = React.createElement
        local var17 = IconButton
        local tbl11 = {
            LayoutOrder = 5,
            icon = {
                name = IconName.LabBeaker,
                variant = if tbl1.agentSpecVersion ~= nil then IconVariant.Filled else IconVariant.Regular
            },
            isCircular = true,
            onActivated = 0,
            size = 0,
            testId = "BuildChatPage.AgentSpecButton",
            variant = 0
        }

        function tbl11.onActivated()
            var3(true)
        end
        tbl11.size = InputSize.Large

        tbl11.variant = ButtonVariant.Utility
        var16 = createElement5(var17, tbl11)
    else
        var16 = nil
    end

    tbl10.AgentSpec = var16

    tbl10.Overflow = React.createElement(BuildOverflowMenuButton, {
        layoutOrder = 6,
        icon = IconName.ThreeDotsHorizontal,
        isDisabled = false,
        hasPublishedTurn = tbl1.hasPublishedTurn,
        hasPublishedVersion = tbl1.hasPublishedVersion,
        target = {
            universeId = tbl1.target.universeId,
            placeId = tbl1.target.placeId,
            sessionId = tbl1.target.sessionId,
            isNewGameTarget = tbl1.isNewGameTarget
        },
        store = tbl1.buildOverflowMenuStore,
        onAction = tbl1.onOverflowMenuAction,
        onOpenCreatorCreditPage = tbl1.onOpenCreatorCreditPage,
        onOpenGetUsersPage = tbl1.onOpenGetUsersPage,
        isUniversePublic = if FFlagEnableBuildAdPromotion then tbl1.isUniversePublic else nil
    })
    tbl8.HeaderBar = createElement4(var15, tbl9, tbl10)

    tbl8.Divider = React.createElement(
        Divider,
        {
            LayoutOrder = 3,
            Visible = tbl1.isChatScrollable,
            testId = "BuildChatPage.HeaderDivider"
        }
    )
    tbl6.Header = createElement3(var14, tbl7, tbl8)

    tbl6.Messages = React.createElement(ScrollView, {
        LayoutOrder = 2,
        scrollingFrameRef = var6,
        onAbsoluteCanvasSizeChanged = tbl1.onChatViewportChanged,
        onAbsoluteWindowSizeChanged = tbl1.onChatViewportChanged,
        tag = { ["composition-layout-detail"] = true, ["fill size-full-0"] = true },
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y
        }
    }, {
        MessageColumn = React.createElement(View, {
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, var5.Size.Size_800)
            },
            tag = {
                ["composition-content-body"] = true,
                ["size-full"] = tbl1.isChatEmpty and not var2,
                ["size-full-0 auto-y padding-y-large"] = not tbl1.isChatEmpty or var2
            },
            testId = "BuildChatPage.MessageBody"
        }, var11)
    })

    tbl6.AgentSpecSheet = if var1 and bool1 then React.createElement(AgentSpecDebugSheet, {
        specVersion = tbl1.agentSpecVersion,
        onSave = tbl1.setAgentSpecVersion,
        onClose = function()
            var3(false)
        end
    }) else nil

    tbl6.Actions = React.createElement(View, {
        LayoutOrder = 3,
        tag = { ["composition-layout-detail"] = true, ["size-full-0 auto-y"] = true },
        testId = "BuildChatPage.ActionLayout"
    }, { ActionBody = actionBody })
    local element4

    if FFlagBuildAdUpsell and tbl1.isAdUpsellVisible then
        element4 = React.createElement(CreateAdCampaignSheetContainer, {
            universeId = if FFlagBuildAdsManagerUniverseUrl then tbl1.target.universeId else nil,
            isOpen = tbl1.isAdCampaignSheetOpen,
            onClose = tbl1.onAdCampaignSheetClose,
            onCreate = tbl1.onAdCampaignSheetCreate,
            waitForCreateResult = true,
            useLocalRunDates = true,
            isCreatePending = tbl1.isAdUpsellCreatePending,
            hasCreateError = tbl1.hasAdCampaignCreateError,
            createErrorKind = tbl1.adCampaignCreateErrorKind,
            campaignDurationDays = tbl1.adCampaignDurationDays,
            estimatedPriceRobux = tbl1.adCampaignEstimatedPriceRobux,
            campaignOffers = tbl1.adCampaignOffers,
            runStartTimeMs = tbl1.adCampaignRunStartTimeMs,
            runEndTimeMs = tbl1.adCampaignRunEndTimeMs
        })
    else
        element4 = nil
    end

    tbl6.AdCampaignSheet = element4
    local element5

    if FFlagBuildAgentAdCampaignCard then
        element5 = React.createElement(CreateAdCampaignSheetContainer, {
            universeId = if FFlagBuildAdsManagerUniverseUrl then tbl1.target.universeId else nil,
            isOpen = tbl1.isAgentAdCampaignSheetOpen,
            onClose = tbl1.onAgentAdCampaignSheetClose,
            onCreate = tbl1.onAgentAdCampaignSheetCreate,
            waitForCreateResult = true,
            useLocalRunDates = true,
            isCreatePending = tbl1.isAgentAdCampaignCreatePending,
            hasCreateError = tbl1.hasAgentAdCampaignCreateError,
            createErrorKind = tbl1.agentAdCampaignCreateErrorKind,
            campaignOffers = tbl1.agentAdCampaignOffers,
            attemptedOption = tbl1.agentAdCampaignAttemptedOption,
            runStartTimeMs = tbl1.agentAdCampaignRunStartTimeMs
        })
    else
        element5 = nil
    end

    tbl6.AgentAdCampaignSheet = element5
    local element6

    if FFlagBuildAdUpsell and tbl1.isAdCampaignCreatedToastVisible and tbl1.isAdUpsellVisible then
        element6 = React.createElement(AdCampaignCreatedToast, {
            actionText = if tbl1.onOpenGetUsersPage == nil then nil else var4.adCampaignCreatedView,
            onActionActivated = tbl1.onOpenGetUsersPage,
            onClose = tbl1.onAdCampaignCreatedToastDismiss,
            testId = "AdCampaignCreatedToast",
            title = var4.adCampaignCreated
        })
    else
        element6 = nil
    end

    tbl6.AdCampaignCreatedToast = element6
    return createElement2(var13, tbl5, tbl6)
end

return BuildChatPageView
