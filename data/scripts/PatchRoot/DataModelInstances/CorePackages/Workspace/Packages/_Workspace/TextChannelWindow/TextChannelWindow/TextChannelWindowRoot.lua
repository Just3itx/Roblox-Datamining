-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local Signals = require(scriptParentParent.Signals)
local TextChannelWindowAnalytics = require(script.Parent.TextChannelWindowAnalytics)
local TextChannelWindowPerfTracker = require(scriptParentParent.ChatUIPrimitives).Telemetry.TextChannelWindowPerfTracker
local ChatApp = require(script.Parent.ChatApp)
local _Message = require(script.Parent.Message)
local mountToTargetInstance = require(script.Parent.mountToTargetInstance)
local useTextChannelWindowProps = require(script.Parent.useTextChannelWindowProps)
local useLocalUserInTextChannel = require(script.Parent.useLocalUserInTextChannel)
local useAvailabilitySystemMessage = require(script.Parent.useAvailabilitySystemMessage)
local ChatAvailabilityContext = require(script.Parent.ChatAvailabilityContext)
local MessageWriterContext = require(script.Parent.MessageWriterContext)
local createChannelMessagesStore = require(script.Parent.createChannelMessagesStore)
local TextChatServiceBridge = require(script.Parent.TextChatServiceBridge)
local useWelcomeSystemMessage = require(script.Parent.useWelcomeSystemMessage)
local useSummarySystemMessage = require(script.Parent.useSummarySystemMessage)
local thirdPartySummaryEligibility = require(script.Parent.thirdPartySummaryEligibility)
local ExpChatMessageHistoryExperimentation = require(scriptParentParent.SocialExperiments).ExpChatMessageHistoryExperimentation

local FFlagExpChatTextChannelWindowHistoryReplay = require(script.Parent.Flags.FFlagExpChatTextChannelWindowHistoryReplay)

local TextChatService = game:GetService("TextChatService")
local useLocalUserChatAvailability = ChatAvailabilityContext.useLocalUserChatAvailability

local signal = Signals.createSignal({})

local function getWindowName(textChannelWindow) -- Luacid: Inlined by compiler; 3 call sites recovered
    return textChannelWindow.Name
end

local function getTargetName(textChannelWindow): string? -- Luacid: Inlined by compiler; 2 call sites recovered
    local target = textChannelWindow.Target
    return if target and target:IsA("TextChannel") then target.Name else nil
end

local function TextChannelWindowRoot(tbl1)
    local var1 = useTextChannelWindowProps(tbl1.textChannelWindow)
    local target = var1.target
    local var2 = useLocalUserInTextChannel(target, tbl1.localUserId)

    local channelState = if target == nil then "no-channel" elseif var2 then "member" else "not-member"
    local targetChannel = if channelState == "member" then target else nil
    local var4 = useLocalUserChatAvailability()

    local messagesSignal = React.useMemo(function()
        if targetChannel then
            return tbl1.getChannelMessages(targetChannel)
        end
        return signal
    end, { targetChannel, tbl1.getChannelMessages, signal })

    useAvailabilitySystemMessage(var4, target)
    useWelcomeSystemMessage(targetChannel, tbl1.localUserId)
    useSummarySystemMessage(targetChannel, tbl1.getIsEligibleForSummary)
    local windowName = getWindowName(tbl1.textChannelWindow)

    local var6 = React.useRef(false)
    local loadStartTime = tbl1.loadStartTime
    React.useEffect(function()
        if var6.current then
            return
        end

        var6.current = true
        TextChannelWindowPerfTracker.finishMountTTI(windowName)
        if TextChannelWindowAnalytics.getFFlagExpChatTelemetryEnabled() and loadStartTime then
            local loadingLatency = os.clock() - loadStartTime
            TextChatService:SendExpChatLoadSuccess(loadingLatency, nil, "text_channel_window", windowName)
        end
    end, { windowName, loadStartTime })

    local var7 = React.useRef({})
    React.useEffect(function()
        if not TextChannelWindowAnalytics.getFFlagExpChatTelemetryEnabled()
            or not TextChannelWindowAnalytics.getFFlagExpChatUseUpdatedMessageRendered()
        then
            return
        end

        return (Signals.createEffect(function(arg1)
            for _, value in (messagesSignal(arg1)) do
                local messageId = value.messageId
                if not messageId or var7.current[messageId] then
                    continue
                end

                var7.current[messageId] = true
                if not TextChannelWindowAnalytics.shouldSendMessageRenderedTelemetry() then
                    continue
                end

                local textChatMessageInstance = value.textChatMessageInstance
                if not textChatMessageInstance then
                    continue
                end

                if game:GetEngineFeature("ExpChatGlobalChatEngineTelemetryEnabled") then
                    TextChatService:SendExpChatMessageClientRendered(textChatMessageInstance, "text_channel_window", -1, windowName)
                else
                    TextChatService:SendExpChatMessageClientRendered(textChatMessageInstance, "text_channel_window")
                end
            end
        end))
    end, { messagesSignal, windowName })

    return React.createElement(ChatApp, {
        messagesSignal = messagesSignal,
        localUserId = tbl1.localUserId,
        targetChannel = targetChannel,
        channelState = channelState,
        canLocalUserChat = var4.canChat,
        backgroundColor = var1.backgroundColor,
        fontFace = var1.fontOverride,
        windowName = windowName,
        windowInstance = tbl1.textChannelWindow
    })
end

local _TextChannelWindowErrorBoundary = React.Component:extend("TextChannelWindowErrorBoundary")

function _TextChannelWindowErrorBoundary.init(arg1)
    arg1.state = { hasError = false }
end

function _TextChannelWindowErrorBoundary.getDerivedStateFromError(_)
    return { hasError = true }
end

function _TextChannelWindowErrorBoundary.componentDidCatch(_, _, _) end

function _TextChannelWindowErrorBoundary.render(arg1)
    return if arg1.state.hasError then nil else arg1.props.children
end

local function onScriptError(_: string, _: string, _: Instance) end

local tbl1 = ({})

local tbl2 = ({})
local bool1 = false

return {
    start = function()
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        if not localPlayer then
            return
        end
        local localUserId = tostring(localPlayer.UserId)

        local function canLocalUserChat() -- Luacid: Inlined by compiler; 4 call sites recovered
            return ChatAvailabilityContext.resolve(localPlayer.ChatAvailabilityStatus).canChat
        end

        local channelMessagesStore = if FFlagExpChatTextChannelWindowHistoryReplay then createChannelMessagesStore({
            getHistoryArm = function()
                return ExpChatMessageHistoryExperimentation.getHistoryArm((canLocalUserChat()))
            end,
            logHistoryExposure = function()
                ExpChatMessageHistoryExperimentation.logExposure((canLocalUserChat()))
            end
        }) else createChannelMessagesStore()

        local var2 = thirdPartySummaryEligibility.create(localUserId)

        local function flushWindowStatus(arg1)
            if not TextChannelWindowAnalytics.getFFlagExpChatTelemetryEnabled() then
                return
            end
            local var3 = tbl2[arg1]
            if not var3 then
                return
            end

            local var4 = os.clock() - var3.lastChangeTime
            local timeOpen = var3.openDuration + (if var3.isOpen then var4 else 0)
            local timeClosed = var3.closedDuration + (if var3.isOpen then 0 else var4)
            TextChatService:SendExpChatWindowStatusChange(timeClosed, timeOpen, 0, 0, "text_channel_window", arg1.Name)

            tbl2[arg1] = nil
        end

        local function onRemoved(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
            local var3 = tbl1[arg1]
            if not var3 then
                return
            end

            local target = arg1.Target
            local targetName = if target and target:IsA("TextChannel") then getWindowName(target) else nil

            if targetName then
                TextChannelWindowPerfTracker.cancelForChannel(targetName)
            end
            flushWindowStatus(arg1)
            var3()
            tbl1[arg1] = nil
        end

        local function onAdded(textChannelWindow)
            local function upsertMessage(arg1)
                local target = textChannelWindow.Target
                if target and target:IsA("TextChannel") then
                    channelMessagesStore.upsertMessage(target, arg1)
                end
            end

            local function removeMessage(str2: string)
                local target = textChannelWindow.Target
                if target and target:IsA("TextChannel") then
                    channelMessagesStore.removeMessage(target, str2)
                end
            end

            local loadStartTime = if TextChannelWindowAnalytics.getFFlagExpChatTelemetryEnabled() then os.clock() else nil
            local element = React.createElement(_TextChannelWindowErrorBoundary, nil, {
                inner = React.createElement(
                    MessageWriterContext.Provider,
                    { upsertMessage = upsertMessage, removeMessage = removeMessage },
                    {
                        availability = React.createElement(ChatAvailabilityContext.Provider, {
                            subjectPlayer = localPlayer
                        }, {
                            root = React.createElement(TextChannelWindowRoot, {
                                localUserId = localUserId,
                                textChannelWindow = textChannelWindow,
                                getChannelMessages = channelMessagesStore.getMessagesForChannel,
                                getIsEligibleForSummary = var2.getIsEligible,
                                loadStartTime = loadStartTime
                            })
                        })
                    }
                )
            })
            TextChannelWindowPerfTracker.startMountTTI((getWindowName(textChannelWindow)))

            local var4 = mountToTargetInstance(textChannelWindow, element)
            if var4 then
                tbl1[textChannelWindow] = var4
                local targetName = getTargetName(textChannelWindow)
                TextChannelWindowAnalytics.emit(TextChannelWindowAnalytics.Counters.Mount, {
                    result = "success",
                    has_target = targetName ~= nil,
                    target_text_channel_category = TextChannelWindowAnalytics.getChannelCategory(targetName)
                })
            else
                local targetName = getTargetName(textChannelWindow)
                TextChannelWindowAnalytics.emit(TextChannelWindowAnalytics.Counters.Mount, {
                    result = "failed",
                    has_target = targetName ~= nil,
                    target_text_channel_category = TextChannelWindowAnalytics.getChannelCategory(targetName)
                })
            end

            if TextChannelWindowAnalytics.getFFlagExpChatTelemetryEnabled() then
                local isOpen = textChannelWindow.IsRendering == true
                tbl2[textChannelWindow] = {
                    isOpen = isOpen,
                    lastChangeTime = os.clock(),
                    openDuration = 0,
                    closedDuration = 0
                }

                textChannelWindow:GetPropertyChangedSignal("IsRendering"):Connect(function()
                    local var5 = tbl2[textChannelWindow]
                    if not var5 then
                        return
                    end

                    local lastChangeTime = os.clock()
                    local var6 = lastChangeTime - var5.lastChangeTime
                    local bool2 = textChannelWindow.IsRendering == true
                    tbl2[textChannelWindow] = {
                        isOpen = bool2,
                        lastChangeTime = lastChangeTime,
                        openDuration = var5.openDuration + (if var5.isOpen then var6 else 0),
                        closedDuration = var5.closedDuration + (if var5.isOpen then 0 else var6)
                    }
                end)
            end

            textChannelWindow.AncestryChanged:Connect(function()
                if not textChannelWindow:IsDescendantOf(game) then
                    onRemoved(textChannelWindow)
                end
            end)
        end

        if not bool1 then
            bool1 = true
            game:GetService("ScriptContext").Error:Connect(onScriptError)
        end

        local TextChatService2 = game:GetService("TextChatService")
        if FFlagExpChatTextChannelWindowHistoryReplay then
            TextChatServiceBridge(TextChatService2, localUserId, channelMessagesStore, {
                whenCanChat = function(callback: (...any) -> (...any))
                    if canLocalUserChat() then
                        callback()
                        return
                    end
                    local connection = nil
                    connection = localPlayer:GetPropertyChangedSignal("ChatAvailabilityStatus"):Connect(function()
                        if canLocalUserChat() then
                            connection:Disconnect()
                            callback()
                        end
                    end)
                end
            })
        else
            TextChatServiceBridge(TextChatService2, localUserId, channelMessagesStore)
        end

        for _, textChannelWindow in TextChatService2:GetTextChannelWindows() do
            onAdded(textChannelWindow)
        end
        TextChatService2.TextChannelWindowAdded:Connect(onAdded)
        TextChatService2.TextChannelWindowRemoved:Connect(onRemoved)

        if not TextChannelWindowAnalytics.getFFlagExpChatTelemetryEnabled() then
            return
        end

        Players.PlayerRemoving:Connect(function(player: Player)
            if player ~= localPlayer then
                return
            end

            for value in tbl2 do
                flushWindowStatus(value)
            end
        end)
    end,
    _onScriptError = onScriptError,
    _TextChannelWindowErrorBoundary = _TextChannelWindowErrorBoundary
}
