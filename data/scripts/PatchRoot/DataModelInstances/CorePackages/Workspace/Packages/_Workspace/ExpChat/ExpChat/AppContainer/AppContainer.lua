-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Roact = require(ExpChatParent.Roact)
local React = require(ExpChatParent.React)
local RoactRodux = require(ExpChatParent.RoactRodux)
local Cryo = require(ExpChatParent.Cryo)
local Signals = require(ExpChatParent.Signals)
local SignalsReact = require(ExpChatParent.SignalsReact)
local tutils = require(ExpChatParent.tutils)
local SharedFlags = require(ExpChatParent.SharedFlags)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)

local ClientSettings = require(ExpChat.ClientSettings)

local mapStateToProps = require(script.Parent.mapStateToProps)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)

local BubbleChat = require(script.Parent.Parent.BubbleChat)
local AppLayout = require(script.Parent.Parent.AppLayout)
local isChatRegionLocked = require(ExpChat.isChatRegionLocked)
local TextChatService = game:GetService("TextChatService")

local getFFlagChatTranslationShowFTUX = require(ExpChat.Flags.getFFlagChatTranslationShowFTUX)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatNewInputBar = require(ExpChat.Flags.FFlagExpChatNewInputBar)
local getFFlagExpChatAlwaysRunTCS = SharedFlags.getFFlagExpChatAlwaysRunTCS
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local GetChannelTabsStore = if FFlagExpChatUseChannelTabsStore then require(ExpChat.Stores.GetChannelTabsStore) else nil

function getChatWindowEnabled()
    local success, result = pcall(function(): boolean
        local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
        return not (chatWindowConfiguration == nil) and chatWindowConfiguration.Enabled
    end)

    return success and result
end

function getChatTranslationEnabled()
    local success, result = pcall(function(): boolean
        return TextChatService.ChatTranslationEnabled
    end)

    return success and result
end

function getChatTranslationToggleEnabled()
    local success, result = pcall(function(): boolean
        return TextChatService.ChatTranslationToggleEnabled
    end)

    return success and result
end

function shouldShowChatTranslationFTUX(): boolean
    if not game:GetEngineFeature("TextChatServiceSettingsSaved") then
        return true
    end

    local success, result = pcall(function(): boolean
        return TextChatService.ChatTranslationFTUXShown
    end)

    return not (success and result)
end

local var1 = shouldShowChatTranslationFTUX()

local ChatTranslationFTUX = require(script.Parent.Parent.ChatTranslationFTUX)

local var2 = Roact.PureComponent:extend("AppContainer")
var2.defaultProps = {
    isChatInputBarVisible = true,
    isChatWindowVisible = true,
    isChannelBarVisible = false,
    onSendChat = nil,
    onSendGlobalChat = nil,
    mutedUserIds = nil,
    textTimer = nil,
    timer = nil,
    textChatService = TextChatService,
    chat = game:GetService("Chat")
}

local var3 = nil

function var2.init(arg1)
    arg1:setState({ showTranslationButton = false, isTextChatServiceEnabled = false })
end

function var2.willUnmount(_)
    var3:Disconnect()
end

function var2.didMount(arg1)
    arg1.migrationConnection = arg1.props.chat:GetPropertyChangedSignal("IsAutoMigrated"):Connect(function()
        if arg1.props.chat.IsAutoMigrated then
            arg1:setState({ isTextChatServiceEnabled = true })
        end
    end)

    local function onTextChatServicePropertyChanged(property: string)
        if property == "ChatTranslationEnabled" then
            local success, result = pcall(function(): boolean
                return TextChatService.ChatTranslationEnabled
            end)

            if success then
                arg1.props.onToggleTranslation(result)

                arg1:setState({ showTranslationButton = getChatTranslationEnabled() and getChatTranslationToggleEnabled() })
            end

            return
        end

        if property ~= "ChatTranslationToggleEnabled" then
            return
        end

        local success, _result = pcall(function(): boolean
            return TextChatService.ChatTranslationToggleEnabled
        end)

        local success2, result = pcall(function(): boolean
            return TextChatService.ChatTranslationEnabled
        end)

        if not success then
            return
        end
        if success2 then
            arg1.props.onToggleTranslation(result)
        end

        arg1:setState({ showTranslationButton = getChatTranslationEnabled() and getChatTranslationToggleEnabled() })
    end

    var3 = var3 or TextChatService.Changed:Connect(onTextChatServicePropertyChanged)

    arg1:setState({
        showTranslationButton = getChatTranslationEnabled() and getChatTranslationToggleEnabled(),
        isTextChatServiceEnabled = arg1.props.textChatService.ChatVersion == Enum.ChatVersion.TextChatService or getFFlagExpChatAlwaysRunTCS()
    })
end

function var2.render(arg1)
    local isTextChatServiceEnabled = arg1.state.isTextChatServiceEnabled

    local bubbleChat = Roact.createElement(BubbleChat, {
        getIconVoiceIndicator = arg1.props.getIconVoiceIndicator,
        onClickedVoiceIndicator = arg1.props.onClickedVoiceIndicator,
        onClickedCameraIndicator = arg1.props.onClickedCameraIndicator,
        selfViewListenerChanged = arg1.props.selfViewListenerChanged,
        getPermissions = arg1.props.getPermissions,
        displayCameraDeniedToast = arg1.props.displayCameraDeniedToast,
        isCamEnabledForUserAndPlace = arg1.props.isCamEnabledForUserAndPlace,
        isCameraOnlyUser = arg1.props.isCameraOnlyUser,
        isTextChatServiceOn = isTextChatServiceEnabled,
        isVoiceServiceInitialized = arg1.props.isVoiceServiceInitialized
    })

    if not isTextChatServiceEnabled then
        return Roact.createElement(ClientSettings.Provider, { value = arg1.props.clientSettings }, { bubbleChat = bubbleChat })
    end

    local createElement = Roact.createElement
    local provider = ClientSettings.Provider
    local tbl1 = {
        value = arg1.props.clientSettings
    }
    local tbl2 = { app = 0 }
    local createFragment = Roact.createFragment
    local tbl3 = {
        appLayout = Roact.createElement(AppLayout, {
            isChatInputBarVisible = not isChatRegionLocked() and arg1.props.isChatInputBarVisible,
            isChatWindowVisible = arg1.props.isChatWindowVisible,
            isChannelBarVisible = arg1.props.isChannelBarVisible,
            chatTopBarVisibility = arg1.props.chatTopBarVisibility,
            mutedUserIds = arg1.props.mutedUserIds,
            onSendChat = arg1.props.onSendChat,
            onSendGlobalChat = arg1.props.onSendGlobalChat,
            timer = arg1.props.timer,
            textTimer = arg1.props.textTimer,
            activateWhisperMode = arg1.props.activateWhisperMode,
            resetTargetChannel = arg1.props.resetTargetChannel,
            isTextBoxFocused = arg1.props.isTextBoxFocused,
            onHovered = arg1.props.onHovered,
            onUnhovered = arg1.props.onUnhovered,
            chatLayoutAlignment = arg1.props.chatLayoutAlignment,
            chatWindowSettings = arg1.props.chatWindowSettings,
            clientSettings = arg1.props.clientSettings,
            selectedTabType = arg1.props.selectedTabType,
            renderingFriends = arg1.props.renderingFriends,
            isExperienceChatRendered = arg1.props.isExperienceChatRendered,
            showTranslationButton = arg1.state.showTranslationButton,
            isSpatialUIEnabled = arg1.props.isSpatialUIEnabled,
            targetTextChannel = if FFlagExpChatPresetChatEnabled or FFlagExpChatNewInputBar then arg1.props.targetTextChannel else nil
        }),
        bubbleChat = bubbleChat,
        ChatTranslationFTUX = if getFFlagChatTranslationShowFTUX() and var1 and getChatTranslationEnabled() and getChatWindowEnabled() then Roact.createElement(ChatTranslationFTUX, {}) else nil
    }
    tbl2.app = createFragment(tbl3)
    return createElement(provider, tbl1, tbl2)
end

local var4 = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(var2)

return if FFlagExpChatUseChannelTabsStore then function(arg1) -- name: AppContainerWithSignals
    local var5 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var5 = GetChannelTabsStore(false).getChannelTabsState(arg2)
            local allChannelTab = if var5.selectedTabName then var5.allChannelTabs[var5.selectedTabName] else nil
            return {
                isGlobalTabSelected = var5.selectedTabName == "RBXGlobal",
                selectedTabType = allChannelTab and allChannelTab.type or nil,
                hasGlobalChannelTab = var5.allChannelTabs.RBXGlobal ~= nil,
                hasFriendsChannelTab = var5.allChannelTabs[FriendsChatTabName] ~= nil
            }
        end, tutils.deepEqual)
    end, {})
    local var6 = SignalsReact.useSignalState(var5)
    return React.createElement(var4, Cryo.Dictionary.union(arg1, var6))
end else var4
