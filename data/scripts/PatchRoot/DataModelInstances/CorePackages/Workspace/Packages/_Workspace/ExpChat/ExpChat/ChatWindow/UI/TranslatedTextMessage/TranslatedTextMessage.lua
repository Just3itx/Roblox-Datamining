-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatParent2 = ExpChat.Parent
local UserProfileStore = require(ExpChatParent.UserProfiles).Stores.UserProfileStore
local SignalsReact = require(ExpChatParent.SignalsReact)
local React = require(ExpChatParent2.React)
local RoactRodux = require(ExpChatParent.RoactRodux)
local SharedFlags = require(ExpChatParent.SharedFlags)
local DataHydration = require(ExpChatParent.DataHydration)
local Signals = require(ExpChatParent.Signals)
local Foundation = require(ExpChatParent.Foundation)
local Dictionary = require(ExpChatParent.llama).Dictionary
local Localization = require(ExpChat.Localization)

local isChatRegionLocked = require(ExpChat.isChatRegionLocked)
local showChatEnabledUI = require(ExpChat.showChatEnabledUI)

local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetChatStatusStore = require(ExpChat.Stores.GetChatStatusStore)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

local UIBlox = require(ExpChatParent.UIBlox)
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local FFlagExpChatReportHistoricalRenders = SharedFlags.FFlagExpChatReportHistoricalRenders
local useStore = require(ExpChatParent.RoactUtils).Hooks.RoactRodux.useStore
local shouldSendHighFrequencyTelemetry = require(ExpChat.shouldSendHighFrequencyTelemetry)
local ExpChatPerfTracker = require(ExpChatParent.ChatUIPrimitives).Telemetry.ExpChatPerfTracker
local applyChatWindowMessageEffects = require(ExpChat.MessageEffects.applyChatWindowMessageEffects)
local getMessageEffects = require(ExpChat.MessageEffects.getMessageEffects)
local getChatWindowMessageEffects = require(ExpChat.MessageEffects.getChatWindowMessageEffects)
local getChatWindowPrefixOffset = require(ExpChat.MessageEffects.getChatWindowPrefixOffset)
local getChatWindowMessageLineHeight = require(ExpChat.MessageEffects.getChatWindowMessageLineHeight)
local MessageEffect = require(ExpChat.MessageEffects.MessageEffect)
local TextChatMessageChatActionType = require(ExpChat.TextChatMessageChatActionType)
local isChatWindowEnlargeEnabled = require(ExpChat.isChatWindowEnlargeEnabled)

local FFlagExpChatMessageEffectChatWindowEnlargePadding = require(ExpChat.Flags.FFlagExpChatMessageEffectChatWindowEnlargePadding)

local FFlagExpChatMessageEffectChatWindowEnlargeLineHeight = require(ExpChat.Flags.FFlagExpChatMessageEffectChatWindowEnlargeLineHeight)

local FIntExpChatMessageEffectChatWindowEnlargePaddingPixels = require(ExpChat.Flags.FIntExpChatMessageEffectChatWindowEnlargePaddingPixels)

local EngineFeatureTextChatReportEmojiTelemetryEnabled = require(ExpChat.Flags.EngineFeatureTextChatReportEmojiTelemetryEnabled)

local FFlagDebugMessageProfiling = require(ExpChat.Flags.FFlagDebugMessageProfiling)
local bool1 = game:DefineFastFlag("ExpChatTranslationToggleSpacingFix", false)
local getFFlagExpChatUseUpdatedMessageRendered = require(ExpChat.Flags.getFFlagExpChatUseUpdatedMessageRendered)
local shouldReportMessageRender = require(ExpChat.shouldReportMessageRender)

local var1 = require(ExpChat.Flags.getFIntExpChatMessageRenderUserThrottlePermyriad)()
local getFFlagExpChatExcludeFOMORenders = require(ExpChat.Flags.getFFlagExpChatExcludeFOMORenders)
local FFlagEnableInExpChatRewrite = require(ExpChat.Flags.FFlagEnableInExpChatRewrite)
local FStringInExpChatRewriteLabelKey = require(ExpChat.Flags.FStringInExpChatRewriteLabelKey)
local FStringInExpChatRewriteReasonKey = require(ExpChat.Flags.FStringInExpChatRewriteReasonKey)
local FFlagExpChatRewriteInline = require(ExpChat.Flags.FFlagExpChatRewriteInline)
local FFlagExpChatRewriteInlineIxpEnabled = require(ExpChat.Flags.FFlagExpChatRewriteInlineIxpEnabled)
local FFlagExpChatRewriteToggleAnalytics = require(ExpChat.Flags.FFlagExpChatRewriteToggleAnalytics)
local FStringExpChatRewriteInlineIxpLayer = require(ExpChat.Flags.FStringExpChatRewriteInlineIxpLayer)

local FIntExpChatWindowTransparencyRewriteInteractableThreshold = require(ExpChat.Flags.FIntExpChatWindowTransparencyRewriteInteractableThreshold)
local FFlagEnableInExpChatSummaryOnLua = require(ExpChat.Flags.FFlagEnableInExpChatSummaryOnLua)
local FFlagExpChatPolishSummaryMessageUI = require(ExpChat.Flags.FFlagExpChatPolishSummaryMessageUI)

local EngineFeatureExpChatGlobalChatEngineTelemetryEnabled = require(ExpChat.Flags.EngineFeatureExpChatGlobalChatEngineTelemetryEnabled)
local summaryMessageRichText = require(ExpChat.summaryMessageRichText)

local useCursor = UIBlox.App.SelectionCursor.useCursor

local Config = require(ExpChat.Config)

local Helpers = ExpChat.ChatWindow.Helpers
local getMessageSettings = require(Helpers.getMessageSettings)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local duplicateInvisibleText = require(Helpers.duplicateInvisibleText)

local Flags = ExpChat.Flags
local isExperienceChatUserProfileApiEnabled = require(Flags.isExperienceChatUserProfileApiEnabled)
local FIntExpChatVisibleARButtonPadding = require(Flags.FIntExpChatVisibleARButtonPadding)
local FIntExpChatDefaultARButtonPadding = require(Flags.FIntExpChatDefaultARButtonPadding)
local FFlagExpChatTopBannerForPresetChatAccess = require(Flags.FFlagExpChatTopBannerForPresetChatAccess)
local FFlagExpChatFixLocalUserVerifiedBadge = require(Flags.FFlagExpChatFixLocalUserVerifiedBadge)
local FFlagExpChatUnconditionalCombinedNameHook = require(Flags.FFlagExpChatUnconditionalCombinedNameHook)
local ExpChatShared = require(ExpChatParent2.ExpChatShared)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local getPresetIconRichText = ExpChatShared.getPresetIconRichText
local useIsARButtonVisible = require(ExpChat.useIsARButtonVisible)
local isPresetMessage = ExpChatShared.isPresetMessage

function appendVerifiedBadge(str1: string)
    return string.gsub(str1, ":(%S-)$", Config.VERIFIED_EMOJI .. ":%1")
end

local function getNilName(_)
    return nil
end

local function func1(message)
    local func2 = getNilName
    local func3 = getNilName
    if (not GetFFlagTextChatEnableUniverseChatTabs() or message.textChannel ~= nil)
        and isExperienceChatUserProfileApiEnabled()
        and message.userId
    then
        local str1 = tostring(message.userId)
        local var2 = UserProfileStore.get().fetchNamesByUserIds({ str1 })(false).data[1]
        func2 = var2.names.getDisplayName
        func3 = var2.names.getInExperienceCombinedName
    end
    return {
        displayName = SignalsReact.useSignalBinding(func2),
        inExperienceCombinedName = SignalsReact.useSignalBinding(func3)
    }
end

function trim(arg1)
    if arg1:match("^()%s*$") then
        return ""
    end

    return (arg1:match("^%s*(.*%S)"))
end

function getMessageText(useTranslation: boolean?, translation: string?, text: string?): string
    return if translation == nil or translation == "" then text or "" elseif useTranslation then translation or "" else text or ""
end

local function calculateTransparency(arg1, arg2) -- Luacid: Inlined by compiler; 15 call sites recovered
    return arg1 + arg2 * (1 - arg1)
end

local function setTransparency(arg1, arg2) -- Luacid: unused: defined but never referenced
    return arg2:map(function(arg3)
        if arg1 == nil then
            return 1
        end

        return calculateTransparency(arg1, arg3)
    end)
end

local function useARButtonRightPadding() -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagExpChatPresetChatEnabled and FFlagExpChatTopBannerForPresetChatAccess then
        return if useIsARButtonVisible() then FIntExpChatVisibleARButtonPadding else FIntExpChatDefaultARButtonPadding
    end

    local chatStatusStore = GetChatStatusStore(false)
    local var2 = SignalsReact.useSignalState(chatStatusStore.getChatStatus)
    local var3 = showChatEnabledUI(var2)
    return if not isChatRegionLocked() and var3 then FIntExpChatVisibleARButtonPadding else FIntExpChatDefaultARButtonPadding
end

local function appendTrustedIndicator(str1: string, trustedLabelText: string, num1: number, textSize: number, arg1)
    local var2 = arg1.Color.Shift.Shift_300.Color3:ToHex()
    local transparency = calculateTransparency(arg1.Color.Shift.Shift_300.Transparency, num1)

    local var3 = arg1.Color.Content.Emphasis.Color3:ToHex()
    local transparency2 = calculateTransparency(arg1.Color.Content.Emphasis.Transparency, num1)

    local num2 = textSize - 4

    local str2 = `{`{`{`{`<mark color='#{var2}' transparency='{transparency}'>`}<font transparency='1' weight='{600}' size='{num2}'><stroke transparency='1'>_`}<font color='#{var3}' transparency='{transparency2}'>{trustedLabelText}</font>`}_</stroke></font>`}</mark>`

    if string.find(str1, ":([%S:]-)$") then
        return string.gsub(str1, ":([%S:]-)$", ` {str2} :%1`)
    end
    return `{str1} {str2}`
end

local var2 = DataHydration.TrustedConnections.TrustedConnectionsStore.get()

local function applyStyleToText(arg1, arg2, message, num1: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    local var3 = arg2 or ""
    if message.chatActionType == TextChatMessageChatActionType.Summary then
        var3 = summaryMessageRichText.wrapInSummaryMutedStyle(
            summaryMessageRichText.getSummaryIconPrefix(num1) .. " " .. var3,
            arg1.Color.Content.Muted.Color3:ToHex(),
            num1
        )
    end

    return var3
end

local function func2(arg1)
    if FFlagDebugMessageProfiling then
        debug.profilebegin("TranslatedTextMessage")
    end
    local messageId = arg1.message.messageId or "UNKNOWN_MESSAGE_ID"
    React.useEffect(function()
        ExpChatPerfTracker.finish(ExpChatPerfTracker.Events.MessageReceiveToWindowRenderInterval, { messageId = messageId })

        ExpChatPerfTracker.finish(ExpChatPerfTracker.Events.MessageSendToWindowRenderInterval, { messageId = messageId })
    end, { messageId })
    local isSpatialUiEnabled = arg1.isSpatialUIEnabled
    local var3 = if isSpatialUiEnabled then arg1.chatWindowSettings.SpatialPanelTextSize else arg1.chatWindowSettings.TextSize
    local var4 = Localization.useLocalization({
        trustedLabelText = "CoreScripts.TextChat.ChatWindow.TrustedLabel",
        hereLabel = if FFlagExpChatGlobalTabDefault then "CoreScripts.TextChat.ChannelTabs.Here" else nil,
        rewrittenLabelText = if FFlagExpChatRewriteInline then FStringInExpChatRewriteLabelKey else nil,
        defaultRewrittenLabelText = if FFlagExpChatRewriteInline then "CoreScripts.TextChat.ChatWindow.RewrittenLabel" else nil
    })

    local var5 = if FFlagExpChatRewriteInline then if var4.rewrittenLabelText and var4.rewrittenLabelText ~= "" then var4.rewrittenLabelText else var4.defaultRewrittenLabelText else nil

    local var6 = Foundation.Hooks.useTokens()

    local messageSettings = getMessageSettings(arg1.message, arg1.chatWindowSettings, if FFlagExpChatGlobalTabDefault then var4.hereLabel else nil)

    local showTranslationButton = arg1.showTranslationButton
    local useTranslation = messageSettings.useTranslation
    local messageText = getMessageText(useTranslation, messageSettings.translation, messageSettings.text)
    local messageEffects = nil
    if isChatWindowEnlargeEnabled() then
        messageEffects = getMessageEffects(messageText)
        messageText = applyChatWindowMessageEffects(messageText, messageEffects)
    end
    local prefixText = messageSettings.prefixText or ""

    local var7 = nil
    if FFlagExpChatUnconditionalCombinedNameHook then
        var7 = func1(arg1.message)
    elseif GetFFlagTextChatEnableUniverseChatTabs() and arg1.message.textChannel == nil then
        var7 = nil
    elseif isExperienceChatUserProfileApiEnabled() and arg1.message.userId then
        if FFlagDebugMessageProfiling then
            debug.profilebegin("useCombinedName")
        end
        var7 = func1(arg1.message)
        if FFlagDebugMessageProfiling then
            debug.profileend()
        end
    end

    local userId = arg1.message.userId and tostring(arg1.message.userId)
    local isHiddenMessage = if getFFlagExpChatExcludeFOMORenders() then arg1.message.isHiddenMessage else nil

    local var8 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var8 = userId and userId ~= ""

            local userId2 = Players.LocalPlayer and Players.LocalPlayer.UserId and tostring(Players.LocalPlayer.UserId)

            local var9 = userId2 and userId2 == userId

            if var8 and not (var9 or isHiddenMessage) then
                return (var2.getIsTrustedConnection(userId).data(arg2))
            end

            return nil
        end)
    end, { userId, isHiddenMessage })

    local var9 = SignalsReact.useSignalBinding(var8)
    local var10 = if EngineFeatureExpChatGlobalChatEngineTelemetryEnabled and not FFlagExpChatUseChannelTabsStore then useStore() else nil

    if getFFlagExpChatUseUpdatedMessageRendered() then
        React.useEffect(function()
            if not arg1.message.textChatMessageInstance
                or not shouldSendHighFrequencyTelemetry(var1)
                or getFFlagExpChatExcludeFOMORenders() and arg1.message.isHiddenMessage
                or not (if FFlagExpChatReportHistoricalRenders then shouldReportMessageRender(arg1.message) else not arg1.message.isHistorical)
            then
                return
            end

            if not EngineFeatureExpChatGlobalChatEngineTelemetryEnabled then
                TextChatService:SendExpChatMessageClientRendered(arg1.message.textChatMessageInstance, "chat_window")
                return
            end

            local selectedChannelTab = -1
            if FFlagExpChatUseChannelTabsStore then
                local channelTabsStore = GetChannelTabsStore(false)
                local channelTabsState = channelTabsStore.getChannelTabsState(false)
                local selectedTabName = channelTabsStore.getSelectedTabName(false)
                if selectedTabName and channelTabsState.allChannelTabs[selectedTabName] then
                    selectedChannelTab = channelTabsState.allChannelTabs[selectedTabName].tabIndex
                end
            else
                local channelTabs = var10:getState().ChannelTabs
                local selectedTabName = channelTabs and channelTabs.selectedTabName
                if selectedTabName and channelTabs.allChannelTabs[selectedTabName] then
                    selectedChannelTab = channelTabs.allChannelTabs[selectedTabName].TabIndex
                end
            end

            if EngineFeatureTextChatReportEmojiTelemetryEnabled then
                local specialEffects = not isChatWindowEnlargeEnabled() and {} or getChatWindowMessageEffects(messageEffects)

                TextChatService:SendExpChatMessageClientRendered(
                    arg1.message.textChatMessageInstance,
                    "chat_window",
                    selectedChannelTab,
                    "",
                    specialEffects
                )
                return
            end

            TextChatService:SendExpChatMessageClientRendered(
                arg1.message.textChatMessageInstance,
                "chat_window",
                selectedChannelTab
            )
        end, {})
    end
    local bodyTextProperties = messageSettings.bodyTextProperties
    local prefixTextProperties = messageSettings.prefixTextProperties

    if not isSpatialUiEnabled then
        var3 = bodyTextProperties.TextSize
    end

    local var11 = var3 - 2
    local offset = if isChatWindowEnlargeEnabled() then UDim2.fromOffset(0, getChatWindowPrefixOffset(messageEffects, prefixTextProperties.TextSize)) else nil
    local lineHeight = if FFlagExpChatMessageEffectChatWindowEnlargeLineHeight and isChatWindowEnlargeEnabled() then getChatWindowMessageLineHeight(messageEffects, var3, prefixTextProperties.TextSize) else nil

    local var12 = React.joinBindings(var7 == nil and {} or { var7.displayName, var7.inExperienceCombinedName }):map(function(arg2)
        local var12 = arg2[1] or ""
        local var13 = arg2[2] or ""

        local var14 = prefixText

        if string.len(var12) > 0 and string.len(var13) > 0 and var12 ~= var13 then
            var14 = string.gsub(var14, var12, var13)
        end

        if string.len(prefixText) > 0 and arg1.isUserVerified then
            var14 = appendVerifiedBadge(var14)
        end

        return var14
    end)
    local var13 = React.joinBindings({ var12, var9, arg1.textTransparency }):map(function(arg2)
        local var13 = arg2[1] or ""
        local var14 = arg2[2] or false
        local var15 = arg2[3]
        local var16 = if var15 == nil then 1 else var15
        if string.len(prefixText) == 0 then
            return var13
        end

        if var14 then
            var13 = appendTrustedIndicator(var13, var4.trustedLabelText, var16, prefixTextProperties.TextSize, var6)
        end

        return var13
    end)
    local var14 = var13:map(function(arg2)
        if string.len(prefixText) == 0 then
            return arg2
        end
        return trim(arg2)
    end)

    local var15 = var13:map(function(arg2)
        local var15 = messageText
        if FFlagEnableInExpChatSummaryOnLua then
            local var16 = if FFlagExpChatPolishSummaryMessageUI then var3 else nil
            var15 = applyStyleToText(var6, messageText, arg1.message, var16)
        end

        if FFlagExpChatPresetChatEnabled and isPresetMessage(arg1.message) then
            var15 ..= ` {getPresetIconRichText(var3)}`
        end

        if string.len(prefixText) == 0 then
            return if FFlagEnableInExpChatSummaryOnLua then var15 else messageText
        end

        if showTranslationButton then
            if bool1 then
                var15 = "     " .. var15
            else
                var15 = "   " .. var15
            end
        end
        return duplicateInvisibleText(arg2, prefixTextProperties.FontFace, prefixTextProperties.TextSize) .. " " .. var15
    end)
    if FFlagExpChatRewriteInline then
        var15 = React.joinBindings({ var15 }):map(function(arg2)
            local var16 = arg2[1] or ""
            if not arg1.wasRewritten then
                return var16
            end

            local var17 = if arg1.isRewriteMenuOpen then Foundation.Enums.IconName.ChevronLargeUp else Foundation.Enums.IconName.ChevronLargeDown
            return `{var16} <font size='{prefixTextProperties.TextSize - 4}' color='#{var6.Color.Content.Muted.Color3:ToHex()}'>{`({var5})`}<font transparency='1'><stroke transparency='1'>_</stroke></font>{`<font weight='600' family='rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json'>{var17}</font>`}</font>`
        end)
    end

    local selectionImageObject = useCursor()
    local var17 = if FFlagExpChatMessageEffectChatWindowEnlargePadding and isChatWindowEnlargeEnabled() then UDim.new(
        0,
        if messageEffects then if table.find(messageEffects, MessageEffect.ChatWindowEnlarge) then FIntExpChatMessageEffectChatWindowEnlargePaddingPixels else 0 else 0
    ) else nil
    local element

    if FFlagEnableInExpChatRewrite then
        local offset2 = useARButtonRightPadding()
        element = React.createElement("UIPadding", { PaddingRight = UDim.new(0, offset2), PaddingTop = var17, PaddingBottom = var17 })
    else
        local chatStatusStore = GetChatStatusStore(false)
        local var18 = SignalsReact.useSignalState(chatStatusStore.getChatStatus)
        local var19 = showChatEnabledUI(var18)
        local var20 = not isChatRegionLocked() and var19

        element = React.createElement("UIPadding", {
            PaddingRight = UDim.new(0, if var20 then FIntExpChatVisibleARButtonPadding else FIntExpChatDefaultARButtonPadding),
            PaddingTop = var17,
            PaddingBottom = var17
        })
    end

    local bool2 = if FFlagExpChatRewriteInline and arg1.wasRewritten then arg1.chatWindowTransparencyBindable == nil
        or (if typeof(arg1.chatWindowTransparencyBindable) == "number" then arg1.chatWindowTransparencyBindable < FIntExpChatWindowTransparencyRewriteInteractableThreshold else arg1.chatWindowTransparencyBindable:map(function(arg2): boolean
            return arg2 < FIntExpChatWindowTransparencyRewriteInteractableThreshold
        end)) else nil

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = arg1.LayoutOrder
    }
    local tbl2 = { UIPadding = element, TextMessage = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1
    }
    local tbl4 = { PrefixText = 0, BodyText = 0, TextMessageButton = 0 }
    local var18

    if string.len(prefixText) > 0 then
        local createElement3 = React.createElement
        local str3 = "TextLabel"
        local tbl5 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = prefixTextProperties.FontFace,
            LineHeight = lineHeight,
            Position = offset,
            RichText = true,
            Text = var13,
            TextColor3 = prefixTextProperties.TextColor3,
            TextSize = prefixTextProperties.TextSize,
            TextStrokeColor3 = prefixTextProperties.TextStrokeColor3,
            TextStrokeTransparency = 0,
            TextTransparency = 0,
            TextWrapped = true,
            TextXAlignment = 0,
            TextYAlignment = 0
        }
        local textStrokeTransparency = prefixTextProperties.TextStrokeTransparency

        tbl5.TextStrokeTransparency = arg1.textTransparency:map(function(arg2)
            if textStrokeTransparency == nil then
                return 1
            end

            return calculateTransparency(textStrokeTransparency, arg2)
        end)

        local num1 = 0

        tbl5.TextTransparency = arg1.textTransparency:map(function(arg2)
            if num1 == nil then
                return 1
            end

            return calculateTransparency(num1, arg2)
        end)
        tbl5.TextXAlignment = Enum.TextXAlignment.Left
        tbl5.TextYAlignment = Enum.TextYAlignment.Top
        var18 = createElement3(str3, tbl5, {
            UIGradient = not (prefixTextProperties.UIGradient == nil) and React.createElement("UIGradient", prefixTextProperties.UIGradient)
        })
    else
        var18 = false
    end

    tbl4.PrefixText = var18

    local createElement3 = React.createElement
    local var19 = FFlagExpChatRewriteInline and arg1.wasRewritten and "TextButton" or "TextLabel"
    local tbl5 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        FontFace = bodyTextProperties.FontFace,
        LineHeight = lineHeight,
        RichText = true,
        Size = UDim2.new(1, 0, 0, 0),
        Text = var15,
        TextColor3 = bodyTextProperties.TextColor3,
        TextSize = var3,
        TextStrokeColor3 = bodyTextProperties.TextStrokeColor3
    }
    local textStrokeTransparency = bodyTextProperties.TextStrokeTransparency

    tbl5.TextStrokeTransparency = arg1.textTransparency:map(function(arg2)
        if textStrokeTransparency == nil then
            return 1
        end

        return calculateTransparency(textStrokeTransparency, arg2)
    end)

    local num1 = 0

    tbl5.TextTransparency = arg1.textTransparency:map(function(arg2)
        if num1 == nil then
            return 1
        end

        return calculateTransparency(num1, arg2)
    end)

    tbl5.TextWrapped = true
    tbl5.TextXAlignment = Enum.TextXAlignment.Left
    tbl5.TextYAlignment = Enum.TextYAlignment.Top

    local activated = React.Event.Activated
    tbl5[activated] = if FFlagExpChatRewriteInline and arg1.wasRewritten then arg1.onTextBodyActivated else nil

    tbl5.Interactable = bool2
    tbl4.BodyText = createElement3(var19, tbl5)
    local var20

    if string.len(prefixText) == 0 then
        var20 = nil
    else
        local createElement4 = React.createElement
        local str3 = "Frame"
        local tbl6 = {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Position = offset,
            Size = UDim2.new(1, 0, 0, 0)
        }
        local tbl7 = {
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 4)
                }
            ),
            TextButton = 0,
            TranslationButton = 0
        }
        local createElement5 = React.createElement
        local tbl8 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = prefixTextProperties.FontFace,
            LineHeight = lineHeight,
            RichText = true,
            SelectionImageObject = selectionImageObject,
            Size = UDim2.new(0, 0, 0, 0),
            Text = var14,
            TextSize = prefixTextProperties.TextSize,
            TextStrokeTransparency = 1,
            TextTransparency = 1,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            LayoutOrder = 1
        }
        tbl8[React.Event.Activated] = function()
            arg1.onTextMessageLabelButtonActivated(arg1.message)
        end

        tbl7.TextButton = createElement5("TextButton", tbl8)
        local var21

        if showTranslationButton then
            local createElement6 = React.createElement
            local tbl9 = {
                BackgroundTransparency = 1,
                HoverImage = "rbxasset://textures/translateIconDark.png",
                Image = "rbxasset://textures/translateIcon.png"
            }
            local num2 = 0

            tbl9.ImageTransparency = arg1.textTransparency:map(function(arg2)
                if num2 == nil then
                    return 1
                end

                return calculateTransparency(num2, arg2)
            end)

            tbl9.LayoutOrder = 2
            tbl9.PressedImage = "rbxasset://textures/translateIconDark.png"
            tbl9.SelectionImageObject = selectionImageObject
            tbl9.Size = UDim2.new(0, var11, 0, var11)
            tbl9[React.Event.Activated] = function()
                arg1.onToggle(not arg1.message.useTranslation, arg1.message.messageId)
            end

            var21 = createElement6("ImageButton", tbl9)
        else
            var21 = nil
        end

        tbl7.TranslationButton = var21
        var20 = createElement4(str3, tbl6, tbl7)
    end

    tbl4.TextMessageButton = var20
    tbl2.TextMessage = createElement2(str2, tbl3, tbl4)
    local element2 = createElement(str1, tbl1, tbl2)

    if FFlagDebugMessageProfiling then
        debug.profileend()
    end
    return element2
end

local function TranslatedTextMessageWithToggle(_)
    return RoactRodux.connect(function() end, function(_)
        return {
            onToggle = function(bool2: boolean, str1: string)
                GetMessagesStore(false).toggleMessageTranslation(bool2, str1)
            end
        }
    end)(func2)
end

local function RewriteLabelWithButton(arg1)
    local var3 = Foundation.Hooks.useTokens()
    local var4 = Localization.useLocalization({
        rewrittenLabelText = FStringInExpChatRewriteLabelKey,
        defaultRewrittenLabelText = "CoreScripts.TextChat.ChatWindow.RewrittenLabel"
    })
    local var5 = if var4.rewrittenLabelText and var4.rewrittenLabelText ~= "" then var4.rewrittenLabelText else var4.defaultRewrittenLabelText
    local createElement = React.createElement
    local view = Foundation.View
    local tbl1 = {
        tag = "size-full-0 auto-y row align-y-center gap-xsmall",
        LayoutOrder = arg1.LayoutOrder
    }
    local tbl2 = { Label = 0, IconButton = 0 }
    local createElement2 = React.createElement
    local foundationText = Foundation.Text
    local tbl3 = {
        Text = "(" .. var5 .. ")",
        tag = "size-0-0 auto-xy text-caption-small text-align-x-left",
        LayoutOrder = 1,
        RichText = true,
        textStyle = 0,
        stroke = 0
    }

    local textStyle = {
        Color3 = var3.Color.Content.Muted.Color3,
        Transparency = 0
    }
    local mutedTransparency = var3.Color.Content.Muted.Transparency

    textStyle.Transparency = arg1.textTransparency:map(function(arg2)
        if mutedTransparency == nil then
            return 1
        end

        return calculateTransparency(mutedTransparency, arg2)
    end)

    tbl3.textStyle = textStyle

    local stroke = {
        Color = Color3.fromRGB(0, 0, 0),
        Transparency = 0,
        Thickness = 0
    }
    local num1 = 0.5

    stroke.Transparency = arg1.textTransparency:map(function(arg2)
        if num1 == nil then
            return 1
        end

        return calculateTransparency(num1, arg2)
    end)

    stroke.Thickness = var3.Stroke.Thin
    tbl3.stroke = stroke
    tbl2.Label = createElement2(foundationText, tbl3)

    tbl2.IconButton = React.createElement(Foundation.IconButton, {
        size = Foundation.Enums.InputSize.XSmall,
        icon = if arg1.isRewriteMenuOpen then Foundation.Enums.IconName.ChevronLargeUp else Foundation.Enums.IconName.ChevronLargeDown,
        variant = Foundation.Enums.ButtonVariant.Utility,
        isCircular = true,
        LayoutOrder = 2,
        Visible = arg1.textTransparency:map(function(arg2): boolean
            return arg2 < 1
        end),
        onActivated = arg1.onActivated
    })

    return createElement(view, tbl1, tbl2)
end

return React.memo(function(arg1) -- name: TranslatedTextMessageWrapper
    local messageSettings = getMessageSettings(arg1.message, arg1.chatWindowSettings)
    local showTranslationButton = arg1.showTranslationButton

    local var3 = nil

    local var4 = nil
    local var5 = nil
    local var6 = nil
    local originalText = nil
    local bool2 = false
    local wasRewritten = false
    local var7, var8

    if FFlagEnableInExpChatRewrite then
        var7 = math.max(useARButtonRightPadding() - FIntExpChatDefaultARButtonPadding, 0)
        local var9 = Localization.useLocalization({
            rewrittenReasonLabelText = FStringInExpChatRewriteReasonKey,
            defaultRewrittenReasonLabelText = "CoreScripts.TextChat.ChatWindows.RewrittenReasonLabel"
        })

        if var9.rewrittenReasonLabelText and var9.rewrittenReasonLabelText ~= "" then
            var8 = var9.rewrittenReasonLabelText
        else
            var8 = var9.defaultRewrittenReasonLabelText
        end

        var3 = Foundation.Hooks.useTokens()
        var4, var5 = React.useState(false)

        wasRewritten = messageSettings.wasRewritten
        originalText = messageSettings.originalText
        local var10 = wasRewritten

        if var10 then
            if originalText == nil then
                var10 = false
            else
                var10 = originalText ~= ""
            end
        end

        bool2 = var10

        var6 = React.useCallback(function()
            if FFlagExpChatRewriteToggleAnalytics then
                ExpChatShared.Analytics:TelemetryLogEvent(
                    ExpChatShared.Analytics.RewriteDropdownToggledConfig,
                    {
                        messageId = arg1.message.messageId,
                        isDropdownOpen = tostring(var4),
                        showOriginalText = tostring(bool2)
                    },
                    ExpChatShared.Analytics.DefaultStandardizedFields
                )
            end

            var5(function(arg2): boolean
                return not arg2
            end)
        end, { var4, bool2, arg1.message.messageId })

        if FFlagExpChatRewriteInlineIxpEnabled then
            React.useEffect(function()
                if wasRewritten then
                    IXPService:LogFlagLinkedUserLayerExposure(FStringExpChatRewriteInlineIxpLayer)
                end
            end, { wasRewritten })
        end
    else
        var7 = 0
        var8 = ""
    end

    local var9 = if FFlagExpChatRewriteInline and wasRewritten then Dictionary.join(
        arg1,
        {
            isRewriteMenuOpen = var4,
            wasRewritten = wasRewritten,
            onTextBodyActivated = var6,
            LayoutOrder = 1
        }
    ) elseif FFlagEnableInExpChatRewrite and wasRewritten then Dictionary.join(arg1, { LayoutOrder = 1 }) else arg1
    local element = if showTranslationButton then React.createElement(TranslatedTextMessageWithToggle, var9) else React.createElement(func2, var9)

    if FFlagEnableInExpChatRewrite and wasRewritten then
        local createElement = React.createElement
        local view = Foundation.View
        local tbl1 = {
            tag = `size-full-0 auto-y align-y-top col{if FFlagExpChatRewriteInline then " gap-xsmall" else ""}`,
            LayoutOrder = arg1.LayoutOrder
        }
        local tbl2 = {
            UIPadding = if var4 then React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 4) }) else nil,
            TranslatedTextMessage = element,
            RewriteLabelWithButton = if wasRewritten and not FFlagExpChatRewriteInline then React.createElement(
                RewriteLabelWithButton,
                {
                    onActivated = var6,
                    isRewriteMenuOpen = var4,
                    transparencyValue = arg1.transparencyValue,
                    textTransparency = arg1.textTransparency,
                    LayoutOrder = 2
                }
            ) else nil,
            DropdownMenu = 0
        }
        local var10

        if var4 then
            local createElement2 = React.createElement
            local view2 = Foundation.View
            local tbl3 = {
                tag = "align-x-left col radius-medium gap-xxsmall padding-small",
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, -FIntExpChatDefaultARButtonPadding, 0, 0),
                LayoutOrder = 3,
                backgroundStyle = 0
            }
            local backgroundStyle = {
                Color3 = var3.Color.Common.Scrim.Color3,
                Transparency = 0
            }
            local num1 = 0.7

            backgroundStyle.Transparency = arg1.transparencyValue:map(function(arg2)
                if num1 == nil then
                    return 1
                end

                return calculateTransparency(num1, arg2)
            end)

            tbl3.backgroundStyle = backgroundStyle

            local tbl5 = { OriginalText = 0, Divider = 0, ReasoningText = 0 }
            local var11

            if bool2 then
                local createElement3 = React.createElement
                local foundationText = Foundation.Text
                local tbl6 = {
                    Text = originalText,
                    tag = "text-body-small text-align-x-left",
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, -var7, 0, 0),
                    LayoutOrder = 1,
                    RichText = true,
                    TextWrapped = true,
                    textStyle = 0,
                    stroke = 0
                }

                local textStyle = {
                    Color3 = var3.Color.Content.Muted.Color3,
                    Transparency = 0
                }
                local mutedTransparency = var3.Color.Content.Muted.Transparency

                textStyle.Transparency = arg1.textTransparency:map(function(arg2)
                    if mutedTransparency == nil then
                        return 1
                    end

                    return calculateTransparency(mutedTransparency, arg2)
                end)

                tbl6.textStyle = textStyle

                local stroke = {
                    Color = Color3.fromRGB(0, 0, 0),
                    Transparency = 0,
                    Thickness = 0
                }
                local num2 = 0.5

                stroke.Transparency = arg1.textTransparency:map(function(arg2)
                    if num2 == nil then
                        return 1
                    end

                    return calculateTransparency(num2, arg2)
                end)

                stroke.Thickness = var3.Stroke.Thin
                tbl6.stroke = stroke
                var11 = createElement3(foundationText, tbl6)
            else
                var11 = nil
            end

            tbl5.OriginalText = var11

            tbl5.Divider = if bool2 then React.createElement(Foundation.Divider, {
                orientation = Foundation.Enums.Orientation.Horizontal,
                LayoutOrder = 2,
                Visible = arg1.textTransparency:map(function(arg2): boolean
                    return arg2 < 1
                end),
                DividerVariant = Foundation.Enums.DividerVariant.Default
            }) else nil

            local createElement3 = React.createElement
            local foundationText = Foundation.Text
            local tbl6 = {
                Text = var8,
                tag = "text-body-small text-align-x-left",
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, -var7, 0, 0),
                LayoutOrder = 3,
                RichText = true,
                TextWrapped = true,
                textStyle = 0,
                stroke = 0
            }

            local textStyle = {
                Color3 = var3.Color.Content.Default.Color3,
                Transparency = 0
            }
            local defaultTransparency = var3.Color.Content.Default.Transparency

            textStyle.Transparency = arg1.textTransparency:map(function(arg2)
                if defaultTransparency == nil then
                    return 1
                end

                return calculateTransparency(defaultTransparency, arg2)
            end)

            tbl6.textStyle = textStyle

            local stroke = {
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 0,
                Thickness = 0
            }
            local num2 = 0.5

            stroke.Transparency = arg1.textTransparency:map(function(arg2)
                if num2 == nil then
                    return 1
                end

                return calculateTransparency(num2, arg2)
            end)

            stroke.Thickness = var3.Stroke.Thin
            tbl6.stroke = stroke
            tbl5.ReasoningText = createElement3(foundationText, tbl6)
            var10 = createElement2(view2, tbl3, tbl5)
        else
            var10 = nil
        end

        tbl2.DropdownMenu = var10
        element = createElement(view, tbl1, tbl2)
    end

    return element
end, function(arg1, arg2) -- name: areEqual
    local bool2

    if arg1.message.text == arg2.message.text
        and arg1.message.prefixText == arg2.message.prefixText
        and arg1.message.translation == arg2.message.translation
        and arg1.message.useTranslation == arg2.message.useTranslation
        and arg1.message.messageId == arg2.message.messageId
    then
        if FFlagExpChatFixLocalUserVerifiedBadge then
            if arg1.message.userId == arg2.message.userId then
                bool2 = arg1.isUserVerified == arg2.isUserVerified
            else
                bool2 = false
            end
        else
            bool2 = true
        end

        if bool2 then
            if arg1.chatWindowSettings == arg2.chatWindowSettings then
                bool2 = (not FFlagEnableInExpChatRewrite
                    or arg1.message.wasRewritten == arg2.message.wasRewritten and arg1.message.originalText == arg2.message.originalText)
                    and (not FFlagExpChatRewriteInline or arg1.chatWindowTransparencyBindable == arg2.chatWindowTransparencyBindable)
                    and (not FFlagEnableInExpChatSummaryOnLua or arg1.message.chatActionType == arg2.message.chatActionType)

                if bool2 then
                    if FFlagExpChatPresetChatEnabled then
                        return arg1.message.presetId == arg2.message.presetId
                    end

                    bool2 = true
                end
            else
                bool2 = false
            end
        end
    else
        bool2 = false
    end

    return bool2
end)
