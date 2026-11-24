-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local FocusUtils = require(ExpChatParent.Chrome).FocusUtils
local Otter = require(ExpChatParent.Otter)
local ReactFocusNavigation = require(ExpChatParent.ReactFocusNavigation)
local Roact = require(ExpChatParent.Roact)
local Signals = require(ExpChatParent.Signals)
local SocialUpsell = require(ExpChatParent.SocialUpsell)
local createEffect = Signals.createEffect
local SharedFlags = require(ExpChatParent.SharedFlags)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local UIBlox = require(ExpChatParent.UIBlox)
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local CursorProvider = UIBlox.App.SelectionCursor.CursorProvider
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider

local Foundation = require(ExpChatParent.Foundation)
local ChatInput = require(ExpChat.ChatInput)
local ChatWindow = require(ExpChat.ChatWindow)
local ChannelBar = require(ExpChat.ChannelBar)
local Config = require(ExpChat.Config)
local EnableChatButton = require(ExpChat.EnableChatButton)
local FriendsChatMain = require(ExpChatParent.FriendsChat.FriendsChatMain)
local ChatPlatformProvider = require(ExpChat.ChatPlatform.ChatPlatformProvider)
local FriendsChatDependencyBridge = require(ExpChat.FriendsChatDependencyBridge)
local GetFriendsChatRealtimeStore = require(ExpChatParent.FriendsChat.GetFriendsChatRealtimeStore)
local PresetChatTray = require(ExpChat.PresetChat.PresetChatTray)
local PresetChatButton = require(ExpChat.PresetChat.PresetChatButton)
local PresetChatFlyOut = require(ExpChat.PresetChat.PresetChatFlyOut)
local PresetChatGate = require(ExpChat.PresetChat.PresetChatGate)
local Constants = require(ExpChat.PresetChat.Constants)

local GetChatConfigurationStore = require(ExpChat.Stores.GetChatConfigurationStore)
local GetChatStatusStore = require(ExpChat.Stores.GetChatStatusStore)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local GetChatLayoutStore = require(ExpChat.Stores.GetChatLayoutStore)
local Timer = require(ExpChat.Timer)
local SpatialUI = require(ExpChat.SpatialUI)
local ClientSettingsUtility = require(ExpChat.ClientSettings.ClientSettingsUtility)
local canPlatformEnableChat = require(ExpChat.canPlatformEnableChat)
local isChatRegionLocked = require(ExpChat.isChatRegionLocked)
local showChatEnabledUI = require(ExpChat.showChatEnabledUI)

local AppChat = ExpChatParent.AppChat
local GetConversationMessageStore = require(AppChat.GetConversationMessageStore)
local GetConversationMessageListStore = require(AppChat.GetConversationMessageListStore)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)

local getFFlagExpChatConditionallyMountAppLayout = require(ExpChat.Flags.getFFlagExpChatConditionallyMountAppLayout)
local FFlagExpChatEnableV2ChatWindow = require(ExpChat.Flags.FFlagExpChatEnableV2ChatWindow)
local FFlagExpChatKeepV2PoolMounted = require(ExpChat.Flags.FFlagExpChatKeepV2PoolMounted)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatCenterMobilePresetButton = require(ExpChat.Flags.FFlagExpChatCenterMobilePresetButton)
local FFlagExpChatPresetFullWidthButtonFixes = require(ExpChat.Flags.FFlagExpChatPresetFullWidthButtonFixes)
local FFlagExpChatPresetChatSendEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatSendEnabled
local FFlagExpChatUniverseChatPresetEnabled = require(ExpChat.Flags.FFlagExpChatUniverseChatPresetEnabled)
local FFlagExpChatPresetButtonGlobalTabFix = require(ExpChat.Flags.FFlagExpChatPresetButtonGlobalTabFix)
local FFlagExpChatPresetChatGamepadEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatGamepadEnabled)
local FFlagLuaSupportMicroGamepadPreferredInput = SharedFlags.FFlagLuaSupportMicroGamepadPreferredInput
local FFlagDebugForceEnableChatButtonOn = require(ExpChat.Flags.FFlagDebugForceEnableChatButtonOn)
local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore
local FFlagExpChatTabShortcutNav = SharedFlags.FFlagExpChatTabShortcutNav
local FFlagExpChatGenericChatFocus = require(ExpChat.Flags.FFlagExpChatGenericChatFocus)
local FocusNavigationExperiment = require(ExpChat.ShortcutNav.FocusNavigationExperiment)
local InputType = require(ExpChatParent.InputType)
local FFlagExpChatNewInputBar = require(ExpChat.Flags.FFlagExpChatNewInputBar)
local bool1 = game:DefineFastFlag("ExpChatPresetButtonOldInputBarV2", false)
local bool2 = game:DefineFastFlag("ExpChatPresetFixChatHotkey", false)
local bool3 = game:DefineFastFlag("ExpChatFixTopPaddingColor", false)
local bool4 = game:DefineFastFlag("ExpChatPresetChatFixesEnabled", false)
local FFlagDebugFriendsChat = require(ExpChatParent.FriendsChat.FFlagDebugFriendsChat)
local FFlagDebugExpChatPerf = require(ExpChat.Flags.FFlagDebugExpChatPerf)
local FStringDebugFriendsChatConversationId = require(ExpChatParent.FriendsChat.FStringDebugFriendsChatConversationId)

local manuallyInvokeAmpUpsell = SocialUpsell.Utils.manuallyInvokeAmpUpsell
local isInExperienceUIVREnabled = require(ExpChatParent.SharedExperimentDefinition).isInExperienceUIVREnabled
local getFFlagExpChatTriggerWindowStatusEvent = require(ExpChat.Flags.getFFlagExpChatTriggerWindowStatusEvent)
local FFlagExpChatWindowStatusEventFixes = require(ExpChat.Flags.FFlagExpChatWindowStatusEventFixes)
local FFlagExpChatClearStaleSelectionOnClose = require(ExpChat.Flags.FFlagExpChatClearStaleSelectionOnClose)

local var1 = isInExperienceUIVREnabled
    and {
        DEFAULT = UDim2.fromScale(0.95, 0.94),
        WITH_CHANNEL_BAR = UDim2.fromScale(0.95, 0.78),
        WITH_CHATINPUT_BAR = UDim2.fromScale(0.95, 0.76),
        WITH_CHANNEL_CHATINPUT_BAR = UDim2.fromScale(0.95, 0.6098)
    }
    or nil

local GetFocusNavigationStore = require(ExpChat.Stores.GetFocusNavigationStore)
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local GetChatWindowStatusStore = require(ExpChat.Stores.GetChatWindowStatusStore)

local function PresetChatInputRow(arg1)
    local var2 = if arg1.showEnableChatButton then Config.PresetChat.ButtonWidth else 47
    local var3 = if arg1.showEnableChatButton then Foundation.Enums.InputSize.Small else Foundation.Enums.InputSize.Medium
    local xOffset = if arg1.showEnableChatButton then 5 else 3

    local xOffset2 = if FFlagExpChatPresetButtonGlobalTabFix and arg1.isPresetButtonHidden then 0 else var2

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 3,
        Size = UDim2.fromScale(1, 0),
        Visible = arg1.isChatInputBarVisible or arg1.showEnableChatButton,
        ZIndex = 2
    }
    local tbl2 = {
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 0)
        }),
        PresetButton = 0,
        FillArea = 0
    }
    local createElement2 = Roact.createElement
    local str2 = "Frame"

    local tbl3 = {
        BackgroundColor3 = arg1.backgroundColor3,
        BackgroundTransparency = arg1.transparencyValue:map(function(num1: number)
            return arg1.backgroundTransparency + num1 * (1 - arg1.backgroundTransparency)
        end),
        BorderSizePixel = 0,
        ClipsDescendants = false,
        LayoutOrder = 1,
        Size = UDim2.new(0, xOffset2, 1, 0),
        Visible = if bool4 then arg1.isChatWindowVisible or arg1.isChatInputBarVisible else nil
    }

    local tbl4 = { ButtonOrFlyOut = 0 }
    local createElement3 = Roact.createElement
    local str3 = "CanvasGroup"
    local tbl5 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, xOffset, 0.5, if bool4 then 0 else -1),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        GroupTransparency = arg1.transparencyValue
    }
    local tbl6 = { Content = 0 }
    local element

    if FFlagExpChatPresetButtonGlobalTabFix and arg1.isPresetButtonHidden then
        element = nil
    elseif arg1.presetLayoutMode == Constants.LayoutMode.Tray then
        element = Roact.createElement(PresetChatButton, {
            size = var3,
            isCircular = false,
            addTopPadding = if FFlagExpChatCenterMobilePresetButton then arg1.isChatWindowVisible else nil
        })
    else
        element = Roact.createElement(PresetChatFlyOut, {
            addTopPadding = arg1.isChatWindowVisible,
            textChannel = arg1.targetTextChannel,
            buttonSize = var3,
            buttonIsCircular = false,
            onSendChat = arg1.onSendChat,
            onSendGlobalChat = arg1.onSendGlobalChat
        })
    end

    tbl6.Content = element
    tbl4.ButtonOrFlyOut = createElement3(str3, tbl5, tbl6)
    tbl2.PresetButton = createElement2(str2, tbl3, tbl4)

    local createElement4 = Roact.createElement
    local str4 = "Frame"
    local tbl7 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        Size = UDim2.new(1, -xOffset2, 0, 0)
    }
    local tbl8 = { EnableChatButton = 0, InputBar = 0 }
    local element2

    if arg1.showEnableChatButton then
        element2 = Roact.createElement(EnableChatButton, {
            chatWindowSettings = arg1.chatWindowSettings,
            transparencyValue = arg1.transparencyValue,
            addTopPadding = arg1.isChatWindowVisible,
            onHovered = arg1.onHovered,
            onUnhovered = arg1.onUnhovered,
            isSpatialUIEnabled = arg1.isSpatialUIEnabled,
            visible = arg1.isChatWindowVisible or arg1.isChatInputBarVisible,
            onActivated = arg1.onEnableChatActivated
        })
    else
        element2 = nil
    end

    tbl8.EnableChatButton = element2
    local element3

    if bool2 or arg1.isChatInputBarVisible then
        element3 = Roact.createElement(ChatInput, {
            addTopPadding = arg1.isChatWindowVisible,
            onSendChat = arg1.onSendChat,
            onSendGlobalChat = arg1.onSendGlobalChat,
            transparencyValue = arg1.transparencyValue,
            canLocalUserChat = arg1.canLocalUserChat,
            resetTargetChannel = arg1.resetTargetChannel,
            visible = arg1.isChatInputBarVisible,
            onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
            onAbsolutePositionChanged = arg1.onAbsolutePositionChanged,
            chatWindowSettings = arg1.chatWindowSettings,
            isChannelBarVisible = arg1.isChannelBarVisible,
            isSpatialUIEnabled = arg1.isSpatialUIEnabled
        })
    else
        element3 = nil
    end

    tbl8.InputBar = element3
    tbl2.FillArea = createElement4(str4, tbl7, tbl8)
    return createElement(str1, tbl1, tbl2)
end

local var2 = Roact.PureComponent:extend("AppLayout")
var2.defaultProps = {
    addTopPadding = true,
    canLocalUserChat = false,
    isChatInputBarVisible = true,
    isChatWindowVisible = true,
    isChannelBarVisible = false,
    renderingFriends = false,
    isExperienceChatRendered = true,
    LayoutOrder = 1,
    mutedUserIds = nil,
    onSendChat = nil,
    onSendGlobalChat = nil,
    textTimer = Timer.new(Config.ChatWindowTextFadeOutTime),
    timer = Timer.new(Config.ChatWindowBackgroundFadeOutTime),
    isSpatialUIEnabled = false,
    canPlatformEnableChat = canPlatformEnableChat
}

local tbl1 = { frequency = 1.25, dampingRatio = 1 }

function var2.init(arg1)
    arg1.state = {}

    arg1.debugContainerRef = if FFlagDebugFriendsChat then Roact.createRef() else nil

    function arg1.setChatContainerRef(current)
        if FFlagDebugFriendsChat and arg1.debugContainerRef then
            arg1.debugContainerRef.current = current
        end
        if FFlagExpChatTabShortcutNav or FFlagExpChatGenericChatFocus then
            GetFocusNavigationStore(false).setChatRoot(current)
        end
    end

    if FFlagDebugFriendsChat or FFlagDebugExpChatPerf then
        arg1.debugInjectionThread = nil
        arg1.debugKeybindConnection = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
            if gameProcessedEvent then
                return
            end

            if input.KeyCode == Enum.KeyCode.K and input:IsModifierKeyDown(Enum.ModifierKey.Ctrl) then
                arg1:debugInjectFakeMessages()
            elseif FFlagDebugFriendsChat and input.KeyCode == Enum.KeyCode.BackSlash then
                arg1:debugSeedFocusNavigation()
            end
        end)
    end

    local transparencyValue, updateBackgroundTransparency = Roact.createBinding(0)
    arg1.transparencyValue = transparencyValue
    arg1.updateBackgroundTransparency = updateBackgroundTransparency
    arg1.backgroundTransparencyMotor = Otter.createSingleMotor(0)
    arg1.backgroundTransparencyMotor:onStep(arg1.updateBackgroundTransparency)

    local textTransparencyValue, updateTextTransparencyValue = Roact.createBinding(0)
    arg1.textTransparencyValue = textTransparencyValue
    arg1.updateTextTransparencyValue = updateTextTransparencyValue
    arg1.textTransparencyMotor = Otter.createSingleMotor(0)
    arg1.textTransparencyMotor:onStep(arg1.updateTextTransparencyValue)

    local transparencyStore = GetTransparencyStore(false)
    arg1.ChatWindowStatusStore = if getFFlagExpChatTriggerWindowStatusEvent() then GetChatWindowStatusStore(false) else nil

    if FFlagExpChatWindowStatusEventFixes then
        local currentChatWindowState = arg1.ChatWindowStatusStore.getCurrentChatWindowState(false)
        arg1.lastTrackedChatVisible = if currentChatWindowState == "unknown" then nil else currentChatWindowState ~= "closed"
    elseif getFFlagExpChatTriggerWindowStatusEvent() then
        arg1.localPlayerLeavingConnection = Players.PlayerRemoving:Connect(function(player: Player)
            if player == Players.LocalPlayer then
                arg1.ChatWindowStatusStore.setPreviousChatWindowState(arg1.ChatWindowStatusStore.getCurrentChatWindowState(false))

                local durationUpdates = arg1.ChatWindowStatusStore.getDurationUpdates(false)
                TextChatService:SendExpChatWindowStatusChange(
                    durationUpdates.closedDuration,
                    durationUpdates.openDuration,
                    durationUpdates.backgroundIdleDuration,
                    durationUpdates.textIdleDuration
                )
            end
        end)
    end

    if FFlagExpChatUseChatConfigStore then
        arg1.ChatConfigurationStore = GetChatConfigurationStore(false)
    end

    function arg1.isChatSurfaceVisibleForStatusTracking()
        return arg1.props.isChatWindowVisible or arg1.props.isChatInputBarVisible
    end

    function arg1.stampOpenForStatusTrackingIfNeeded()
        if FFlagExpChatWindowStatusEventFixes
            and arg1:isChatSurfaceVisibleForStatusTracking()
            and arg1.ChatWindowStatusStore.getCurrentChatWindowState(false) ~= "open"
        then
            arg1.ChatWindowStatusStore.setOpenTimerStarted(os.clock())
        end
    end

    function arg1.stampBackgroundIdleForStatusTrackingIfNeeded()
        if FFlagExpChatWindowStatusEventFixes
            and arg1:isChatSurfaceVisibleForStatusTracking()
            and arg1.ChatWindowStatusStore.getCurrentChatWindowState(false) == "textIdle"
        then
            arg1.ChatWindowStatusStore.setBackgroundTimerStarted(os.clock())
        end
    end

    function arg1.resetBackgroundTransparency()
        local isFocused = transparencyStore.getIsFocused(false)

        arg1.backgroundTransparencyMotor:setGoal(Otter.instant(0))
        arg1.props.timer:stop()
        arg1:stampOpenForStatusTrackingIfNeeded()
        if isFocused ~= false or arg1.props.isSpatialUIEnabled ~= false then
            return
        end

        if FFlagExpChatWindowStatusEventFixes and not arg1:isChatSurfaceVisibleForStatusTracking() then
            return
        end
        arg1.props.timer:start():andThen(function()
            if FFlagExpChatWindowStatusEventFixes then
                if arg1:isChatSurfaceVisibleForStatusTracking() then
                    arg1.ChatWindowStatusStore.setBackgroundTimerStarted(os.clock())
                end
            elseif getFFlagExpChatTriggerWindowStatusEvent() then
                arg1.ChatWindowStatusStore.setBackgroundTimerStarted(os.clock())
            end
            arg1.backgroundTransparencyMotor:setGoal(Otter.spring(1, tbl1))
        end)
    end

    function arg1.resetTextTransparency()
        local isFocused = transparencyStore.getIsFocused(false)

        arg1.textTransparencyMotor:setGoal(Otter.instant(0))
        arg1.props.textTimer:stop()
        arg1:stampBackgroundIdleForStatusTrackingIfNeeded()
        if isFocused ~= false then
            return
        end

        if FFlagExpChatWindowStatusEventFixes and not arg1:isChatSurfaceVisibleForStatusTracking() then
            return
        end
        arg1.props.textTimer:start():andThen(function()
            if FFlagExpChatWindowStatusEventFixes then
                if arg1:isChatSurfaceVisibleForStatusTracking() then
                    arg1.ChatWindowStatusStore.setTextTimerStarted(os.clock())
                end
            elseif getFFlagExpChatTriggerWindowStatusEvent() then
                arg1.ChatWindowStatusStore.setTextTimerStarted(os.clock())
            end
            arg1.textTransparencyMotor:setGoal(Otter.spring(1, tbl1))
        end)
    end

    arg1.disposeBackgroundEffect = createEffect(function(arg2)
        transparencyStore.getLastActivity(arg2)
        arg1.resetBackgroundTransparency()
        arg1.resetTextTransparency()
    end)

    arg1.disposeTextEffect = createEffect(function(arg2)
        transparencyStore.getLastMessageActivity(arg2)
        arg1.resetTextTransparency()
    end)

    arg1.disposeChatStatusEffect = createEffect(function(arg2)
        local chatStatus = GetChatStatusStore(arg2).getChatStatus(arg2)

        arg1:setState({ chatStatus = chatStatus })
    end)

    if FFlagExpChatPresetChatEnabled then
        arg1.disposePresetFlyOutAvailableEffect = createEffect(function(arg2)
            local presetChatStore = GetPresetChatStore(arg2)
            local isEnabled = presetChatStore.getIsEnabled(arg2)
            local accessLevel = presetChatStore.getAccessLevel(arg2)
            local layoutModeOverride = presetChatStore.getLayoutModeOverride(arg2)

            if layoutModeOverride ~= Constants.LayoutMode.Tray and layoutModeOverride ~= Constants.LayoutMode.FlyOut then
                if FFlagExpChatPresetChatGamepadEnabled
                    and (UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
                        or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad)
                then
                    layoutModeOverride = Constants.LayoutMode.FlyOut
                elseif UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
                    layoutModeOverride = Constants.LayoutMode.Tray
                else
                    layoutModeOverride = Constants.LayoutMode.FlyOut
                end
            end
            local var7 = arg1
            local tbl2 = {
                isPresetFlyOutAvailable = 0,
                isPresetChatAvailable = 0,
                presetLayoutMode = 0
            }
            local var8 = isEnabled and FFlagExpChatPresetChatSendEnabled

            if var8 then
                if accessLevel == Constants.AccessLevel.Enabled then
                    var8 = arg1.props.targetTextChannel ~= nil or FFlagExpChatUniverseChatPresetEnabled
                else
                    var8 = false
                end
            end

            tbl2.isPresetFlyOutAvailable = var8

            tbl2.isPresetChatAvailable = if FFlagExpChatPresetButtonGlobalTabFix then isEnabled and FFlagExpChatPresetChatSendEnabled and accessLevel == Constants.AccessLevel.Enabled else nil

            tbl2.presetLayoutMode = layoutModeOverride
            var7:setState(tbl2)
        end)
    end

    function arg1.onAbsolutePositionChanged(arg2, arg3)
        arg3.AbsolutePositionWrite = arg2.AbsolutePosition
    end

    function arg1.onAbsoluteSizeChanged(arg2, arg3)
        arg3.AbsoluteSizeWrite = arg2.AbsoluteSize
    end

    function arg1.onChatFrameLayoutChanged(arg2)
        if FFlagExpChatPresetChatEnabled then
            local var7 = arg2.AbsolutePosition.Y + arg2.AbsoluteSize.Y
            GetPresetChatStore(false).setChatWindowBottomY(var7)
        end
        GetChatLayoutStore(false).setChatWindowWidth(arg2.AbsoluteSize.X)
    end
    arg1.focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

    arg1.topBorderRef = Roact.createRef()
    function arg1.onContainerSelectionChanged(arg2, _, arg3, current)
        if current == nil or not current:IsDescendantOf(arg2) then
            GetFocusNavigationStore(false).unfocusChatInputBar()
            transparencyStore.clearWindowFocusInput()
            return
        end
        transparencyStore.setWindowFocusInput()
        if current ~= arg1.topBorderRef.current then
            return
        end
        if FFlagExpChatGenericChatFocus
            and InputType.getInputGroup(UserInputService:GetLastInputType()) ~= InputType.InputTypeConstants.Gamepad
        then
            local guiService = GuiService

            if arg3 == nil or not arg3:IsDescendantOf(arg2) then
                arg3 = nil
            end

            guiService.SelectedCoreObject = arg3

            return
        end

        FocusUtils.FocusOnChrome(function()
            GetFocusNavigationStore(false).unfocusChatInputBar()
        end, "chat")
    end
end

function var2.syncChatWindowVisibilityForStatusTracking(arg1)
    if not FFlagExpChatWindowStatusEventFixes then
        return
    end

    local lastTrackedChatVisible = arg1:isChatSurfaceVisibleForStatusTracking()
    if arg1.lastTrackedChatVisible == lastTrackedChatVisible then
        return
    end

    arg1.lastTrackedChatVisible = lastTrackedChatVisible
    if lastTrackedChatVisible then
        arg1.ChatWindowStatusStore.setOpenTimerStarted(os.clock())
        return
    end
    arg1.ChatWindowStatusStore.setClosedTimerStarted(os.clock())
    arg1.props.timer:stop()
    arg1.props.textTimer:stop()
end

function var2.didMount(arg1)
    if FFlagExpChatWindowStatusEventFixes then
        arg1:syncChatWindowVisibilityForStatusTracking()

        if arg1:isChatSurfaceVisibleForStatusTracking() then
            arg1.props.timer:start():andThen(function()
                if arg1:isChatSurfaceVisibleForStatusTracking() then
                    arg1.ChatWindowStatusStore.setBackgroundTimerStarted(os.clock())
                end
                arg1.backgroundTransparencyMotor:setGoal(Otter.spring(1, tbl1))
            end)

            arg1.props.textTimer:start():andThen(function()
                if arg1:isChatSurfaceVisibleForStatusTracking() then
                    arg1.ChatWindowStatusStore.setTextTimerStarted(os.clock())
                end
                arg1.textTransparencyMotor:setGoal(Otter.spring(1, tbl1))
            end)
        end
    else
        arg1.props.timer:start():andThen(function()
            if getFFlagExpChatTriggerWindowStatusEvent() then
                arg1.ChatWindowStatusStore.setBackgroundTimerStarted(os.clock())
            end
            arg1.backgroundTransparencyMotor:setGoal(Otter.spring(1, tbl1))
        end)

        arg1.props.textTimer:start():andThen(function()
            if getFFlagExpChatTriggerWindowStatusEvent() then
                arg1.ChatWindowStatusStore.setTextTimerStarted(os.clock())
            end
            arg1.textTransparencyMotor:setGoal(Otter.spring(1, tbl1))
        end)
    end
end

function var2.didUpdate(arg1, arg2)
    if FFlagExpChatClearStaleSelectionOnClose
        and (arg2.isChatWindowVisible and not arg1.props.isChatWindowVisible
            or arg2.renderingFriends and not arg1.props.renderingFriends)
    then
        local selectedCoreObject = GuiService.SelectedCoreObject
        if selectedCoreObject == nil or not selectedCoreObject:IsDescendantOf(game) then
            if selectedCoreObject ~= nil then
                GuiService.SelectedCoreObject = nil
            end
            GetTransparencyStore(false).clearWindowFocusInput()
        end
    end

    if not FFlagExpChatWindowStatusEventFixes then
        return
    end

    local var3 = arg2.isChatWindowVisible or arg2.isChatInputBarVisible
    local var4 = arg1:isChatSurfaceVisibleForStatusTracking()
    if var3 == var4 then
        return
    end

    arg1:syncChatWindowVisibilityForStatusTracking()

    if var4 then
        arg1.resetBackgroundTransparency()
        arg1.resetTextTransparency()
    end
end

function var2.render(arg1)
    if FocusNavigationExperiment.isBackupExposureLoggingEnabled and arg1.isChatSurfaceVisibleForStatusTracking() then
        FocusNavigationExperiment.logExposure()
    end

    if getFFlagExpChatTriggerWindowStatusEvent() and not FFlagExpChatWindowStatusEventFixes then
        if arg1.props.isChatWindowVisible or arg1.props.isChatInputBarVisible then
            arg1.ChatWindowStatusStore.setOpenTimerStarted(os.clock())
        else
            arg1.ChatWindowStatusStore.setClosedTimerStarted(os.clock())
        end
    end

    local chatWindowSettings = if FFlagExpChatUseChatConfigStore and arg1.ChatConfigurationStore then arg1.ChatConfigurationStore.getChatWindowSettings(false) else arg1.props.chatWindowSettings
    local backgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(chatWindowSettings, arg1.props.clientSettings)
    local backgroundColor = ClientSettingsUtility.getBackgroundColor(chatWindowSettings, arg1.props.clientSettings)
    local var3 = nil

    local renderingFriends = arg1.props.renderingFriends
    local isExperienceChatRendered = arg1.props.isExperienceChatRendered

    local isChatInputBarVisible = arg1.props.isChatInputBarVisible
    local chatStatus = arg1.state.chatStatus
    local var4 = isChatInputBarVisible and showChatEnabledUI(chatStatus)

    if isInExperienceUIVREnabled then
        if arg1.props.isSpatialUIEnabled then
            local isChannelBarVisible = getFFlagExpChatConditionallyMountAppLayout() and arg1.props.isChannelBarVisible
            if isChannelBarVisible and var4 then
                var3 = var1.WITH_CHANNEL_CHATINPUT_BAR
            elseif isChannelBarVisible and not var4 then
                var3 = var1.WITH_CHANNEL_BAR
            elseif not isChannelBarVisible and var4 then
                var3 = var1.WITH_CHATINPUT_BAR
            else
                var3 = var1.DEFAULT
            end
        else
            var3 = UDim2.fromScale(
                Config.ChatWindowSize.X.Scale * chatWindowSettings.WidthScale,
                Config.ChatWindowSize.Y.Scale * chatWindowSettings.HeightScale
            )
        end
    end

    local showEnableChatButton = FFlagDebugForceEnableChatButtonOn
        or not isChatRegionLocked() and arg1.props.canPlatformEnableChat() and chatStatus == "AgeVerificationRequired"

    local bool5 = bool1

    if bool5 then
        bool5 = FFlagExpChatPresetChatEnabled
        bool5 = bool5 and arg1.state.isPresetFlyOutAvailable
    end
    local isPresetFlyOutAvailable = FFlagExpChatPresetChatEnabled and arg1.state.isPresetFlyOutAvailable
    if isPresetFlyOutAvailable then
        isPresetFlyOutAvailable = not showEnableChatButton
        isPresetFlyOutAvailable = isPresetFlyOutAvailable and not var4
    end

    local var6 = if FFlagExpChatPresetButtonGlobalTabFix then arg1.state.isPresetChatAvailable == true
        and (arg1.props.targetTextChannel ~= nil or FFlagExpChatUniverseChatPresetEnabled) else nil

    if FFlagExpChatPresetButtonGlobalTabFix then
        bool5 = bool1 and FFlagExpChatPresetChatEnabled and arg1.state.isPresetChatAvailable == true
        isPresetFlyOutAvailable = FFlagExpChatPresetChatEnabled and var6 and not (showEnableChatButton or var4)
    end

    local function func1(selectionImageObject)
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl2 = {
            AnchorPoint = arg1.props.chatLayoutAlignment.AnchorPoint,
            BackgroundColor3 = Color3.new(0, 0, 0),
            BackgroundTransparency = 1,
            Position = arg1.props.chatLayoutAlignment.Position,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionGroup = true,
            Size = if isInExperienceUIVREnabled then var3 elseif arg1.props.isSpatialUIEnabled then UDim2.fromScale(0.95, 0.68) else UDim2.fromScale(
                Config.ChatWindowSize.X.Scale * chatWindowSettings.WidthScale,
                Config.ChatWindowSize.Y.Scale * chatWindowSettings.HeightScale
            ),
            [Roact.Change.AbsoluteSize] = arg1.onChatFrameLayoutChanged,
            [Roact.Change.AbsolutePosition] = if FFlagExpChatPresetChatEnabled then arg1.onChatFrameLayoutChanged else nil,
            [Roact.Event.SelectionChanged] = arg1.onContainerSelectionChanged,
            [Roact.Ref] = if FFlagDebugFriendsChat or FFlagExpChatTabShortcutNav or FFlagExpChatGenericChatFocus then arg1.setChatContainerRef else nil
        }

        local tbl3 = {
            uiSizeConstraint = Roact.createElement("UISizeConstraint", {
                MaxSize = if arg1.props.isSpatialUIEnabled then Vector2.new(math.huge, math.huge) else Vector2.new(Config.ChatWindowMaxWidth, math.huge)
            }),
            layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = arg1.props.chatLayoutAlignment.UIListLayoutVerticalAlignment
            }),
            topBorder = 0,
            topPadding = 0,
            chatWindow = 0,
            presetChatTray = 0,
            chatInputBar = 0,
            friendsChat = 0,
            enableChatButton = 0,
            chatInputRow = 0,
            channelBar = 0,
            bottomBorder = 0
        }

        local createElement2 = Roact.createElement

        local tbl4 = {
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/TopRoundedRect8px.png",
            ImageColor3 = backgroundColor,
            ImageTransparency = arg1.transparencyValue:map(function(num1: number): number
                local var7 = backgroundTransparency
                return var7 + num1 * (1 - var7)
            end),
            LayoutOrder = 1,
            SelectionImageObject = selectionImageObject,
            Selectable = true,
            ScaleType = Enum.ScaleType.Slice,
            Size = UDim2.new(1, 0, 0, 8),
            SliceCenter = Rect.new(8, 8, 24, 32),
            Visible = (arg1.props.isChatWindowVisible or arg1.props.isChatInputBarVisible) and not arg1.props.isChannelBarVisible,
            [Roact.Event.MouseEnter] = arg1.props.onHovered,
            [Roact.Event.MouseLeave] = arg1.props.onUnhovered,
            [Roact.Ref] = arg1.topBorderRef
        }

        tbl3.topBorder = createElement2("ImageLabel", tbl4, {
            uiSizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(Config.ChatWindowMaxWidth, math.huge) })
        })

        tbl3.topPadding = Roact.createElement("Frame", {
            LayoutOrder = 1,
            Size = if renderingFriends then UDim2.fromScale(1, 0) else UDim2.new(1, 0, 0, 8),
            Visible = arg1.props.isChannelBarVisible,
            BackgroundTransparency = arg1.transparencyValue:map(function(num1: number): number
                local var7 = backgroundTransparency
                return var7 + num1 * (1 - var7)
            end),
            BackgroundColor3 = if bool3 then backgroundColor else chatWindowSettings.BackgroundColor3,
            BorderSizePixel = 0,
            [Roact.Event.MouseEnter] = arg1.props.onHovered,
            [Roact.Event.MouseLeave] = arg1.props.onUnhovered,
            ZIndex = 0
        })

        local element

        if isExperienceChatRendered then
            element = (if not getFFlagExpChatConditionallyMountAppLayout() or FFlagExpChatEnableV2ChatWindow and FFlagExpChatKeepV2PoolMounted then true else arg1.props.isChatWindowVisible)
                and Roact.createElement(ChatWindow, {
                    LayoutOrder = 2,
                    size = UDim2.fromScale(1, 1),
                    transparencyValue = arg1.transparencyValue,
                    textTransparency = arg1.textTransparencyValue,
                    onHovered = arg1.props.onHovered,
                    onUnhovered = arg1.props.onUnhovered,
                    mutedUserIds = arg1.props.mutedUserIds,
                    activateWhisperMode = arg1.props.activateWhisperMode,
                    resetTargetChannel = arg1.props.resetTargetChannel,
                    visible = arg1.props.isChatWindowVisible,
                    onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
                    onAbsolutePositionChanged = arg1.onAbsolutePositionChanged,
                    chatWindowSettings = chatWindowSettings,
                    showTranslationButton = arg1.props.showTranslationButton,
                    isChannelBarVisible = arg1.props.isChannelBarVisible,
                    isSpatialUIEnabled = arg1.props.isSpatialUIEnabled
                })
        else
            element = nil
        end

        tbl3.chatWindow = element
        local element2

        if isExperienceChatRendered and FFlagExpChatPresetChatEnabled and FFlagExpChatPresetChatSendEnabled then
            element2 = Roact.createElement(
                PresetChatGate,
                {
                    layoutMode = Constants.LayoutMode.Tray,
                    targetTextChannel = arg1.props.targetTextChannel
                },
                {
                    Tray = Roact.createElement(PresetChatTray, {
                        textChannel = arg1.props.targetTextChannel,
                        onSendChat = arg1.props.onSendChat,
                        onSendGlobalChat = arg1.props.onSendGlobalChat
                    })
                }
            )
        else
            element2 = nil
        end

        tbl3.presetChatTray = element2
        local element3

        if not isExperienceChatRendered or FFlagExpChatNewInputBar then
            element3 = nil
        elseif bool5 then
            local createElement3 = Roact.createElement
            local func2 = PresetChatInputRow

            local tbl5 = {
                transparencyValue = arg1.transparencyValue,
                backgroundColor3 = backgroundColor,
                backgroundTransparency = backgroundTransparency,
                isChatWindowVisible = arg1.props.isChatWindowVisible,
                isChatInputBarVisible = var4,
                targetTextChannel = arg1.props.targetTextChannel,
                onSendChat = arg1.props.onSendChat,
                onSendGlobalChat = arg1.props.onSendGlobalChat,
                resetTargetChannel = arg1.props.resetTargetChannel,
                onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
                onAbsolutePositionChanged = arg1.onAbsolutePositionChanged,
                chatWindowSettings = chatWindowSettings,
                isChannelBarVisible = arg1.props.isChannelBarVisible,
                isSpatialUIEnabled = arg1.props.isSpatialUIEnabled,
                showEnableChatButton = showEnableChatButton,
                onHovered = arg1.props.onHovered,
                onUnhovered = arg1.props.onUnhovered,
                onEnableChatActivated = function()
                    manuallyInvokeAmpUpsell("InExperienceTextChatUpsell")
                end,
                presetLayoutMode = arg1.state.presetLayoutMode,
                isPresetButtonHidden = if FFlagExpChatPresetButtonGlobalTabFix then not var6 else nil
            }

            element3 = createElement3(func2, tbl5)
        else
            element3 = Roact.createElement(ChatInput, {
                LayoutOrder = 3,
                addTopPadding = arg1.props.isChatWindowVisible,
                onSendChat = arg1.props.onSendChat,
                onSendGlobalChat = arg1.props.onSendGlobalChat,
                transparencyValue = arg1.transparencyValue,
                resetTargetChannel = arg1.props.resetTargetChannel,
                visible = var4,
                onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
                onAbsolutePositionChanged = arg1.onAbsolutePositionChanged,
                chatWindowSettings = chatWindowSettings,
                isChannelBarVisible = arg1.props.isChannelBarVisible,
                isSpatialUIEnabled = arg1.props.isSpatialUIEnabled
            })
        end

        tbl3.chatInputBar = element3
        local element4

        if renderingFriends and arg1.props.isChatWindowVisible then
            element4 = Roact.createElement(FriendsChatDependencyBridge, {}, {
                friendsChatMain = Roact.createElement(FriendsChatMain, {
                    parentLayoutOrder = 2,
                    chatWindowSettings = chatWindowSettings,
                    transparencyValue = arg1.transparencyValue,
                    textTransparency = arg1.textTransparencyValue,
                    isSpatialUIEnabled = arg1.props.isSpatialUIEnabled,
                    isChannelBarVisible = arg1.props.isChannelBarVisible,
                    onHovered = arg1.props.onHovered,
                    onUnhovered = arg1.props.onUnhovered,
                    onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
                    onAbsolutePositionChanged = arg1.onAbsolutePositionChanged
                })
            })
        else
            element4 = nil
        end

        tbl3.friendsChat = element4
        local element5

        if isExperienceChatRendered and not FFlagExpChatNewInputBar and not bool5 and showEnableChatButton then
            element5 = Roact.createElement(EnableChatButton, {
                chatWindowSettings = chatWindowSettings,
                transparencyValue = arg1.transparencyValue,
                addTopPadding = arg1.props.isChatWindowVisible,
                onHovered = arg1.props.onHovered,
                onUnhovered = arg1.props.onUnhovered,
                isSpatialUIEnabled = arg1.props.isSpatialUIEnabled,
                LayoutOrder = 3,
                visible = arg1.props.isChatWindowVisible or arg1.props.isChatInputBarVisible,
                onActivated = function()
                    manuallyInvokeAmpUpsell("InExperienceTextChatUpsell")
                end
            })
        else
            element5 = nil
        end

        tbl3.enableChatButton = element5
        local var7

        if isExperienceChatRendered and FFlagExpChatNewInputBar then
            local createElement3 = Roact.createElement
            local str2 = "Frame"

            local tbl5 = {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = backgroundColor,
                BackgroundTransparency = arg1.transparencyValue:map(function(num1: number): number
                    return backgroundTransparency + num1 * (1 - backgroundTransparency)
                end),
                BorderSizePixel = 0,
                LayoutOrder = 3,
                Size = UDim2.fromScale(1, 0),
                Visible = not FFlagExpChatPresetChatEnabled or arg1.props.isChatWindowVisible or arg1.props.isChatInputBarVisible,
                ZIndex = 2,
                [Roact.Event.MouseEnter] = arg1.props.onHovered,
                [Roact.Event.MouseLeave] = arg1.props.onUnhovered
            }

            local tbl6 = {
                UIListLayout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                UIPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }),
                presetFlyOutWrapper = 0,
                fillArea = 0
            }
            local var8

            if FFlagExpChatPresetChatEnabled then
                if if FFlagExpChatPresetButtonGlobalTabFix then var6 else arg1.state.isPresetFlyOutAvailable then
                    local createElement4 = Roact.createElement
                    local str3 = "CanvasGroup"
                    local tbl7 = {
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundTransparency = 1,
                        GroupTransparency = arg1.transparencyValue,
                        LayoutOrder = 1,
                        Size = if isPresetFlyOutAvailable then UDim2.fromScale(1, 0) else UDim2.fromOffset(Config.PresetChat.ButtonWidth, 0),
                        Visible = if bool4 then arg1.props.isChatWindowVisible or arg1.props.isChatInputBarVisible else nil
                    }

                    local tbl8 = { PresetEntry = 0 }
                    local element6

                    if arg1.state.presetLayoutMode == Constants.LayoutMode.Tray then
                        element6 = Roact.createElement(PresetChatButton, {
                            baseTransparency = 0,
                            targetTextChannel = arg1.props.targetTextChannel,
                            addTopPadding = if FFlagExpChatCenterMobilePresetButton then arg1.props.isChatWindowVisible else nil,
                            fullWidth = if FFlagExpChatPresetFullWidthButtonFixes then isPresetFlyOutAvailable else nil
                        })
                    else
                        element6 = Roact.createElement(PresetChatFlyOut, {
                            addTopPadding = arg1.props.isChatWindowVisible,
                            fullWidthButton = isPresetFlyOutAvailable,
                            textChannel = arg1.props.targetTextChannel,
                            onSendChat = arg1.props.onSendChat,
                            onSendGlobalChat = arg1.props.onSendGlobalChat
                        })
                    end

                    tbl8.PresetEntry = element6
                    var8 = createElement4(str3, tbl7, tbl8)
                else
                    var8 = nil
                end
            else
                var8 = nil
            end

            tbl6.presetFlyOutWrapper = var8
            local var9

            if bool2 or not isPresetFlyOutAvailable then
                local createElement4 = Roact.createElement
                local str3 = "Frame"
                local tbl7 = {
                    AutomaticSize = if bool2 and isPresetFlyOutAvailable then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    LayoutOrder = 2,
                    Size = if bool2 and isPresetFlyOutAvailable then UDim2.new(0, 0, 0, 0) else UDim2.new(
                        1,
                        if if FFlagExpChatPresetButtonGlobalTabFix then var6 else arg1.state.isPresetFlyOutAvailable then -(Config.PresetChat.ButtonWidth + 8) else 0,
                        0,
                        0
                    ),
                    Visible = if bool2 then not isPresetFlyOutAvailable else nil
                }
                local tbl8 = { enableChatButton = 0, chatInputBar = 0 }
                local element6

                if showEnableChatButton then
                    element6 = Roact.createElement(EnableChatButton, {
                        chatWindowSettings = chatWindowSettings,
                        transparencyValue = arg1.transparencyValue,
                        addTopPadding = arg1.props.isChatWindowVisible,
                        onHovered = arg1.props.onHovered,
                        onUnhovered = arg1.props.onUnhovered,
                        isSpatialUIEnabled = arg1.props.isSpatialUIEnabled,
                        visible = arg1.props.isChatWindowVisible or arg1.props.isChatInputBarVisible,
                        onActivated = function()
                            manuallyInvokeAmpUpsell("InExperienceTextChatUpsell")
                        end
                    })
                else
                    element6 = nil
                end

                tbl8.enableChatButton = element6
                local element7

                if bool2 or var4 then
                    element7 = Roact.createElement(ChatInput, {
                        addTopPadding = arg1.props.isChatWindowVisible,
                        onSendChat = arg1.props.onSendChat,
                        onSendGlobalChat = arg1.props.onSendGlobalChat,
                        transparencyValue = arg1.transparencyValue,
                        resetTargetChannel = arg1.props.resetTargetChannel,
                        visible = if bool2 then var4 else nil,
                        onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
                        onAbsolutePositionChanged = arg1.onAbsolutePositionChanged,
                        chatWindowSettings = chatWindowSettings,
                        isChannelBarVisible = arg1.props.isChannelBarVisible,
                        isSpatialUIEnabled = arg1.props.isSpatialUIEnabled,
                        onHovered = arg1.props.onHovered,
                        onUnhovered = arg1.props.onUnhovered,
                        suppressOuterBackground = true
                    })
                else
                    element7 = nil
                end

                tbl8.chatInputBar = element7
                var9 = createElement4(str3, tbl7, tbl8)
            else
                var9 = nil
            end

            tbl6.fillArea = var9
            var7 = createElement3(str2, tbl5, tbl6)
        else
            var7 = nil
        end

        tbl3.chatInputRow = var7

        tbl3.channelBar = (not getFFlagExpChatConditionallyMountAppLayout() or arg1.props.isChannelBarVisible)
            and Roact.createElement(ChannelBar, {
                LayoutOrder = if renderingFriends then 100 else 4,
                size = UDim2.fromScale(1, 1),
                transparencyValue = arg1.transparencyValue,
                onHovered = arg1.props.onHovered,
                onUnhovered = arg1.props.onUnhovered,
                chatWindowSettings = chatWindowSettings,
                visible = arg1.props.isChannelBarVisible,
                topBorderRef = arg1.topBorderRef
            })
        local var8

        if renderingFriends then
            var8 = nil
        else
            local createElement3 = Roact.createElement

            local tbl5 = {
                Name = "bottomBorder",
                BackgroundTransparency = 1,
                Image = "rbxasset://textures/ui/BottomRoundedRect8px.png",
                ImageColor3 = backgroundColor,
                ImageTransparency = arg1.transparencyValue:map(function(num1: number): number
                    local var9 = backgroundTransparency
                    return var9 + num1 * (1 - var9)
                end),
                LayoutOrder = 5,
                ScaleType = Enum.ScaleType.Slice,
                Size = UDim2.new(1, 0, 0, 8),
                SliceCenter = Rect.new(8, 0, 24, 16),
                Visible = arg1.props.isChatWindowVisible or arg1.props.isChatInputBarVisible,
                [Roact.Event.MouseEnter] = arg1.props.onHovered,
                [Roact.Event.MouseLeave] = arg1.props.onUnhovered
            }

            var8 = createElement3("ImageLabel", tbl5, {
                uiSizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(Config.ChatWindowMaxWidth, math.huge) })
            })
        end

        tbl3.bottomBorder = var8
        local appLayout = createElement(str1, tbl2, tbl3)

        return Roact.createElement(
            SpatialUI.Provider,
            {
                value = {
                    isSpatialUIEnabled = arg1.props.isSpatialUIEnabled
                }
            },
            {
                appLayout = Roact.createElement(ChatPlatformProvider, {}, { appLayout = appLayout })
            }
        )
    end
    return Roact.createElement(
        ReactFocusNavigation.FocusNavigationContext.Provider,
        {
            value = arg1.focusNavigationService
        },
        {
            CursorProvider = Roact.createElement(SelectionCursorProvider, {}, {
                NewCursorProvider = Roact.createElement(CursorProvider, {}, {
                    withSelectionCursorProvider(function(arg2)
                        return func1(arg2(CursorKind.Invisible))
                    end)
                })
            })
        }
    )
end

function var2.debugInjectFakeMessages(arg1)
    if arg1.debugInjectionThread ~= nil then
        task.cancel(arg1.debugInjectionThread)
        arg1.debugInjectionThread = nil
    end

    local renderingFriends = arg1.props.renderingFriends
    local var3 = GetFriendsChatRealtimeStore(false).getActiveConversationId(false) or FStringDebugFriendsChatConversationId
    if renderingFriends and (var3 == nil or var3 == "") then
        return
    end

    arg1.debugInjectionThread = task.spawn(function()
        local conversationMessageStore = if renderingFriends then GetConversationMessageStore(false) else nil
        local conversationMessageListStore = if renderingFriends then GetConversationMessageListStore(false) else nil
        local messagesStore = if renderingFriends then nil else GetMessagesStore(false)

        for i = 1, 50 do
            if renderingFriends then
                local clock = os.clock
                local id = `debug-fake-{tostring(clock())}-{i}`
                conversationMessageStore.upsertMessages({
                    [id] = {
                        id = id,
                        type = "user",
                        content = `Fake friends-chat debug message #{i}`,
                        created_at = DateTime.now():ToIsoDate(),
                        sender_user_id = (i - 1) % 5 + 1
                    }
                })
                conversationMessageListStore.prependMessages(var3, { id })
            elseif messagesStore ~= nil then
                messagesStore.addSystemMessage(`Fake exp-chat debug message #{i}`, "RBXGeneral", nil, nil, false)
            end
            if i < 50 then
                task.wait(0.1)
            end
        end

        arg1.debugInjectionThread = nil
    end)
end

local function isVisibleWithin(arg1, arg2)
    while arg1 ~= nil do
        if arg1:IsA("GuiObject") and not arg1.Visible then
            return false
        end
        if arg1 == arg2 then
            break
        end

        arg1 = arg1.Parent
    end
    return true
end

function var2.debugSeedFocusNavigation(arg1)
    local current = if arg1.debugContainerRef then arg1.debugContainerRef.current else nil

    if current == nil then
        return
    end

    local current2 = if arg1.topBorderRef then arg1.topBorderRef.current else nil

    for _, selectedCoreObject in current:GetDescendants() do
        if selectedCoreObject:IsA("GuiObject")
            and selectedCoreObject.Selectable
            and selectedCoreObject ~= current2
            and isVisibleWithin(selectedCoreObject, current)
        then
            GuiService.SelectedCoreObject = selectedCoreObject
            return
        end
    end
end

function var2.willUnmount(arg1)
    if FFlagExpChatWindowStatusEventFixes then
        arg1.props.timer:stop()
        arg1.props.textTimer:stop()
        if arg1.ChatWindowStatusStore.getCurrentChatWindowState(false) ~= "closed" then
            arg1.ChatWindowStatusStore.setClosedTimerStarted(os.clock())
        end
    end

    if arg1.debugKeybindConnection then
        arg1.debugKeybindConnection:Disconnect()
        arg1.debugKeybindConnection = nil
    end
    if arg1.debugInjectionThread ~= nil then
        task.cancel(arg1.debugInjectionThread)
        arg1.debugInjectionThread = nil
    end

    arg1.disposeBackgroundEffect()
    arg1.disposeTextEffect()

    arg1.textTransparencyMotor:destroy()
    arg1.backgroundTransparencyMotor:destroy()

    if getFFlagExpChatTriggerWindowStatusEvent() and arg1.localPlayerLeavingConnection then
        arg1.localPlayerLeavingConnection:Disconnect()
    end

    if FFlagExpChatUseChatConfigStore and arg1.disposeChatWindowSettingsEffect then
        arg1.disposeChatWindowSettingsEffect()
    end

    if FFlagExpChatUseChatConfigStore and arg1.disposeChatInputBarSettingsEffect then
        arg1.disposeChatInputBarSettingsEffect()
    end

    if arg1.disposeChatStatusEffect then
        arg1.disposeChatStatusEffect()
    end

    if FFlagExpChatPresetChatEnabled and arg1.disposePresetFlyOutAvailableEffect then
        arg1.disposePresetFlyOutAvailableEffect()
    end
end

return var2
