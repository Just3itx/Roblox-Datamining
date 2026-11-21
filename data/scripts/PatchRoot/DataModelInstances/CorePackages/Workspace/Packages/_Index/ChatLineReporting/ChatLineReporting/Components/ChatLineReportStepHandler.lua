-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local Players = game:GetService("Players")
local ChatLineReportingParent = ChatLineReporting.Parent

local FocusNavigationUtils = require(ChatLineReportingParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FocusRoot = FocusNavigationUtils.FocusRoot
local InputHandlers = require(ChatLineReportingParent.InputHandlers)
local React = require(ChatLineReportingParent.React)
local Cryo = require(ChatLineReportingParent.Cryo)
local ReactOtter = require(ChatLineReportingParent.ReactOtter)
local GuiService = game:GetService("GuiService")
local DefaultReportDialog = require(ChatLineReportingParent.GenericAbuseReporting.DefaultReportDialog)
local NotificationModalsManager = require(ChatLineReportingParent.NotificationModalsManager)
local useTokens = require(ChatLineReportingParent.Foundation).Hooks.useTokens
local Images = require(ChatLineReportingParent.UIBlox).App.ImageSet.Images
local useLocalization = require(ChatLineReportingParent.Localization).Hooks.useLocalization

local Constants = require(ChatLineReporting.Common.Constants)
local AnalyticsReducer = require(ChatLineReporting.Common.AnalyticsReducer)
local ChatLineReportAnalytics = require(ChatLineReporting.Common.ChatLineReportAnalytics)
local buildReport = require(ChatLineReporting.Common.buildReport)
local isSystemMessage = require(ChatLineReporting.Common.isSystemMessage)
local ChatLineReportSelectionModalOld = require(ChatLineReporting.Components.ChatLineReportSelectionModalOld)
local ChatLineReportVerbatim = require(ChatLineReporting.Components.ChatLineReportVerbatim)
local ChatLineReportCompleteModal = require(ChatLineReporting.Components.ChatLineReportCompleteModal)
local ReportCategories = require(ChatLineReporting.Common.ReportCategories)
local engineFeature = game:GetEngineFeature("SSUIMetaLua")
local FFlagEnableGlobalChatAbuseReporting = require(ChatLineReportingParent.SharedFlags).FFlagEnableGlobalChatAbuseReporting

local FFlagGenericAbuseReportingGranularExports = require(ChatLineReportingParent.SharedFlags).FFlagGenericAbuseReportingGranularExports
local FFlagEnableChatReportingTextChannelTag = require(ChatLineReportingParent.SharedFlags).FFlagEnableChatReportingTextChannelTag

local tbl1 = { stiffness = 400, damping = 40, mass = 1 }

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function ChatLineReportStepHandler(tbl3)
    local var1, var2 = React.useState(Constants.ReportSteps.SELECT)
    local selectedMessage, setSelectedMessage = React.useState(nil)
    local var5, analyticsDispatch = React.useReducer(AnalyticsReducer, Constants.AnalyticsInitialState)
    local var7, var8 = React.useState(not GuiService.MenuIsOpen)
    local var9, var10 = React.useState(GuiService.MenuIsOpen)
    local var11, var12 = React.useState(false)
    local var13, var14 = React.useState(nil)
    local name, var16 = React.useState("")

    local var17 = useLocalization(Constants.ChatLineLocalizationKeys)
    local var18 = useLocalization({
        ChatToastTitleSuccess = { "Feature.ReportAbuse.Label.UserTextMuted", name = name },
        ChatToastTitleError = { "Feature.ReportAbuse.Label.UserTextMutedError", name = name },
        ChatToastDescriptionErrorDoesNotExist = {
            "Feature.ReportAbuse.Message.UserTextMutedErrorDoesNotExist",
            name = name
        }
    })

    local var19 = useTokens()

    React.useEffect(function()
        analyticsDispatch(
            {
                type = Constants.AnalyticsActions.AccumulateForTimeSpent,
                accumulated_time_ms = workspace:GetServerTimeNow() * 1000
            }
        )
        analyticsDispatch({ type = Constants.AnalyticsActions.SetPlaceId, place_id = game.PlaceId })

        local viewportSize = game.Workspace.CurrentCamera.ViewportSize
        analyticsDispatch({
            type = Constants.AnalyticsActions.SetViewportInformation,
            viewport_size_x = viewportSize.X,
            viewport_size_y = viewportSize.Y,
            is_portrait_mode = viewportSize.X < viewportSize.Y and viewportSize.X < 800
        })

        local num1 = 0
        local num2 = 0
        for _, value in ipairs(tbl3.messages) do
            if isSystemMessage(value) then
                continue
            end

            num1 += 1

            if (not FFlagEnableGlobalChatAbuseReporting or value.textChannel)
                and value.textChannel.Name ~= Constants.ChannelTypes.General
            then
                num2 += 1
            end
        end

        analyticsDispatch({
            type = Constants.AnalyticsActions.SetChatHistoryInformation,
            selectable_chat_history_size = num1,
            total_chat_history_size = #tbl3.messages,
            num_non_general_channel_chats = num2
        })

        local connection = GuiService.MenuOpened:Connect(function()
            var10(true)
            var8(false)
        end)
        local connection2 = GuiService.MenuClosed:Connect(function()
            var10(false)
            var8(true)
        end)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {})

    React.useEffect(function()
        if not engineFeature then
            return
        end

        pcall(function()
            local SafetyService = game:GetService("SafetyService")
            if var7 then
                SafetyService:ReportChatLineReportingOpen()
                return
            end
            SafetyService:ReportChatLineReportingClose()
        end)
    end, { var7 })

    local var20, var21 = ReactOtter.useAnimatedBinding(1, function()
        if var7 then
            return
        end

        if var11 then
            if var13 and var13.key == Constants.SuccessfulMuteKey then
                NotificationModalsManager.SetUIBloxToast({
                    iconImage = Images[Constants.ToastIconImageSuccess],
                    toastTitle = var18.ChatToastTitleSuccess,
                    toastSubtitle = var17.ChatToastDescriptionSuccess,
                    sequenceNumber = DateTime.now().UnixTimestamp,
                    iconColorStyle = {
                        Color = var19.Color.System.Success.Color3,
                        Transparency = 0
                    }
                })
            elseif var13 then
                NotificationModalsManager.SetUIBloxToast({
                    iconImage = Images[Constants.ToastIconImageError],
                    toastTitle = var18.ChatToastTitleError,
                    toastSubtitle = if var13.key == Constants.ErrorSelfMuteKey then var17.ChatToastDescriptionErrorSelf else var18.ChatToastDescriptionErrorDoesNotExist,
                    sequenceNumber = DateTime.now().UnixTimestamp,
                    iconColorStyle = {
                        Color = var19.Color.System.Warning.Color3,
                        Transparency = 0
                    }
                })
            end
        end

        tbl3.unmount()
    end)

    local var22 = React.useMemo(function(): number
        return if var7 then 0 else 1
    end, { var7 })

    React.useEffect(function()
        var21(ReactOtter.spring(var22, tbl1))
    end, { var22 })

    local onContinue = React.useCallback(function()
        if selectedMessage ~= nil then
            var2(Constants.ReportSteps.SUBMIT)
        end
    end)

    local onBack = React.useCallback(function()
        ChatLineReportAnalytics(var5, 2, false)
        var8(false)
    end, { var5 })

    local onBackToPreviousStep = React.useCallback(function()
        var2(Constants.ReportSteps.SELECT)
        setSelectedMessage(nil)
    end)

    local onProceedToNextStep = React.useCallback(function(reasonSelection, arg1): boolean
        local eligibleChatLines = {}
        local tags

        if FFlagEnableChatReportingTextChannelTag then
            tags = buildReport(
                Players.LocalPlayer.UserId,
                selectedMessage.userId,
                reasonSelection,
                arg1,
                selectedMessage.messageId,
                selectedMessage.presetId,
                selectedMessage.presetChatVersion,
                if selectedMessage.textChannel then selectedMessage.textChannel.Name else nil
            )
        else
            tags = buildReport(
                Players.LocalPlayer.UserId,
                selectedMessage.userId,
                reasonSelection,
                arg1,
                selectedMessage.messageId,
                selectedMessage.presetId,
                selectedMessage.presetChatVersion
            )
        end

        Cryo.Dictionary.map(tbl3.messages, function(arg2)
            if not isSystemMessage(arg2) then
                eligibleChatLines[#eligibleChatLines + 1] = {
                    channel = arg2.textChannel,
                    messageId = arg2.messageId
                }
            end
        end)

        local targetChatLines = {{
            channel = selectedMessage.textChannel,
            messageId = selectedMessage.messageId
        }}

        analyticsDispatch({ type = Constants.AnalyticsActions.SetReasonSelection, reason_selection = reasonSelection })

        analyticsDispatch({ type = Constants.AnalyticsActions.SetCommentAdded, comment_added = #arg1 > 0 })

        Players:ReportChatAbuse(eligibleChatLines, targetChatLines, tags)
        var2(Constants.ReportSteps.COMPLETE)
        return true
    end, { tbl3.messages, selectedMessage })

    local onDismiss = React.useCallback(function(arg1)
        if not arg1 then
            ChatLineReportAnalytics(var5, 1, false)
            var8(false)

            return
        end

        ChatLineReportAnalytics(var5, 1, true)
        var14(arg1)
        var16(arg1.args.RBX_NAME)
        var12(true)
        var8(false)
    end, { var5 })

    local var28 = React.useCallback(function()
        ChatLineReportAnalytics(var5, 1, false)
        var8(false)
    end, { var5 })

    if var1 ~= Constants.ReportSteps.COMPLETE then
        var28 = onBack
    end

    local createElement = React.createElement
    local str1 = "TextButton"

    local tbl4 = {
        Active = var20:map(function(arg1): boolean
            return arg1 == 0
        end),
        AutoButtonColor = false,
        BorderSizePixel = 0,
        BackgroundTransparency = var20:map(function(num1: number): number
            return num1 + 0.3
        end),
        BackgroundColor3 = Color3.fromHex("#000000"),
        Text = "",
        Selectable = false,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        [React.Event.Activated] = var28,
        ZIndex = 10
    }

    local tbl5 = { Frame = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"

    local tbl6 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Position = var20:map(function(yScale: number): UDim2
            if var9 then
                return UDim2.new(0, 0, -yScale, 0)
            end
            return UDim2.new(0, 0, yScale, 0)
        end)
    }
    local tbl7 = { ChatLineReportStep = 0 }
    local element

    if var1 == Constants.ReportSteps.SELECT then
        element = React.createElement(ChatLineReportSelectionModalOld, {
            onContinue = onContinue,
            onBack = onBack,
            messages = tbl3.messages,
            selectedMessage = selectedMessage,
            setSelectedMessage = setSelectedMessage,
            analyticsDispatch = analyticsDispatch
        })
    elseif var1 == Constants.ReportSteps.SUBMIT then
        local createElement3 = React.createElement
        local var29 = DefaultReportDialog
        local tbl8 = {
            analyticsContext = "ReportViaChatLine",
            topCustomComponent = React.createElement(ChatLineReportVerbatim, { selectedMessage = selectedMessage }),
            onSubmitProps = { hasNextSteps = true, onProceedToNextStep = onProceedToNextStep },
            localizationKeys = if FFlagGenericAbuseReportingGranularExports then Constants.SubmitDialogLocalizationKeys else Constants.GenericAbuseReportingLocalizationKeys,
            onCloseProps = { hasPreviousSteps = true, onBackToPreviousStep = onBackToPreviousStep },
            reportCategories = ReportCategories,
            onBeforeSubmitAnalytics = 0
        }

        function tbl8.onBeforeSubmitAnalytics<T>(arg1: T): T
            return arg1
        end

        element = createElement3(var29, tbl8)
    elseif var1 == Constants.ReportSteps.COMPLETE then
        element = React.createElement(ChatLineReportCompleteModal, {
            localizationKeys = if FFlagGenericAbuseReportingGranularExports then Constants.CompleteDialogLocalizationKeys else Constants.GenericAbuseReportingLocalizationKeys,
            onDismiss = onDismiss,
            selectedMessage = selectedMessage
        })
    else
        element = nil
    end

    tbl7.ChatLineReportStep = element
    tbl5.Frame = createElement2(str2, tbl6, tbl7)
    local chatLineReportStepHandler = createElement(str1, tbl4, tbl5)

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    var28()
                    arg1:cancel()
                end)
            }
        }
    end, { var28 })

    return React.createElement(FocusRoot, {
        eventHandlers = eventHandlers,
        eventMap = eventMap,
        isAutoFocusRoot = true,
        isIsolated = true,
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
    }, { ChatLineReportStepHandler = chatLineReportStepHandler })
end

return ChatLineReportStepHandler
