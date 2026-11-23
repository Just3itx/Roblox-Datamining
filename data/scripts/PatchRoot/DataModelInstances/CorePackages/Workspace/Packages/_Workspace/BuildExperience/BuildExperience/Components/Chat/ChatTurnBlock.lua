-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local Markdown = require(BuildExperienceParent.Markdown)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = Localization.Hooks.useLocalization
local LocalizationRoactContext = Localization.LocalizationRoactContext
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local ChatPermissionsContext = require(BuildExperience.Chat.ChatPermissionsContext)
local ChatScrollAnchorContext = require(BuildExperience.Chat.ChatScrollAnchorContext)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local ChatCardEmphasisPositionProvider = require(script.Parent.ChatCardEmphasis.ChatCardEmphasisPositionProvider)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local AnswersCardContainer = if FFlagBuildExperienceAnswerForm then require(script.Parent.AnswersCardContainer) else nil
local turnProjection = require(BuildExperience.Chat.turnProjection)

local FFlagBuildExperienceChatAccordionScrollAnchor = require(BuildExperience.Flags.FFlagBuildExperienceChatAccordionScrollAnchor)
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)

local FFlagBuildAgentAdCampaignRefreshEligibility = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignRefreshEligibility)
local FFlagBuildEventsUpdate1 = require(BuildExperience.Flags.FFlagBuildEventsUpdate1)

local FFlagBuildExperiencePlaytestCardPublishCta = require(BuildExperience.Flags.FFlagBuildExperiencePlaytestCardPublishCta)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local reportTurnActivityGap = require(BuildExperience.Telemetry.reportTurnActivityGap)
local getMarkdownRendererProps = require(BuildExperience.utils.getMarkdownRendererProps)
local AgentPlanCard = require(BuildExperience.Components.AgentCard.AgentPlanCard)
local AgentDevProductCard = if FFlagBuildExperienceManageDevProduct then require(BuildExperience.Components.AgentCard.AgentDevProductCard) else nil
local AnswerStack = require(BuildExperience.Components.AnswerStack.AnswerStack)
local OptionSelector = require(BuildExperience.Components.AnswerStack.OptionSelector)
local AgentTurnFeedback = require(script.Parent.AgentTurnFeedback)
local ChatUserMessage = require(script.Parent.ChatUserMessage)
local PlaytestCompletedCard = require(script.Parent.PlaytestCompletedCard)
local useIsPlaceVersionLive = if FFlagBuildExperiencePlaytestCardPublishCta then require(script.Parent.useIsPlaceVersionLive) else nil
local AdUpsellCard = if FFlagBuildAgentAdCampaignCard then require(BuildExperience.Components.Ads.AdUpsellCard) else nil
local AdCampaignIsActiveCard = if FFlagBuildAgentAdCampaignCard then require(BuildExperience.Components.Ads.AdCampaignIsActiveCard) else nil
local useAgentAdCampaignTurnCards = if FFlagBuildAgentAdCampaignCard then require(script.Parent.useAgentAdCampaignTurnCards) else nil
local TurnActivitySummary = require(script.Parent.TurnActivitySummary)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local MarkdownViewer = Markdown.Components.MarkdownViewer

local tbl1 = {}
local tbl2 = {
    onAnswerSelectedByToolCallId = {},
    onAnswerConfirmedByToolCallId = {},
    onPlanAcceptedByToolCallId = {},
    onDevProductApprovedByToolCallId = {},
    onDevProductRejectedByToolCallId = {}
}

local function constantSource(): number
    return 0
end

local function useReactiveValue(arg1)
    local var1 = React.useCallback(function(arg2)
        if typeof(arg1) == "function" then
            return (arg1(arg2))
        end
        if typeof(arg2) == "function" then
            arg2(constantSource)
        end
        return arg1
    end, { arg1 })

    return (SignalsReact.useSignalState(var1))
end

local function useIsChatReadOnly(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    if not FFlagBuildCheckGamePermissions then
        return false
    end

    local var1 = React.useContext(ChatPermissionsContext)
    return not (var1 == nil) and not var1.canEditOnBuild
end

local function hasSelectedOptions(selectedOptionId): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return typeof(selectedOptionId) == "string" or typeof(selectedOptionId) == "table" and #selectedOptionId > 0
end

local function AnswerStackSection(tbl3)
    local var1 = useLocalization({
        customAnswer = LocalizationStrings.ANSWER_STACK_CUSTOM_ANSWER,
        next = LocalizationStrings.ANSWER_STACK_NEXT,
        submit = LocalizationStrings.ANSWER_STACK_SUBMIT
    })
    local bool1 = useIsChatReadOnly()
    local prompt = tbl3.prompt
    local question = prompt.question
    local customResponseText = prompt.customResponseText
    local bool2 = tbl3.isActive == true and not bool1
    local onAnswerSelected = if bool1 then nil else tbl3.onAnswerSelected
    local bool3 = question.responseType == "multi_select"
    local confirmLabel = if prompt.isLastQuestion == false then var1.next else var1.submit
    local createElement = React.createElement
    local var3 = View
    local tbl4 = {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "col gap-medium size-full-0 auto-y",
        testId = `ChatTurnBlock.AnswerStack.{question.id}`
    }
    local tbl5 = {
        Question = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = question.question,
            tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
        }),
        Answers = 0
    }
    local element

    if customResponseText ~= nil then
        element = React.createElement(OptionSelector, {
            LayoutOrder = 2,
            title = var1.customAnswer,
            description = customResponseText,
            isSelected = true,
            testId = `AnswerStack.{question.id}.CustomAnswer`,
            onActivated = function() end
        })
    elseif #question.options > 0 then
        local createElement2 = React.createElement
        local var4 = AnswerStack
        local tbl6 = {
            LayoutOrder = 2,
            options = question.options,
            selectedOptionId = prompt.selectedOptionId,
            selectionMode = if bool3 then "multi" else "single",
            confirmLabel = confirmLabel,
            isConfirmDisabled = not hasSelectedOptions(prompt.selectedOptionId),
            onConfirm = if bool3 and bool2 then tbl3.onAnswerConfirmed else nil,
            testId = `AnswerStack.{question.id}`,
            onOptionSelected = 0
        }

        function tbl6.onOptionSelected(arg1)
            if onAnswerSelected == nil then
                return
            end

            if bool3 then
                if bool2 then
                    onAnswerSelected(question, arg1)
                end
            elseif prompt.selectedOptionId == nil then
                onAnswerSelected(question, arg1)
            end
        end

        element = createElement2(var4, tbl6)
    else
        element = nil
    end

    tbl5.Answers = element
    return createElement(var3, tbl4, tbl5)
end

local function PlanProposalSection(tbl3)
    local bool1 = useIsChatReadOnly()
    local planProposal = tbl3.planProposal
    local bool2 = not (planProposal.isAccepted == true) and planProposal.feedbackText == nil
    local plan = React.createElement(AgentPlanCard, {
        layoutOrder = 1,
        title = planProposal.title,
        textContent = planProposal.textContent,
        summary = planProposal.summary,
        onBuild = tbl3.onPlanAccepted or function() end,
        isBuildDisabled = not bool2 or bool1,
        testId = "ChatTurnBlock.PlanProposal"
    })

    if planProposal.feedbackText == nil then
        return React.createElement(
            View,
            {
                LayoutOrder = tbl3.LayoutOrder,
                tag = "col gap-medium size-full-0 auto-y"
            },
            { Plan = plan }
        )
    end

    return React.createElement(View, {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "col gap-medium size-full-0 auto-y"
    }, {
        Plan = plan,
        Feedback = React.createElement(
            ChatUserMessage,
            {
                LayoutOrder = 2,
                message = {
                    kind = "user_message",
                    text = planProposal.feedbackText
                }
            }
        )
    })
end

local function AgentMessageSegment(tbl3)
    local var1 = useReactiveValue(tbl3.segment.text)

    local var2 = useLocalization({
        assistantResponseFailed = LocalizationStrings.CHAT_ASSISTANT_RESPONSE_FAILED,
        assistantStopped = LocalizationStrings.CHAT_ASSISTANT_STOPPED
    })
    local var3 = React.useContext(LocalizationRoactContext)
    if var1 == LocalizationStrings.CHAT_ASSISTANT_RESPONSE_FAILED then
        var1 = var2.assistantResponseFailed
    elseif var1 == LocalizationStrings.CHAT_ASSISTANT_STOPPED then
        var1 = var2.assistantStopped
    end
    if tbl3.segment.errorCode ~= nil then
        var1 = var3:Format(LocalizationStrings.CHAT_ERROR_CODE_TEXT, { ERROR_CODE = tbl3.segment.errorCode, ERROR_TEXT = var1 })
    end

    local var4 = Foundation.Hooks.useTokens()
    local markdownRendererProps = React.useMemo(function()
        return getMarkdownRendererProps(var4, tbl3.markdownTextStyle)
    end, { var4, tbl3.markdownTextStyle })
    if var1 == "" then
        return nil
    elseif tbl3.segment.isError then
        return React.createElement(View, {
            LayoutOrder = tbl3.LayoutOrder,
            tag = "row align-y-center gap-xsmall size-full-0 auto-y",
            testId = "ChatTurnBlock.ErrorMessage"
        }, {
            Icon = React.createElement(Icon, {
                LayoutOrder = 1,
                name = IconName.CircleX,
                variant = IconVariant.Filled,
                size = IconSize.Small,
                style = var4.Color.System.Alert,
                testId = "ChatTurnBlock.ErrorMessage.Icon"
            }),
            Text = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = var1,
                    tag = "fill text-body-medium text-wrap text-align-x-left content-emphasis"
                }
            )
        })
    end

    return React.createElement(MarkdownViewer, {
        Markdown = var1,
        WrapperProps = {
            LayoutOrder = tbl3.LayoutOrder,
            tag = "size-full-0 auto-y text-body-medium content-emphasis"
        },
        MarkdownRendererProps = markdownRendererProps
    })
end

local function PlaytestCardSection(tbl3)
    local isPublishDisabled = useIsPlaceVersionLive(if tbl3.onPublish == nil then nil else tbl3.placeId, tbl3.publishedVersionNumber)
    return React.createElement(PlaytestCompletedCard, {
        LayoutOrder = tbl3.LayoutOrder,
        onPlaytest = tbl3.onPlaytest,
        onPublish = tbl3.onPublish,
        isPublishDisabled = isPublishDisabled or tbl3.isPublishDisabled == true,
        isPlaytestDisabled = tbl3.isPlaytestDisabled,
        isLoading = tbl3.isLoading
    })
end

local function DevProductProposalSection(tbl3)
    local isReadOnly = useIsChatReadOnly()
    local devProductProposal = tbl3.devProductProposal
    local bool2 = not (devProductProposal.isApproved == true) and devProductProposal.isRejected ~= true
    return React.createElement(View, {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "col gap-medium size-full-0 auto-y"
    }, {
        DevProduct = React.createElement(AgentDevProductCard, {
            layoutOrder = 1,
            action = devProductProposal.action,
            name = devProductProposal.name,
            description = devProductProposal.description,
            priceInRobux = devProductProposal.priceInRobux,
            productId = devProductProposal.productId,
            imageAssetId = devProductProposal.imageAssetId,
            productType = devProductProposal.productType,
            itemKind = devProductProposal.itemKind,
            itemId = devProductProposal.itemId,
            cancelRenewals = devProductProposal.cancelRenewals,
            onApprove = tbl3.onApprove or function() end,
            onReject = tbl3.onReject or function() end,
            isActionDisabled = not bool2,
            isReadOnly = isReadOnly,
            isPending = devProductProposal.isPending,
            hasError = devProductProposal.hasError,
            errorCause = devProductProposal.errorCause,
            canRetry = devProductProposal.canRetry,
            testId = "ChatTurnBlock.DevProductProposal"
        })
    })
end

local function renderClientToolSegment(segment, layoutOrder: number, arg1)
    if FFlagBuildExperienceAnswerForm and segment.answeredPrompts ~= nil then
        return React.createElement(AnswersCardContainer, { LayoutOrder = layoutOrder, prompts = segment.answeredPrompts })
    end

    if FFlagBuildExperienceAnswerForm and segment.answerStackPrompt ~= nil then
        return nil
    end
    if segment.answerStackPrompt ~= nil then
        return React.createElement(AnswerStackSection, {
            LayoutOrder = layoutOrder,
            prompt = segment.answerStackPrompt,
            isActive = segment.isActive,
            onAnswerSelected = if segment.isActive then arg1.onAnswerSelectedByToolCallId[segment.toolCallId] else nil,
            onAnswerConfirmed = if segment.isActive then arg1.onAnswerConfirmedByToolCallId[segment.toolCallId] else nil
        })
    end

    if segment.planProposal ~= nil then
        return React.createElement(PlanProposalSection, {
            LayoutOrder = layoutOrder,
            planProposal = segment.planProposal,
            onPlanAccepted = if segment.isActive then arg1.onPlanAcceptedByToolCallId[segment.toolCallId] else nil
        })
    end

    if not FFlagBuildExperienceManageDevProduct or segment.devProductProposal == nil then
        return nil
    end

    return React.createElement(DevProductProposalSection, {
        LayoutOrder = layoutOrder,
        devProductProposal = segment.devProductProposal,
        onApprove = if segment.isActive then arg1.onDevProductApprovedByToolCallId[segment.toolCallId] else nil,
        onReject = if segment.isActive then arg1.onDevProductRejectedByToolCallId[segment.toolCallId] else nil
    })
end

local function renderWorkSegment(segment, layoutOrder: number, markdownTextStyle, clockBinding, arg1)
    if segment.kind == "agent_message" then
        return React.createElement(
            AgentMessageSegment,
            { LayoutOrder = layoutOrder, segment = segment, markdownTextStyle = markdownTextStyle }
        )
    elseif segment.kind == "activity_summary" then
        return React.createElement(TurnActivitySummary, { LayoutOrder = layoutOrder, segment = segment, clockBinding = clockBinding })
    elseif segment.kind == "client_tool" then
        return renderClientToolSegment(segment, layoutOrder, arg1)
    end

    return nil
end

local function TurnWorkSegment(tbl3)
    local var1 = useReactiveValue(tbl3.segment.label or "")
    local workedDurationSeconds = tbl3.segment.workedDurationSeconds
    local var2 = if workedDurationSeconds == nil then nil else math.max(0, math.floor(workedDurationSeconds + 0.5))
    local actionCount = tbl3.segment.actionCount or 0
    local var3 = useLocalization
    local tbl4 = { summary = 0, turnActivity = 0 }
    local chatOneTaskCompleted

    if var2 ~= nil and var2 < 60 then
        chatOneTaskCompleted = {
            LocalizationStrings.CHAT_WORKED_SECONDS,
            SECONDS = var2
        }
    elseif var2 ~= nil then
        chatOneTaskCompleted = {
            [1] = nil,
            [1] = nil,
            LocalizationStrings.CHAT_WORKED_MINUTES_SECONDS
        }
        local var4 = var2 / 60
        chatOneTaskCompleted.MINUTES = math.floor(var4)
        chatOneTaskCompleted.REM_SECONDS = var2 % 60
    elseif actionCount == 1 then
        chatOneTaskCompleted = LocalizationStrings.CHAT_ONE_TASK_COMPLETED
    else
        chatOneTaskCompleted = actionCount > 1 and {
            LocalizationStrings.CHAT_TASKS_COMPLETED,
            NUM_COMPLETED_TASKS = actionCount
        } or nil
    end

    tbl4.summary = chatOneTaskCompleted

    tbl4.turnActivity = LocalizationStrings.CHAT_TURN_ACTIVITY
    local var4 = var3(tbl4)

    if var2 ~= nil or actionCount > 0 then
        var1 = var4.summary
    elseif var1 == LocalizationStrings.CHAT_TURN_ACTIVITY then
        var1 = var4.turnActivity
    end

    local var5 = useReactiveValue(tbl3.segment.segments)
    local var6, var7 = React.useState(false)
    local var8 = nil
    local var9 = nil
    if FFlagBuildExperienceChatAccordionScrollAnchor then
        var8 = React.useRef(nil)
        var9 = React.useContext(ChatScrollAnchorContext)
    end
    local var10 = Foundation.Hooks.useTokens()
    local isDone = tbl3.isDone
    local var11 = not tbl3.isDone or var6

    local onActivated = React.useCallback(function()
        if FFlagBuildExperienceChatAccordionScrollAnchor and var9 ~= nil and var8 ~= nil then
            var9(var8.current)
        end
        var7(function(bool1: boolean): boolean
            return not bool1
        end)
    end, { var9 })

    local tbl5 = {}
    if var11 then
        local num1 = 1
        for _, value in var5 do
            local var13 = renderWorkSegment(value, num1, tbl3.markdownTextStyle, tbl3.clockBinding, tbl3.localToolActions)

            if var13 == nil then
                continue
            end

            if FFlagBuildExperienceChatCardEmphasis then
                var13 = React.createElement(ChatCardEmphasisPositionProvider, { childOrder = num1 }, var13)
            end

            tbl5[value.key] = var13
            num1 += 1
        end
    end

    local createElement = React.createElement
    local var13 = View
    local tbl6 = {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "col gap-medium size-full-0 auto-y",
        testId = "ChatTurnBlock.TurnWork"
    }

    local tbl7 = { Summary = 0, Work = 0 }
    local var14

    if isDone then
        local createElement2 = React.createElement
        local var15 = View
        local tbl8 = {
            LayoutOrder = 1,
            ref = var8,
            onActivated = onActivated,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            tag = "row align-y-center gap-xsmall size-full-0 auto-y padding-y-xxsmall",
            testId = "ChatTurnBlock.TurnWork.Summary"
        }

        local tbl9 = {
            Chevron = React.createElement(Icon, {
                LayoutOrder = 1,
                name = if var6 then IconName.ChevronLargeDown else IconName.ChevronLargeRight,
                size = IconSize.XSmall,
                style = var10.Color.Content.Muted
            }),
            Label = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = var1,
                    tag = "fill text-body-medium text-wrap text-align-x-left content-muted"
                }
            )
        }
        var14 = createElement2(var15, tbl8, tbl9)
    else
        var14 = nil
    end

    tbl7.Summary = var14

    tbl7.Work = if var11 then React.createElement(View, {
        LayoutOrder = if isDone then 2 else 1,
        tag = {
            ["col gap-xlarge size-full-0 auto-y padding-left-large"] = isDone,
            ["col gap-xlarge size-full-0 auto-y"] = not isDone
        },
        testId = "ChatTurnBlock.TurnWork.Content"
    }, tbl5) else nil
    return createElement(var13, tbl6, tbl7)
end

return React.memo(function(tbl3) -- name: ChatTurnBlock
    local turn = tbl3.turn
    local turnState = turn.turnState
    local turnKey = turn.turnKey
    local startSequenceId = turn.startSequenceId
    local endSequenceId = turn.endSequenceId
    local optimisticLocalTools = turn.optimisticLocalTools
    local setupErrorText = turn.setupErrorText
    local universeId = turn.universeId
    local sessionId = turn.sessionId
    local isDone = turn.isDone
    local isLatestPublishTurn = turn.isLatestPublishTurn

    local segments = React.useMemo(function()
        if turnState ~= nil then
            return turnProjection.projectActiveTurnSegments(turnState, {
                turnKey = turnKey,
                universeId = universeId,
                sessionId = sessionId,
                startSequenceId = startSequenceId,
                endSequenceId = endSequenceId,
                optimisticLocalTools = optimisticLocalTools,
                showPlaytestCta = isLatestPublishTurn
            })
        elseif setupErrorText ~= nil then
            return turnProjection.projectSetupErrorSegments(setupErrorText, { turnKey = turnKey })
        end
        return turnProjection.projectLoadingTurnSegments({ turnKey = turnKey })
    end, {
        turnState,
        turnKey,
        startSequenceId,
        endSequenceId,
        optimisticLocalTools,
        setupErrorText,
        universeId,
        sessionId,
        isLatestPublishTurn
    })

    local var2 = React.useRef(nil)

    React.useEffect(function()
        if isDone then
            var2.current = nil
            return
        end

        local current = os.clock()
        local bool1 = var2.current == nil
        local var3 = if var2.current == nil then 0 else (current - var2.current) * 1000
        reportTurnActivityGap.log(var3, bool1, universeId)
        var2.current = current
    end, { isDone, segments, universeId })

    local turnFeedbackIds = useReactiveValue(turn.turnFeedbackIds or tbl1)

    local var4 = not FFlagBuildAgentAdCampaignCard and {}
        or useAgentAdCampaignTurnCards({
            segments = segments,
            sessionId = sessionId,
            universeId = universeId,
            isPageVisible = tbl3.isPageVisible,
            scrollingFrameRef = tbl3.scrollingFrameRef,
            getCardState = tbl3.getAgentAdCampaignCardState,
            isCreateDisabled = tbl3.isAgentAdCampaignCreateDisabled,
            onOfferSelected = tbl3.onAgentAdCampaignOfferSelected
        })

    local localToolActions = tbl3.localToolActions or tbl2
    local emphasis = Foundation.Hooks.useTokens().Color.Content.Emphasis
    local messageText = if turnState == nil then nil else turnProjection.getFinalAssistantMessageText(turnState)
    local var6 = if FFlagBuildCheckGamePermissions then React.useContext(ChatPermissionsContext) else nil
    local isPlaytestDisabled = not (var6 == nil) and not var6.canEdit
    local isPublishDisabled = not (var6 == nil) and not var6.canPublish
    local onPlaytest = tbl3.onPlaytest
    local var1 = React.useCallback(function()
        sendBuildExperienceEvent("PLAYTEST_CLICK", {
            universeId = turnFeedbackIds.universeId,
            placeId = turnFeedbackIds.placeId,
            conversationId = turnFeedbackIds.sessionId,
            messageId = turnFeedbackIds.sequenceId
        }, FFlagBuildEventsUpdate1 and { context = "chat_widget" } or nil)
        if onPlaytest ~= nil then
            onPlaytest()
        end
    end, { onPlaytest, turnFeedbackIds })

    local var8 = React.useRef(false)
    React.useEffect(function()
        if var8.current or onPlaytest == nil then
            return
        end
        local bool3 = false
        for _, value in segments do
            if value.kind == "playtest_cta" then
                bool3 = true
                break
            end
        end

        if not bool3 then
            return
        end
        var8.current = true
        sendBuildExperienceEvent("PLAYTEST_IMPRESSION", {
            universeId = turnFeedbackIds.universeId,
            placeId = turnFeedbackIds.placeId,
            conversationId = turnFeedbackIds.sessionId,
            messageId = turnFeedbackIds.sequenceId
        })
    end, { segments, onPlaytest, turnFeedbackIds })

    local tbl4 = {}
    local num1 = 1
    for _, segment in segments do
        local element = nil
        if segment.kind == "agent_message" or segment.kind == "activity_summary" or segment.kind == "client_tool" then
            element = renderWorkSegment(segment, num1, emphasis, tbl3.clockBinding, localToolActions)
        elseif segment.kind == "turn_work" then
            element = React.createElement(TurnWorkSegment, {
                LayoutOrder = num1,
                segment = segment,
                isDone = isDone,
                markdownTextStyle = emphasis,
                clockBinding = tbl3.clockBinding,
                localToolActions = localToolActions
            })
        elseif segment.kind == "playtest_cta" and onPlaytest ~= nil then
            if FFlagBuildExperiencePlaytestCardPublishCta then
                element = React.createElement(PlaytestCardSection, {
                    LayoutOrder = num1,
                    onPlaytest = var1,
                    onPublish = tbl3.onPublish,
                    isLoading = tbl3.isPlaytestLoading,
                    isPlaytestDisabled = isPlaytestDisabled,
                    isPublishDisabled = isPublishDisabled,
                    placeId = turnFeedbackIds.placeId,
                    publishedVersionNumber = turnFeedbackIds.publishedVersionNumber
                })
            else
                element = React.createElement(
                    PlaytestCompletedCard,
                    {
                        LayoutOrder = num1,
                        onPlaytest = var1,
                        isLoading = tbl3.isPlaytestLoading,
                        isPlaytestDisabled = isPlaytestDisabled
                    }
                )
            end
        elseif segment.kind == "agent_ad_campaign_card" and FFlagBuildAgentAdCampaignCard then
            local var9 = var4[segment.toolCallId]
            local state = var9.state
            local var10 = if FFlagBuildAgentAdCampaignRefreshEligibility and state ~= nil and state.campaignId == nil then nil else state

            if var10 ~= nil then
                local createElement = React.createElement
                local var11 = AdCampaignIsActiveCard
                local tbl5 = {
                    LayoutOrder = num1,
                    variant = var10.variant,
                    campaignStartDate = var10.campaignStartDate,
                    campaignEndDate = var10.campaignEndDate,
                    isDisabled = tbl3.onAgentAdCampaignActive == nil,
                    onActivated = 0
                }

                function tbl5.onActivated()
                    if tbl3.onAgentAdCampaignActive ~= nil then
                        tbl3.onAgentAdCampaignActive()
                    end
                end

                element = createElement(var11, tbl5)
            elseif segment.offers ~= nil and not var9.isPending then
                element = React.createElement(AdUpsellCard, {
                    LayoutOrder = num1,
                    freePromotionsRemaining = segment.availableCreditsSnapshot,
                    isCreatePending = if FFlagBuildAgentAdCampaignRefreshEligibility and state ~= nil then state.eligibilityStatus == "loading" else nil,
                    eligibilityError = if FFlagBuildAgentAdCampaignRefreshEligibility and state ~= nil and state.eligibilityStatus ~= "loading" then state.eligibilityStatus else nil,
                    fundingType = var9.fundingType,
                    containerRef = var9.cardRef,
                    isCreateDisabled = var9.isCreateDisabled,
                    onCreate = var9.onCreate
                })
            end
        end

        if element == nil then
            continue
        end

        if FFlagBuildExperienceChatCardEmphasis then
            element = React.createElement(
                ChatCardEmphasisPositionProvider,
                {
                    messageOrder = tbl3.LayoutOrder or 0,
                    segmentOrder = num1
                },
                element
            )
        end
        tbl4[segment.key] = element
        num1 += 1
    end

    local createElement = React.createElement
    local var9 = View
    local tbl5 = {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "row gap-small size-full-0 auto-y"
    }
    local tbl6 = {
        Message = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "col gap-xsmall size-full-0 auto-y",
                testId = "ChatTurnBlock.Message"
            },
            {
                Content = React.createElement(
                    View,
                    {
                        LayoutOrder = 1,
                        tag = "col gap-xlarge size-full-0 auto-y",
                        testId = "ChatTurnBlock.Message.Content"
                    },
                    tbl4
                ),
                Feedback = if isDone then React.createElement(
                    AgentTurnFeedback,
                    {
                        LayoutOrder = 2,
                        messageText = messageText,
                        turnFeedbackIds = turnFeedbackIds,
                        testId = "ChatTurnBlock.UserFeedback"
                    }
                ) else nil
            }
        )
    }
    return createElement(var9, tbl5, tbl6)
end)
