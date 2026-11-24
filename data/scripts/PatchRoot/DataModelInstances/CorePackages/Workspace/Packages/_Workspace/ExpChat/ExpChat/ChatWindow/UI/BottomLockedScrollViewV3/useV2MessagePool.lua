-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local Signals = require(ExpChatParent.Signals)
local SignalsReact = require(ExpChatParent.SignalsReact)
local DataHydration = require(ExpChatParent.DataHydration)
local UserProfiles = require(ExpChatParent.UserProfiles)
local VerifiedBadgeDisplayStore = UserProfiles.Stores.VerifiedBadgeDisplayStore
local SharedFlags = require(ExpChatParent.SharedFlags)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local _MessageEffect = require(ExpChat.MessageEffects.MessageEffect)
local getMessageEffects = require(ExpChat.MessageEffects.getMessageEffects)
local FFlagEnableVerifiedBadgeStore = SharedFlags.FFlagEnableVerifiedBadgeStore
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local FFlagExpChatReportHistoricalRenders = SharedFlags.FFlagExpChatReportHistoricalRenders

local EngineFeatureTextChatReportEmojiTelemetryEnabled = require(ExpChat.Flags.EngineFeatureTextChatReportEmojiTelemetryEnabled)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local useStore = require(ExpChatParent.RoactUtils).Hooks.RoactRodux.useStore
local UserProfileStore = UserProfiles.Stores.UserProfileStore
local getChatWindowMessageEffects = require(ExpChat.MessageEffects.getChatWindowMessageEffects)

local TranslatedTextMessageV2 = require(ExpChat.ChatWindow.UI.TranslatedTextMessageV2)
local shouldSendHighFrequencyTelemetry = require(ExpChat.shouldSendHighFrequencyTelemetry)
local isChatWindowEnlargeEnabled = require(ExpChat.isChatWindowEnlargeEnabled)

local Helpers = ExpChat.ChatWindow.Helpers
local getMessageSettings = require(Helpers.getMessageSettings)
local Localization = require(ExpChat.Localization)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local getMessageText = require(Helpers.getMessageText)

local Flags = ExpChat.Flags
local getFFlagExpChatUseUpdatedMessageRendered = require(Flags.getFFlagExpChatUseUpdatedMessageRendered)
local shouldReportMessageRender = require(ExpChat.shouldReportMessageRender)

local var1 = require(Flags.getFIntExpChatMessageRenderUserThrottlePermyriad)()
local getFFlagExpChatExcludeFOMORenders = require(Flags.getFFlagExpChatExcludeFOMORenders)
local FFlagExpChatEnableFOMOUpsell = require(Flags.FFlagExpChatEnableFOMOUpsell)
local FFlagExpChatEnableCrossAgeChatActivity = require(Flags.FFlagExpChatEnableCrossAgeChatActivity)
local FFlagExpChatDynamicV2Pool = require(Flags.FFlagExpChatDynamicV2Pool)
local FFlagExpChatKeepV2PoolMounted = require(Flags.FFlagExpChatKeepV2PoolMounted)
local FFlagExpChatFixRateLimitedMessageRemoval = require(ExpChat.Flags.FFlagExpChatFixRateLimitedMessageRemoval)

local FFlagExpChatEvictFloodcheckedFromWindowOrder = require(ExpChat.Flags.FFlagExpChatEvictFloodcheckedFromWindowOrder)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatTopBannerForPresetChatAccess = require(Flags.FFlagExpChatTopBannerForPresetChatAccess)
local FFlagExpChatAddWindowSettingDependency = require(Flags.FFlagExpChatAddWindowSettingDependency)
local FFlagEnableInExpChatRewrite = require(Flags.FFlagEnableInExpChatRewrite)

local FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2 = require(Flags.FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2)
local FIntExpChatVisibleARButtonPadding = require(Flags.FIntExpChatVisibleARButtonPadding)
local FIntExpChatDefaultARButtonPadding = require(Flags.FIntExpChatDefaultARButtonPadding)

local EngineFeatureExpChatGlobalChatEngineTelemetryEnabled = require(Flags.EngineFeatureExpChatGlobalChatEngineTelemetryEnabled)

local TextChatMessageChatActionType = require(ExpChat.TextChatMessageChatActionType)
local RewriteDropdown = require(ExpChat.ChatWindow.UI.TranslatedTextMessageV2.RewriteDropdown)
local GetRewriteDropdownStore = require(ExpChat.Stores.GetRewriteDropdownStore)
local GetChatStatusStore = require(ExpChat.Stores.GetChatStatusStore)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local isChatRegionLocked = require(ExpChat.isChatRegionLocked)
local showChatEnabledUI = require(ExpChat.showChatEnabledUI)
local getIsARButtonVisible = require(ExpChat.getIsARButtonVisible)

local var2 = DataHydration.TrustedConnections.TrustedConnectionsStore.get()

local num1 = game:DefineFastInt("ExpChatSlotBatchSize", 10)

local function createSlot(chatWindowSettings)
    local bodyText, setBodyText = React.createBinding("")
    local prefixText, setPrefixText = React.createBinding("")
    local shouldShowTranslation, setShowTranslation = React.createBinding(false)
    local layoutOrder, setLayoutOrder = React.createBinding(0)
    local visible, setVisible = React.createBinding(false)
    local bodyTextProperties, setBodyTextProperties = React.createBinding(chatWindowSettings)
    local prefixTextProperties, setPrefixTextProperties = React.createBinding(chatWindowSettings)
    local isUserVerified, setIsUserVerified = React.createBinding(false)
    local isTrustedConnection, setIsTrustedConnection = React.createBinding(false)
    local wasRewritten, setWasRewritten = React.createBinding(false)
    local isRewriteWindowOpen, setIsRewriteWindowOpen = React.createBinding(false)
    local message = React.createRef()
    local chatActionType, setChatActionType = React.createBinding(TextChatMessageChatActionType.Unknown)
    local var27, var28

    if FFlagExpChatPresetChatEnabled then
        var27, var28 = React.createBinding(false)
    else
        var27 = nil
        var28 = nil
    end

    local var29, var30

    if isChatWindowEnlargeEnabled() then
        var29, var30 = React.createBinding(nil)
    else
        var29 = nil
        var30 = nil
    end
    message.current = {}

    local tbl1 = {
        bodyText = bodyText,
        setBodyText = setBodyText,
        prefixText = prefixText,
        setPrefixText = setPrefixText,
        shouldShowTranslation = shouldShowTranslation,
        setShowTranslation = setShowTranslation,
        layoutOrder = layoutOrder,
        setLayoutOrder = setLayoutOrder,
        visible = visible,
        setVisible = setVisible,
        bodyTextProperties = bodyTextProperties,
        setBodyTextProperties = setBodyTextProperties,
        prefixTextProperties = prefixTextProperties,
        setPrefixTextProperties = setPrefixTextProperties,
        message = message,
        isUserVerified = isUserVerified,
        setIsUserVerified = setIsUserVerified,
        isTrustedConnection = isTrustedConnection,
        setIsTrustedConnection = setIsTrustedConnection,
        wasRewritten = wasRewritten,
        setWasRewritten = setWasRewritten,
        isRewriteWindowOpen = isRewriteWindowOpen,
        setIsRewriteWindowOpen = setIsRewriteWindowOpen,
        chatActionType = chatActionType,
        setChatActionType = setChatActionType,
        isPresetMessage = 0,
        setIsPresetMessage = 0,
        effects = 0,
        setEffects = 0
    }

    if not FFlagExpChatPresetChatEnabled then
        var27 = nil
    end

    tbl1.isPresetMessage = var27
    if not FFlagExpChatPresetChatEnabled then
        var28 = nil
    end

    tbl1.setIsPresetMessage = var28
    if not isChatWindowEnlargeEnabled() then
        var29 = nil
    end

    tbl1.effects = var29
    if not isChatWindowEnlargeEnabled() then
        var30 = nil
    end

    tbl1.setEffects = var30
    return tbl1
end

local function resolvePrefixText(str1: string, tbl1, arg1)
    if GetFFlagTextChatEnableUniverseChatTabs() and tbl1.isUniverseChat then
        return str1
    end

    local userId = tbl1.userId
    if not userId or tostring(userId) == "0" then
        return str1
    end

    local str2 = tostring(userId)
    local var3 = UserProfileStore.get().fetchNamesByUserIds({ str2 })(arg1)
    local var4 = var3.data and var3.data[1]
    if not (var4 and var4.names) then
        return str1
    end

    local displayName = var4.names.getDisplayName(arg1)
    local inExperienceCombinedName = var4.names.getInExperienceCombinedName(arg1)

    if string.len(displayName) > 0 and string.len(inExperienceCombinedName) > 0 and displayName ~= inExperienceCombinedName then
        str1 = string.gsub(str1, displayName, inExperienceCombinedName)
    end

    return str1
end

local function useV2MessagePool(tbl1)
    local hereLabel = if FFlagExpChatGlobalTabDefault then Localization.useLocalization({ hereLabel = "CoreScripts.TextChat.ChannelTabs.Here" }).hereLabel else nil
    local messagesStore = tbl1.messagesStore
    local enabled = tbl1.enabled
    local chatWindowSettings = tbl1.chatWindowSettings
    local bool1 = if FFlagExpChatKeepV2PoolMounted and enabled then tbl1.visible ~= false else enabled
    local var3 = if EngineFeatureExpChatGlobalChatEngineTelemetryEnabled and not FFlagExpChatUseChannelTabsStore then useStore() else nil
    local chatStatusStore = GetChatStatusStore(false)
    local var4 = SignalsReact.useSignalBinding(chatStatusStore.getChatStatus)
    local var5

    if FFlagExpChatPresetChatEnabled and FFlagExpChatTopBannerForPresetChatAccess then
        local presetChatStore = GetPresetChatStore(false)
        local var6 = SignalsReact.useSignalBinding(presetChatStore.getIsEnabled)
        local var7 = SignalsReact.useSignalBinding(presetChatStore.getAccessLevel)

        var5 = React.joinBindings({ var4, var6, var7 }):map(function(arg1)
            local var8 = arg1[1]
            local var9 = arg1[2]
            local var10 = arg1[3]
            local isArButtonVisible = getIsARButtonVisible(var8, var9, var10)
            return UDim.new(0, if isArButtonVisible then FIntExpChatVisibleARButtonPadding else FIntExpChatDefaultARButtonPadding)
        end)
    else
        var5 = var4:map(function(arg1)
            local var6 = not isChatRegionLocked() and showChatEnabledUI(arg1)
            return UDim.new(0, if var6 then FIntExpChatVisibleARButtonPadding else FIntExpChatDefaultARButtonPadding)
        end)
    end

    local var6

    if FFlagExpChatDynamicV2Pool and enabled then
        var6 = math.min(
            math.ceil(
                #(if tbl1.isChannelBarVisible and tbl1.targetTextChannel then messagesStore.getWindowMessagesInOrderByTabId(false)[tbl1.targetTextChannel.Name] or {} else messagesStore.getWindowMessagesInOrder(false) or {}) / num1
            ) * num1,
            50
        )
    else
        var6 = 50
    end

    local var7, var8 = React.useState(var6)
    local current = if FFlagExpChatDynamicV2Pool then var7 else 50

    local var10 = React.useRef(nil)
    if enabled and not var10.current then
        local tbl2 = ({})
        for i = 1, current do
            tbl2[i] = createSlot(chatWindowSettings)
        end
        var10.current = tbl2
    end

    if FFlagExpChatDynamicV2Pool and enabled and var10.current then
        for i = #var10.current + 1, current do
            var10.current[i] = createSlot(chatWindowSettings)
        end
    end

    local var11 = React.useRef({})
    local var12 = React.useRef(0)

    local var13 = React.useRef(current)
    var13.current = current

    local function createSlotEffects(arg1, componentId: string, messagesStore2, chatWindowSettings2, showTranslationButton: boolean)
        local var14 = messagesStore2.registerMessageComponent(componentId)
        local layoutOrderSignal = messagesStore2.getLayoutOrderSignal(componentId)

        local cleanupMsg = Signals.createEffect(function(arg2)
            local var15 = var14(arg2)
            local rewriteDropdownStore, openMessageId

            if FFlagEnableInExpChatRewrite then
                rewriteDropdownStore = GetRewriteDropdownStore(false)
                openMessageId = rewriteDropdownStore.getOpenMessageId(arg2)
            else
                openMessageId = nil
                rewriteDropdownStore = nil
            end
            if not var15 then
                arg1.setVisible(false)
                arg1.setIsUserVerified(false)
                if FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2 then
                    arg1.setChatActionType(TextChatMessageChatActionType.Unknown)
                end

                return
            end

            local var9 = messagesStore2.getMessage(var15)(arg2)
            if not var9 then
                if FFlagExpChatEvictFloodcheckedFromWindowOrder then
                    arg1.setVisible(false)
                end

                return
            end

            local messageSettings = getMessageSettings(var9, chatWindowSettings2, if FFlagExpChatGlobalTabDefault then hereLabel else nil)

            local bool2 = showTranslationButton

            if bool2 then
                if messageSettings.translation == nil then
                    bool2 = false
                else
                    bool2 = messageSettings.translation ~= ""
                end
            end

            local useTranslation = messageSettings.useTranslation
            local messageText = getMessageText(useTranslation, messageSettings.translation, messageSettings.text)
            local bodyTextProperties = messageSettings.bodyTextProperties
            local prefixTextProperties = messageSettings.prefixTextProperties

            arg1.setBodyText(messageText)
            arg1.setPrefixText((resolvePrefixText(messageSettings.prefixText or "", var9, arg2)))
            arg1.setShowTranslation(bool2)
            arg1.setVisible(not FFlagExpChatFixRateLimitedMessageRemoval or var9.isVisibleInChatWindow)

            arg1.setBodyTextProperties(bodyTextProperties)
            arg1.setPrefixTextProperties(prefixTextProperties)
            arg1.message.current = var9
            if FFlagExpChatPresetChatEnabled then
                arg1.setIsPresetMessage((var9.presetId or "") ~= "")
            end
            if isChatWindowEnlargeEnabled() then
                arg1.setEffects(getMessageEffects(messageText))
            end

            if FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2 then
                arg1.setChatActionType(var9.chatActionType or TextChatMessageChatActionType.Unknown)
            end

            if FFlagEnableInExpChatRewrite then
                arg1.setWasRewritten(messageSettings.wasRewritten or false)
                if openMessageId == var15 then
                    rewriteDropdownStore.setComponentId(componentId)
                    arg1.setIsRewriteWindowOpen(true)
                else
                    arg1.setIsRewriteWindowOpen(false)
                end
            end

            if not FFlagEnableVerifiedBadgeStore then
                arg1.setIsUserVerified(false)
                return
            end

            local var17 = tonumber(var9.userId)
            if var17 then
                local var18 = VerifiedBadgeDisplayStore.get()
                arg1.setIsUserVerified(var18.isBadgeVisible(var17))
                return
            end
            arg1.setIsUserVerified(false)
        end)

        local cleanupLayout = if layoutOrderSignal then Signals.createEffect(function(arg2)
            local var15 = layoutOrderSignal(arg2)
            arg1.setLayoutOrder(var15)
        end) else nil

        local cleanupTelemetry = if getFFlagExpChatUseUpdatedMessageRendered() then Signals.createEffect(function(arg2)
            local var15 = var14(arg2)
            if not var15 then
                return
            end

            local var16 = messagesStore2.getMessage(var15)(false)
            if not var16
                or not var16.textChatMessageInstance
                or not shouldSendHighFrequencyTelemetry(var1)
                or getFFlagExpChatExcludeFOMORenders() and var16.isHiddenMessage
                or not (if FFlagExpChatReportHistoricalRenders then shouldReportMessageRender(var16) else not var16.isHistorical)
            then
                return
            end

            if not EngineFeatureExpChatGlobalChatEngineTelemetryEnabled then
                TextChatService:SendExpChatMessageClientRendered(var16.textChatMessageInstance, "chat_window")
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
                local channelTabs = var3:getState().ChannelTabs
                local selectedTabName = channelTabs and channelTabs.selectedTabName
                if selectedTabName and channelTabs.allChannelTabs[selectedTabName] then
                    selectedChannelTab = channelTabs.allChannelTabs[selectedTabName].TabIndex
                end
            end

            if not EngineFeatureTextChatReportEmojiTelemetryEnabled then
                TextChatService:SendExpChatMessageClientRendered(var16.textChatMessageInstance, "chat_window", selectedChannelTab)
                return
            end

            local specialEffects

            if isChatWindowEnlargeEnabled() then
                local messageSettings = getMessageSettings(var16, chatWindowSettings2, if FFlagExpChatGlobalTabDefault then hereLabel else nil)

                local messageText = getMessageText(messageSettings.useTranslation, messageSettings.translation, messageSettings.text)

                specialEffects = getChatWindowMessageEffects(getMessageEffects(messageText))
            else
                specialEffects = {}
            end
            TextChatService:SendExpChatMessageClientRendered(
                var16.textChatMessageInstance,
                "chat_window",
                selectedChannelTab,
                "",
                specialEffects
            )
        end) else nil

        return {
            cleanupMsg = cleanupMsg,
            cleanupLayout = cleanupLayout,
            cleanupTelemetry = cleanupTelemetry,
            cleanupTc = Signals.createEffect(function(arg2)
                local var15 = var14(arg2)
                if not var15 then
                    return
                end

                local var16 = messagesStore2.getMessage(var15)(false)
                if not var16 then
                    return
                end

                local userId = var16.userId
                local isHiddenMessage = if FFlagExpChatEnableFOMOUpsell or FFlagExpChatEnableCrossAgeChatActivity then var16.isHiddenMessage else nil
                local var17 = userId and userId ~= ""

                local userId2 = Players.LocalPlayer and Players.LocalPlayer.UserId and tostring(Players.LocalPlayer.UserId)

                local var18 = userId2 and userId2 == userId
                local var19 = if var17 and not var18 and not isHiddenMessage then var2.getIsTrustedConnection(userId).data(arg2) else false
                arg1.setIsTrustedConnection(var19)
            end),
            componentId = componentId
        }
    end

    local tbl2 = {}
    if FFlagExpChatAddWindowSettingDependency then
        table.insert(tbl2, chatWindowSettings)
    end
    if FFlagExpChatKeepV2PoolMounted then
        table.insert(tbl2, bool1)
    end

    React.useEffect(function()
        if not bool1 then
            return
        end

        for i = 1, current do
            table.insert(
                var11.current,
                (createSlotEffects(
                    var10.current[i],
                    "msg-component-" .. i,
                    messagesStore,
                    chatWindowSettings,
                    tbl1.showTranslationButton
                ))
            )
        end

        var12.current = current
        local var14

        if GetFFlagTextChatEnableUniverseChatTabs() then
            var14 = tbl1.selectedChannelName
            if messagesStore.getChannelTabsConfigurationEnabled(false) and tbl1.targetTextChannel then
                var14 = tbl1.targetTextChannel.Name
            end
        elseif tbl1.isChannelBarVisible and tbl1.targetTextChannel then
            var14 = tbl1.targetTextChannel.Name
        else
            var14 = nil
        end

        messagesStore.setActiveChannelFilter(var14)
        messagesStore.repopulateMessageComponents()

        return function()
            for _, value in ipairs(var11.current) do
                if value.cleanupMsg then
                    pcall(value.cleanupMsg)
                end
                if value.cleanupLayout then
                    pcall(value.cleanupLayout)
                end
                if value.cleanupTelemetry then
                    pcall(value.cleanupTelemetry)
                end
                if value.cleanupTc then
                    pcall(value.cleanupTc)
                end
                messagesStore.unregisterMessageComponent(value.componentId)
            end
            var11.current = {}
            var12.current = 0
            if FFlagEnableInExpChatRewrite then
                GetRewriteDropdownStore(false).setComponentId(nil)
            end
        end
    end, tbl2)

    if FFlagExpChatDynamicV2Pool and enabled then
        React.useEffect(function()
            if FFlagExpChatKeepV2PoolMounted and not bool1 then
                return
            end

            local current2 = var12.current
            if current <= current2 then
                return
            end

            for i = current2 + 1, current do
                table.insert(
                    var11.current,
                    (createSlotEffects(
                        var10.current[i],
                        "msg-component-" .. i,
                        messagesStore,
                        chatWindowSettings,
                        tbl1.showTranslationButton
                    ))
                )
            end

            var12.current = current
            messagesStore.repopulateMessageComponents()
        end, FFlagExpChatKeepV2PoolMounted and { current, bool1 } or { current })

        React.useEffect(function()
            if FFlagExpChatKeepV2PoolMounted and not bool1 then
                return
            end

            local effect = Signals.createEffect(function(arg1)
                local activeChannelFilter = messagesStore.getActiveChannelFilter(arg1)

                local num2 = math.min(
                    math.ceil(
                        (#(if activeChannelFilter then messagesStore.getWindowMessagesInOrderByTabId(arg1)[activeChannelFilter] or {} else messagesStore.getWindowMessagesInOrder(arg1) or {}) + 2) / num1
                    ) * num1,
                    50
                )

                if var13.current < num2 then
                    var8(num2)
                end
            end)

            return function()
                if effect then
                    pcall(effect)
                end
            end
        end, FFlagExpChatKeepV2PoolMounted and { bool1 } or {})
    end

    local var14 = React.useRef(false)
    local useEffect = React.useEffect
    local function func1()
        if not bool1 then
            var14.current = false
            return
        end

        if not var14.current then
            var14.current = true
            return
        end

        local var15

        if GetFFlagTextChatEnableUniverseChatTabs() then
            var15 = tbl1.selectedChannelName
            if messagesStore.getChannelTabsConfigurationEnabled(false) and tbl1.targetTextChannel then
                var15 = tbl1.targetTextChannel.Name
            end
        elseif tbl1.isChannelBarVisible and tbl1.targetTextChannel then
            var15 = tbl1.targetTextChannel.Name
        else
            var15 = nil
        end

        messagesStore.setActiveChannelFilter(var15)
        messagesStore.repopulateMessageComponents()
    end

    local targetTextChannel = tbl1.targetTextChannel
    local isChannelBarVisible = tbl1.isChannelBarVisible
    local selectedChannelName = if GetFFlagTextChatEnableUniverseChatTabs() then tbl1.selectedChannelName else nil
    useEffect(func1, { bool1, targetTextChannel, isChannelBarVisible, selectedChannelName })

    return {
        children = React.useMemo(function()
            if not enabled then
                return nil
            end

            local result = ({})

            for i = 1, current do
                local str1 = "msg-component-" .. i
                local var15 = var10.current[i]
                result[str1] = React.createElement(TranslatedTextMessageV2, {
                    originalBodyText = var15.bodyText,
                    originalPrefixText = var15.prefixText,
                    shouldShowTranslationToggle = var15.shouldShowTranslation,
                    bodyTextProperties = var15.bodyTextProperties,
                    prefixTextProperties = var15.prefixTextProperties,
                    layoutOrder = var15.layoutOrder,
                    visible = var15.visible,
                    textTransparency = tbl1.textTransparency,
                    isUserVerified = var15.isUserVerified,
                    userId = var15.userId,
                    useTranslation = var15.useTranslation,
                    messageId = var15.messageId,
                    isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
                    chatWindowSettings = chatWindowSettings,
                    onTextMessageLabelButtonActivated = tbl1.onTextMessageLabelButtonActivated,
                    message = var15.message,
                    isTrustedConnection = var15.isTrustedConnection,
                    wasRewritten = if FFlagEnableInExpChatRewrite then var15.wasRewritten else nil,
                    isRewriteWindowOpen = if FFlagEnableInExpChatRewrite then var15.isRewriteWindowOpen else nil,
                    chatActionType = if FFlagEnableInExpChatSummaryOnLuaForTranslatedMessageV2 then var15.chatActionType else nil,
                    chatWindowTransparencyBindable = tbl1.chatWindowTransparencyBindable,
                    arButtonPadding = var5,
                    isPresetMessage = if FFlagExpChatPresetChatEnabled then var15.isPresetMessage else nil,
                    effects = if isChatWindowEnlargeEnabled() then var15.effects else nil
                })
            end

            if FFlagEnableInExpChatRewrite then
                result["$rewrite-dropdown"] = React.createElement(RewriteDropdown, { textTransparency = tbl1.textTransparency, arButtonPadding = var5 })
            end

            result["$layout"] = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })

            return result
        end, FFlagExpChatKeepV2PoolMounted and { enabled, current }
            or {
                enabled,
                tbl1.textTransparency,
                tbl1.isSpatialUIEnabled,
                chatWindowSettings,
                tbl1.onTextMessageLabelButtonActivated,
                current
            })
    }
end
return useV2MessagePool
