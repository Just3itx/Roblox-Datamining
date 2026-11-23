-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationRoactContext = require(BuildExperienceParent.Localization).LocalizationRoactContext

local ChatScrollAnchorContext = require(BuildExperience.Chat.ChatScrollAnchorContext)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local chatConstants = require(BuildExperience.Chat.chatConstants)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FFlagBuildExperienceManageMonetizationTool = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceManageMonetizationTool

local FFlagBuildExperienceChatAccordionScrollAnchor = require(BuildExperience.Flags.FFlagBuildExperienceChatAccordionScrollAnchor)
local FFlagBuildExperiencePromptStallMessage = require(BuildExperience.Flags.FFlagBuildExperiencePromptStallMessage)
local FFlagBuildExperienceToolDisplaySummary = require(BuildExperience.Flags.FFlagBuildExperienceToolDisplaySummary)

local Icon = Foundation.Icon
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local tbl1 = {}

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

local function createThinkingGradient(arg1, enabled: boolean)
    return React.createElement("UIGradient", {
        Enabled = enabled,
        Transparency = NumberSequence.new(
            { NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 0.55) }
        ),
        Offset = arg1:map(function(num1: number): Vector2
            return Vector2.new(
                num1 * chatConstants.THINKING_GRADIENT_ANIMATION_SPEED % chatConstants.THINKING_GRADIENT_OFFSET - chatConstants.THINKING_GRADIENT_OFFSET / 2,
                0
            )
        end)
    })
end

local function createActivityText(text: string, layoutOrder: number)
    return React.createElement(FoundationText, {
        LayoutOrder = layoutOrder,
        Text = text,
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-muted"
    })
end

local function createActivitySummaryActionText(text, layoutOrder: number, arg1, enabled: boolean)
    return React.createElement(FoundationText, {
        LayoutOrder = layoutOrder,
        Text = text,
        Size = UDim2.new(1, 0, 0, 0),
        tag = "size-full-0 auto-y text-body-medium text-no-wrap text-align-x-left text-truncate-end content-muted"
    }, {
        ThinkingGradient = createThinkingGradient(arg1, enabled)
    })
end

local function getActivitySummaryActionText(str1: string, bool1: boolean, str2: string, str3: string, arg1, tbl2, arg2, tbl3, str4: string?) -- Luacid: unused: defined but never referenced
    if not bool1 then
        return str1
    end

    return arg1:map(function(startedAt: number)
        if not tbl2.isThinking then
            return str2
        end
        if tbl2.startedAt == nil then
            tbl2.startedAt = startedAt
        end
        local num1 = math.max(0, startedAt - tbl2.startedAt)
        if FFlagBuildExperiencePromptStallMessage and tbl3 ~= nil and str4 ~= nil then
            local lastProgressAt = tbl3.lastProgressAt or startedAt
            tbl3.lastProgressAt = lastProgressAt

            if startedAt - lastProgressAt >= chatConstants.PROMPT_STALL_SECONDS then
                return str4
            end
        end

        local assistantStatusSwapIntervalSeconds = chatConstants.ASSISTANT_STATUS_SWAP_INTERVAL_SECONDS
        local str5 = str2
        if chatConstants.ASSISTANT_THINKING_DURATION_SUFFIX_DELAY_SECONDS <= num1 then
            str5 = arg2:Format(LocalizationStrings.CHAT_THINKING_SECONDS, { SECONDS = math.max(0, math.floor(num1)) })
        end

        return if math.floor(num1 / assistantStatusSwapIntervalSeconds) % 2 == 0 then str5 else str3
    end)
end

local function localizeActivityLabel(str1: string, arg1, tbl2, tool: string, arg2)
    local var1 = tbl2[str1]
    if var1 ~= nil then
        return var1
    elseif arg1 == nil or arg1.kind ~= "tool_call" then
        return str1
    elseif FFlagBuildExperienceToolDisplaySummary
        and arg1.status ~= "failed"
        and typeof(arg1.displaySummary) == "string"
        and arg1.displaySummary ~= ""
    then
        return arg1.displaySummary
    else
        local var2 = if typeof(arg1.title) == "string" and arg1.title ~= "" then arg1.title else LocalizationStrings.CHAT_TOOL

        local chatToolActivityLocalizationKey = LocalizationStrings.getChatToolActivityLocalizationKey(arg1.title, arg1.status)
        if chatToolActivityLocalizationKey ~= nil then
            if not FFlagBuildExperienceManageMonetizationTool then
                return arg2:Format(chatToolActivityLocalizationKey)
            end
            local success, result = pcall(arg2.Format, arg2, chatToolActivityLocalizationKey)
            if success then
                return result
            end
        end
        if var2 == LocalizationStrings.CHAT_TOOL then
            var2 = tool
        end

        if arg1.status == "completed" then
            return arg2:Format(LocalizationStrings.CHAT_TOOL_FINISHED, { TITLE = var2 })
        elseif arg1.status == "failed" then
            return arg2:Format(LocalizationStrings.CHAT_TOOL_FAILED, { TITLE = var2 })
        end

        return arg2:Format(LocalizationStrings.CHAT_TOOL_RUNNING, { title = var2 })
    end
end

local function TurnActivitySummary(tbl2)
    local segment = tbl2.segment
    local actionCount = segment.actionCount
    local var1 = useLocalization({
        assigningTasks = LocalizationStrings.CHAT_ASSIGNING_TASKS,
        assistantLoading = LocalizationStrings.CHAT_ASSISTANT_LOADING,
        assistantStillWorking = LocalizationStrings.CHAT_ASSISTANT_STILL_WORKING,
        assistantTakingLonger = if FFlagBuildExperiencePromptStallMessage then LocalizationStrings.CHAT_ASSISTANT_TAKING_LONGER else nil,
        questionComposerAnswer = LocalizationStrings.CHAT_QUESTION_COMPOSER_ANSWER,
        questionMultiple = LocalizationStrings.CHAT_QUESTION_MULTIPLE,
        questionSingle = LocalizationStrings.CHAT_QUESTION_SINGLE,
        taskCount = if actionCount == nil then nil else actionCount > 1 and {
            LocalizationStrings.CHAT_TASKS_COMPLETED,
            NUM_COMPLETED_TASKS = actionCount
        } or nil,
        tool = LocalizationStrings.CHAT_TOOL
    })
    local var2 = React.useContext(LocalizationRoactContext)
    local label = useReactiveValue(segment.label or "")

    local var4 = useReactiveValue(segment.activityItems or tbl1)

    local assistantLoading = var1.assistantLoading
    local assistantStillWorking = var1.assistantStillWorking
    local tbl3 = {
        [LocalizationStrings.CHAT_ASSIGNING_TASKS] = var1.assigningTasks,
        [LocalizationStrings.CHAT_ASSISTANT_LOADING] = assistantLoading,
        [LocalizationStrings.CHAT_QUESTION_COMPOSER_ANSWER] = var1.questionComposerAnswer,
        [LocalizationStrings.CHAT_QUESTION_MULTIPLE] = var1.questionMultiple,
        [LocalizationStrings.CHAT_QUESTION_SINGLE] = var1.questionSingle
    }
    local var5 = if actionCount ~= nil and actionCount > 1 and segment.summaryToolActivity == nil then var1.taskCount else localizeActivityLabel(label, segment.summaryToolActivity, tbl3, var1.tool, var2)

    local function func1(arg1, layoutOrder: number)
        if arg1.kind ~= "tool_call" then
            return nil
        end
        local var6 = localizeActivityLabel(LocalizationStrings.CHAT_TOOL, arg1, tbl3, var1.tool, var2)

        return createActivityText(var6, layoutOrder)
    end
    local var6 = useReactiveValue(segment.isLoading or false)
    local var7, var8 = React.useState(false)
    local var9, var10 = React.useBinding(0)
    local var11 = React.useRef(nil)
    local var12 = nil
    local var13 = nil
    if FFlagBuildExperienceChatAccordionScrollAnchor then
        var12 = React.useRef(nil)
        var13 = React.useContext(ChatScrollAnchorContext)
    end
    local var14 = React.useRef({ isThinking = false, startedAt = nil })

    local var15 = Foundation.Hooks.useTokens()

    local isThinking = label == chatConstants.ASSISTANT_LOADING_TEXT
    local current = var14.current
    if current.isThinking ~= isThinking then
        current.isThinking = isThinking
        current.startedAt = nil
    end

    local current2

    if FFlagBuildExperiencePromptStallMessage then
        current2 = React.useRef({ segment = nil, label = "", activityCount = 0, lastProgressAt = nil }).current
        local activityCount = #var4

        if current2.segment ~= segment or current2.label ~= label or current2.activityCount ~= activityCount then
            current2.segment = segment
            current2.label = label
            current2.activityCount = activityCount
            current2.lastProgressAt = nil
        end
    else
        current2 = nil
    end

    local var16 = React.useCallback(function()
        if FFlagBuildExperienceChatAccordionScrollAnchor and var13 ~= nil and var12 ~= nil then
            var13(var12.current)
        end
        var8(function(bool2: boolean): boolean
            return not bool2
        end)
    end, { var13 })

    local var17 = React.useCallback(function(current3)
        if current3 == nil then
            return
        end

        task.defer(function()
            if var11.current ~= current3 then
                return
            end

            local y = math.max(0, current3.AbsoluteCanvasSize.Y - current3.AbsoluteWindowSize.Y)
            current3.CanvasPosition = Vector2.new(0, y)
        end)
    end, {})

    local scrollingFrameRef = React.useCallback(function(current3)
        var11.current = current3
        if current3 then
            var17(current3)
        end
    end, { var17 })

    local onAbsoluteCanvasSizeChanged = React.useCallback(function(arg1)
        var10(arg1.AbsoluteCanvasSize.Y)
        var17(arg1)
    end, { var10, var17 })

    local onAbsoluteWindowSizeChanged = React.useCallback(function(arg1)
        var17(arg1)
    end, { var17 })

    React.useEffect(function()
        var17(var11.current)
        return function() end
    end, { var17, var4 })

    local tbl4 = {}
    local num1 = 0
    for value, value2 in var4 do
        local var21 = func1(value2, value)
        if var21 ~= nil then
            tbl4[`Tool{value}`] = var21
            num1 += 1
        end
    end

    local bool2 = next(tbl4) ~= nil
    local bool3 = num1 > 1
    local element

    if var6 then
        local createElement = React.createElement
        local var21 = View
        local tbl5 = { LayoutOrder = 2, tag = "col fill gap-xxsmall auto-y" }

        local tbl6 = { CurrentAction = 0 }
        local func2 = createActivitySummaryActionText

        local clockBinding = tbl2.clockBinding
        local assistantTakingLonger = if FFlagBuildExperiencePromptStallMessage and segment.isWaitingForLocalTool ~= true then var1.assistantTakingLonger else nil

        if isThinking then
            var5 = clockBinding:map(function(startedAt: number)
                if not current.isThinking then
                    return assistantLoading
                end
                if current.startedAt == nil then
                    current.startedAt = startedAt
                end
                local num2 = math.max(0, startedAt - current.startedAt)
                if FFlagBuildExperiencePromptStallMessage and current2 ~= nil and assistantTakingLonger ~= nil then
                    local lastProgressAt = current2.lastProgressAt or startedAt
                    current2.lastProgressAt = lastProgressAt

                    if startedAt - lastProgressAt >= chatConstants.PROMPT_STALL_SECONDS then
                        return assistantTakingLonger
                    end
                end

                local assistantStatusSwapIntervalSeconds = chatConstants.ASSISTANT_STATUS_SWAP_INTERVAL_SECONDS
                local var22 = assistantLoading
                if chatConstants.ASSISTANT_THINKING_DURATION_SUFFIX_DELAY_SECONDS <= num2 then
                    var22 = var2:Format(LocalizationStrings.CHAT_THINKING_SECONDS, { SECONDS = math.max(0, math.floor(num2)) })
                end

                return if math.floor(num2 / assistantStatusSwapIntervalSeconds) % 2 == 0 then var22 else assistantStillWorking
            end)
        end

        tbl6.CurrentAction = func2(var5, 1, tbl2.clockBinding, segment.isWaitingForLocalTool ~= true)
        element = createElement(var21, tbl5, tbl6)
    else
        element = React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = var5,
                tag = "fill text-body-medium text-wrap text-align-x-left content-muted"
            }
        )
    end
    local createElement = React.createElement
    local var21 = View
    local tbl5 = {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "col gap-xsmall size-full-0 auto-y",
        testId = "TurnActivitySummary"
    }

    local tbl6 = { ActivitySummary = 0, ActivityHistory = 0 }
    local createElement2 = React.createElement
    local var22 = View
    local tbl7 = {
        LayoutOrder = 1,
        ref = var12,
        onActivated = 0,
        stateLayer = 0,
        tag = "row align-y-center gap-xsmall size-full-0 auto-y padding-y-xxsmall",
        testId = "TurnActivitySummary.Summary"
    }

    if not bool3 then
        var16 = nil
    end

    tbl7.onActivated = var16
    tbl7.stateLayer = {
        affordance = StateLayerAffordance.None
    }

    local tbl8 = {
        Chevron = if bool3 then React.createElement(Icon, {
            LayoutOrder = 1,
            name = if var7 then IconName.ChevronLargeDown else IconName.ChevronLargeRight,
            size = IconSize.XSmall,
            style = var15.Color.Content.Muted,
            testId = "TurnActivitySummary.Chevron"
        }) else nil,
        Label = element
    }
    tbl6.ActivitySummary = createElement2(var22, tbl7, tbl8)
    local element3

    if var7 and bool2 and bool3 then
        element3 = React.createElement(
            ScrollView,
            {
                LayoutOrder = 2,
                Size = var9:map(function(num2: number): UDim2
                    return UDim2.new(1, 0, 0, math.clamp(num2, 24, 220))
                end),
                scrollingFrameRef = scrollingFrameRef,
                onAbsoluteCanvasSizeChanged = onAbsoluteCanvasSizeChanged,
                onAbsoluteWindowSizeChanged = onAbsoluteWindowSizeChanged,
                tag = "size-full-0 clip",
                testId = "TurnActivitySummary.ActivityHistory",
                scroll = {
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.new(1, 0, 0, 0),
                    ScrollingDirection = Enum.ScrollingDirection.Y
                }
            },
            {
                ActivityColumn = React.createElement(View, { tag = "col gap-xsmall size-full-0 auto-y padding-left-large" }, tbl4)
            }
        )
    else
        element3 = nil
    end

    tbl6.ActivityHistory = element3
    return createElement(var21, tbl5, tbl6)
end

return TurnActivitySummary
