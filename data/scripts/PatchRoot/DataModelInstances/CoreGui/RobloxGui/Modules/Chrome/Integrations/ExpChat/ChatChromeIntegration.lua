-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local TextChatService = game:GetService("TextChatService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Chat = game:GetService("Chat")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local ChromeIntegrationUtils = require(Chrome.Integrations.ChromeIntegrationUtils)
local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local FocusSelectExpChat = require(Chrome.ChromeShared.Utility.FocusSelectExpChat)
local ViewportUtil = require(Chrome.ChromeShared.Service.ViewportUtil)
local MappedSignal = ChromeUtils.MappedSignal
local GameSettings = UserSettings().GameSettings
local GuiService = game:GetService("GuiService")
local GamepadUtils = require(CorePackages.Workspace.Packages.InputUi).Gamepad.GamepadUtils
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local default = require(script.Parent.ChatIconVisibleSignals).default
local SignalsUtils = require(CorePackages.Workspace.Packages.SignalsUtils)
local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local UnibarStyle = Chrome2.UnibarStyle

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(Chrome.ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider
local SideSheetPlacement = Chrome2.Enums.SideSheetPlacement

if require(RobloxGui.Modules.Flags.FFlagDebugDisableExperienceChatMain) then
    return nil
end

local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)
local focusNavigationStore = ExpChat.Stores.GetFocusNavigationStore(false)
local GetMessagesStore = ExpChat.Stores.GetMessagesStore
local shouldSkipHistoricalMessage = ExpChat.shouldSkipHistoricalMessage
local isHistoricalMessage = ExpChat.isHistoricalMessage
local shouldSuppressUnreadForTabMetadata = ExpChat.shouldSuppressUnreadForTabMetadata

local GetFriendsChatIconUnreadStore = require(CorePackages.Workspace.Packages.FriendsChat.GetFriendsChatIconUnreadStore)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagExpChatWindowSyncUnibar = SharedFlags.FFlagExpChatWindowSyncUnibar
local FFlagExpChatInitializeWindowFromGameSettings = SharedFlags.FFlagExpChatInitializeWindowFromGameSettings
local FFlagRemoveFriendsChatUnibarEntrypoints = SharedFlags.FFlagRemoveFriendsChatUnibarEntrypoints
local FFlagExpChatCanShowFriendsTab = SharedFlags.FFlagExpChatCanShowFriendsTab
local FFlagSideSheetHeaderChatIcon = SharedFlags.FFlagSideSheetHeaderChatIcon
local FFlagExpChatHistoricalMessagesUnibarUnread = SharedFlags.FFlagExpChatHistoricalMessagesUnibarUnread
local FFlagExpChatContinuousListeningChatIconDot = SharedFlags.FFlagExpChatContinuousListeningChatIconDot
local RedDot = if FFlagExpChatContinuousListeningChatIconDot then require(Chrome.Integrations.RedDot) else nil
local GetDictationStateStore = if FFlagExpChatContinuousListeningChatIconDot then ExpChat.Stores.GetDictationStateStore else nil
local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)

local ChatSelector = require(RobloxGui.Modules.ChatSelector)
local getExperienceChatVisualConfig = require(CorePackages.Workspace.Packages.ExpChat).getExperienceChatVisualConfig
local ExpChatShared = require(CorePackages.Workspace.Packages.ExpChatShared)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local shouldRenderTextChannelInDefaultWindow = ExpChatShared.shouldRenderTextChannelInDefaultWindow
local getTextChannelDisplayMode = ExpChatShared.getTextChannelDisplayMode

local bool1 = game:DefineFastFlag("ExpChatSuppressWelcomeMessageUnibarUnread", false)
local bool2 = game:DefineFastFlag("ExpChatUnibarAvailabilityRefactor", false)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local InExperienceUIVRIXP = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).InExperienceUIVRIXP
local ExpChatPerfTracker = ExpChat.ExpChatPerfTracker
local ExpChatJoinIntent = require(CorePackages.Workspace.Packages.ExpChatJoinIntent)
local FStringOpenChatOnJoinNotificationTypes = ExpChatJoinIntent.FStringOpenChatOnJoinNotificationTypes

local num1 = 0
local bool3

if FFlagExpChatInitializeWindowFromGameSettings then
    bool3 = GameSettings.ChatVisible
    ChatSelector:SetVisible(bool3)
else
    bool3 = ChatSelector:GetVisibility()
end
local var1 = nil

local VisibilityStateChanged = ChatSelector.VisibilityStateChanged

local num2 = 0
local bool4 = false

local function readHistoricalWindowMessageCount(bool5: boolean) -- Luacid: Inlined by compiler; 5 call sites recovered
    local getHistoricalWindowMessageCount = GetMessagesStore(bool5).getHistoricalWindowMessageCount
    if getHistoricalWindowMessageCount then
        return (getHistoricalWindowMessageCount(bool5))
    end

    return 0
end

local function getHistoricalUnreadCount(): number -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = readHistoricalWindowMessageCount(false)
    num2 = math.min(num2, var2)
    return var2 - num2
end

local function acknowledgeHistoricalMessages() -- Luacid: Inlined by compiler; 2 call sites recovered
    num2 = readHistoricalWindowMessageCount(false)
end

local function updateUnreadNotification()
    if not var1.notification then
        return
    end

    local var2 = if FFlagExpChatHistoricalMessagesUnibarUnread then getHistoricalUnreadCount() else 0

    local var3 = GetFriendsChatIconUnreadStore(false).getUnreadCountToDisplay(false)
    local var4 = num1 + var3 + var2
    if bool3 or var4 == 0 then
        var1.notification:clear()
        return
    end
    var1.notification:fireCount(var4)
end

local function localUserCanChat() -- Luacid: Inlined by compiler; 3 call sites recovered
    if RunService:IsStudio() then
        return true
    end

    local success, result = pcall(function(): boolean
        return Chat:CanUserChatAsync(Players.LocalPlayer and Players.LocalPlayer.UserId or 0)
    end)
    return success and result
end

if not FFlagExpChatWindowSyncUnibar then
    VisibilityStateChanged:connect(function(arg1)
        if bool2 then
            default.setVisibleViaChatSelector(arg1)
        elseif arg1 then
            var1.availability:pinned()
        end
    end)

    ChatSelector.ChatWindowToggled:connect(function(arg1)
        if bool2 then
            default.setVisibleViaChatSelector(arg1)
        elseif arg1 then
            var1.availability:pinned()
        end
    end)
end

if FFlagExpChatWindowSyncUnibar then
    GameSettings:GetPropertyChangedSignal("ChatVisible"):Connect(function()
        default.setGameSettingsChatVisible(GameSettings.ChatVisible)
    end)
    default.setGameSettingsChatVisible(GameSettings.ChatVisible)
end

local mappedSignal = MappedSignal.new(VisibilityStateChanged, function()
    return bool3
end, function()
    local chatVisible = ChatSelector.GetVisibility()

    if not (bool2 or chatVisible or localUserCanChat()) then
        var1.availability:unavailable()
    end

    if not GuiService.MenuIsOpen then
        GameSettings.ChatVisible = chatVisible
    end

    bool3 = chatVisible
    bool4 = true
    if chatVisible then
        num1 = 0
        if FFlagExpChatHistoricalMessagesUnibarUnread then
            acknowledgeHistoricalMessages()
        end

        GetFriendsChatIconUnreadStore(false).clearDisplayCount()
    end
    updateUnreadNotification()
end)

local function hideAppChat() -- Luacid: Inlined by compiler; 5 call sites recovered
    if not InExperienceAppChatModal:getVisible() then
        return
    end

    InExperienceAppChatModal.default:setVisible(false)
end

local function revealChat() -- Luacid: Inlined by compiler; 3 call sites recovered
    hideAppChat()
    ChatSelector:SetVisible(true)

    if FFlagEnableConsoleExpControls then
        FocusSelectExpChat(var1.id)
    end
end

local function isChatOpenAvailable(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return var1.availability:get() ~= Service.AvailabilitySignal.Unavailable
end

local function isSpatialDirectOpen() -- Luacid: Inlined by compiler; 2 call sites recovered
    return isInExperienceUIVREnabled and isSpatial() and not InExperienceUIVRIXP:isMovePanelToCenter()
end

local function ensureOpenChat(func1: (...any) -> (...any))
    if bool3 then
        hideAppChat()
        return
    end

    if isSpatialDirectOpen() then
        revealChat()
        return
    end

    ChromeIntegrationUtils.dismissRobloxMenuAndRun(function()
        if func1() and isChatOpenAvailable() then
            revealChat()
        end
    end)
end

local tbl1 = {
    id = "chat",
    label = "CoreScripts.TopBar.Chat",
    sideSheetPlacement = if FFlagSideSheetHeaderChatIcon or FFlagRemoveFriendsChatUnibarEntrypoints and FFlagExpChatCanShowFriendsTab then SideSheetPlacement.Unibar else SideSheetPlacement.None,
    activated = 0,
    isActivated = 0,
    selected = 0,
    components = 0
}

function tbl1.activated(_)
    if bool3 then
        ChatSelector:SetVisible(false)
        return
    end
    ExpChatPerfTracker.start(ExpChatPerfTracker.Events.ChatWindowMountTTI, {})

    if isSpatialDirectOpen() then
        ChatSelector:SetVisible(true)
        return
    end
    ChromeIntegrationUtils.dismissRobloxMenuAndRun(function()
        revealChat()
    end)
end

tbl1.isActivated = mappedSignal
tbl1.selected = FFlagEnableConsoleExpControls and function(arg1)
    local connection = nil
    local connection2 = nil
    local connection3 = nil

    connection = Service:selectedItem():connect(function(id)
        assert(id ~= arg1.id, "Expected selectedId to not be self.id on selection")

        connection:disconnect()

        connection2:Disconnect()
        connection3:Disconnect()
    end)

    connection2 = UserInputService.InputChanged:Connect(function(input: InputObject)
        if input.KeyCode == Enum.KeyCode.Thumbstick1
            and GamepadUtils.mapPositionToDirection(Vector2.new(input.Position.X, input.Position.Y)) == Enum.KeyCode.Down
        then
            FocusSelectExpChat(var1.id)
        end
    end)

    connection3 = UserInputService.InputBegan:Connect(function(input: InputObject)
        local keyCode = input.KeyCode
        if keyCode == Enum.KeyCode.DPadDown or keyCode == Enum.KeyCode.Down then
            FocusSelectExpChat(var1.id)
        end
    end)
end or nil

tbl1.components = {
    Icon = function(_)
        local experienceChatVisualConfig = getExperienceChatVisualConfig()
        local icon = CommonIcon(experienceChatVisualConfig.icon.off, experienceChatVisualConfig.icon.on, mappedSignal)
        if not FFlagExpChatContinuousListeningChatIconDot then
            return icon
        end

        local iconSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_SIZE else Constants.ICON_SIZE
        local visible = SignalsReact.useSignalState(GetDictationStateStore(false).getIsListening)

        return React.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(iconSize, iconSize),
                BackgroundTransparency = 1
            },
            {
                Icon = icon,
                ListeningDot = React.createElement(RedDot, { position = UDim2.new(1, -7, 1, -7), visible = visible })
            }
        )
    end
}

var1 = Service:register(tbl1)

var1.chatOpenCapability = { isAvailable = isChatOpenAvailable, ensureOpenChat = ensureOpenChat }

if bool2 then
    SignalsUtils.createDetachedEffect(function(arg1)
        if default.getIsChatIconVisible(arg1) then
            var1.availability:available()
        else
            var1.availability:unavailable()
        end

        if FFlagExpChatWindowSyncUnibar then
            local isChatWindowVisible = default.getIsChatWindowVisible(arg1)

            ExpChat.Events.ChatTopBarButtonActivated(isChatWindowVisible)
        end
    end)

    ChromeUtils.setCoreGuiAvailability(var1, Enum.CoreGuiType.Chat, function(arg1)
        default.setCoreGuiEnabled(arg1)
    end)
end

if FFlagEnableConsoleExpControls then
    SignalsUtils.createDetachedEffect(function(arg1)
        if focusNavigationStore.getChatInputBarFocused(arg1) then
            Service:setShortcutBar(Constants.UNIBAR_SHORTCUTBAR_ID)
            return
        end
        Service:setShortcutBar(nil)
    end)
end

SignalsUtils.createDetachedEffect(function(arg1)
    GetFriendsChatIconUnreadStore(arg1).getUnreadCountToDisplay(arg1)
    updateUnreadNotification()
end)

if FFlagExpChatHistoricalMessagesUnibarUnread then
    SignalsUtils.createDetachedEffect(function(arg1)
        local getHistoricalWindowMessageCount = GetMessagesStore(arg1).getHistoricalWindowMessageCount
        if getHistoricalWindowMessageCount then
            getHistoricalWindowMessageCount(arg1)
        end

        if bool4 and bool3 then
            acknowledgeHistoricalMessages()
        end

        updateUnreadNotification()
    end)
end

local function shouldIgnoreUnreadForMessage(textChatMessage: TextChatMessage) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if FFlagExpChatHistoricalMessagesUnibarUnread and isHistoricalMessage(textChatMessage) then true else textChatMessage ~= nil and shouldSkipHistoricalMessage(textChatMessage)
        or bool1 and shouldSuppressUnreadForTabMetadata(textChatMessage and textChatMessage.Metadata)
end

TextChatService.MessageReceived:Connect(function(textChatMessage: TextChatMessage)
    local textChannelDisplayMode = getTextChannelDisplayMode()
    if shouldRenderTextChannelInDefaultWindow(textChatMessage.TextChannel, textChannelDisplayMode)
        and not (shouldIgnoreUnreadForMessage(textChatMessage) or bool3)
    then
        num1 += 1
        updateUnreadNotification()
    end
end)

if GetFFlagTextChatEnableUniverseChatTabs() then
    TextChatService.UniverseChatMessageReceived:Connect(function(textChatMessage: TextChatMessage)
        if shouldIgnoreUnreadForMessage(textChatMessage) then
            return
        end
        if not bool3 then
            num1 += 1
            updateUnreadNotification()
        end
    end)
end

local num3 = 0
ChatSelector.MessagesChanged:connect(function(num4: number)
    if not bool3 then
        num1 += num4 - num3
        updateUnreadNotification()
    end
    num3 = num4
end)

if not FFlagExpChatWindowSyncUnibar then
    ChatSelector.ChatActiveChanged:connect(function(bool5: boolean)
        if bool2 then
            default.setChatActiveCalledByDeveloper(bool5)
        elseif bool5 and not localUserCanChat() then
            var1.availability:available()
        end
    end)
end

local function setChatVisibilityOnLoad() -- Luacid: Inlined by compiler; 1 call site recovered
    local chatVisible = GameSettings.ChatVisible
    if ViewportUtil.isSmallTouchScreen() then
        chatVisible = false
    end

    bool3 = chatVisible
    ChatSelector:SetVisible(chatVisible)
end

if FStringOpenChatOnJoinNotificationTypes ~= "" then
    require(CorePackages.Workspace.Packages.NotificationsCommon).DeeplinkTapListeners.connect(
        ExpChatJoinIntent.handleDeeplinkTap
    )
end

local function openChatForJoinIntent(bool5: boolean)
    local var2 = ExpChatJoinIntent.read(game.PlaceId)
    if var2.result == "none" then
        return
    end

    local result = var2.result
    if var2.result == "accepted" then
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
        result = not bool5 and "cannotChat"
            or (if bool3 then "alreadyOpen" elseif isChatOpenAvailable() then if chatWindowConfiguration then if chatWindowConfiguration.Enabled then "opened" else "chatWindowDisabled" else "opened" else "chatUnavailable")
    end

    if result == "opened" then
        GameSettings.ChatVisible = true
        bool3 = true
        ChatSelector:SetVisible(true)
    end

    local intent = var2.intent
    ExpChatShared.Analytics.FireClientAnalyticsWithEventName("joinIntentChatOpen", {
        result = result,
        notificationType = if intent then intent.notificationType else "",
        notificationId = intent and intent.notificationId or "",
        chatTarget = intent and intent.chatTarget or "",
        source = if intent then intent.source else ""
    })
end

coroutine.wrap(function()
    local localPlayer = Players.LocalPlayer
    while not localPlayer do
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        localPlayer = Players.LocalPlayer
    end

    local var2 = localUserCanChat()

    if bool2 then
        default.setLocalUserChat(var2)
        if var2 then
            setChatVisibilityOnLoad()
        end
    elseif var2 and var1.availability then
        ChromeUtils.setCoreGuiAvailability(var1, Enum.CoreGuiType.Chat, function(arg1)
            if arg1 then
                var1.availability:pinned()
                return
            end
            var1.availability:unavailable()
        end)

        local chatVisible = GameSettings.ChatVisible
        if ViewportUtil.isSmallTouchScreen() then
            chatVisible = false
        end

        bool3 = chatVisible
        ChatSelector:SetVisible(chatVisible)
    end

    if FStringOpenChatOnJoinNotificationTypes ~= "" then
        openChatForJoinIntent(var2)
    end
end)()

function _simulateChat()
    while true do
        task.wait(math.random(1, 15))
        if not bool3 then
            num1 += 1
            updateUnreadNotification()
        end
    end
end

return var1
