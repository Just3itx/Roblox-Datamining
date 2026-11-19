-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")
local RobloxGui = CoreGui.RobloxGui
local FFlagEnableUIManagerPackgify = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableUIManagerPackgify

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local PanelType, UIManager, SpatialUIType

if isInExperienceUIVREnabled or FFlagEnableUIManagerPackgify then
    local vrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
    PanelType = vrSpatialUi.Constants.PanelType
    UIManager = vrSpatialUi.UIManager
    SpatialUIType = vrSpatialUi.Constants.SpatialUIType
else
    local uiManager = RobloxGui:WaitForChild("Modules"):WaitForChild("UIManager")
    local constants = require(uiManager.Constants)
    PanelType = constants.PanelType
    UIManager = require(uiManager.UIManager)
    SpatialUIType = constants.SpatialUIType
end

if game:DefineFastFlag("DebugExpChat", false) then
    require(CorePackages.Workspace.Packages.ExpChatDebug).start()
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local GameTranslator = require(RobloxGui.Modules.GameTranslator)
local ApolloClient = require(RobloxGui.Modules.ApolloClient)
local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)
local getFFlagAddApolloClientToExperienceChat = require(RobloxGui.Modules.Flags.getFFlagAddApolloClientToExperienceChat)
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local IsSpatialRobloxGuiEnabled = require(RobloxGui.Modules.VR.IsSpatialRobloxGuiEnabled)
local getFFlagExpChatAlwaysRunTCS = require(CorePackages.Workspace.Packages.SharedFlags).getFFlagExpChatAlwaysRunTCS

local getIconVoiceIndicator = require(RobloxGui.Modules.VoiceChat.Components.getIconVoiceIndicator)
local onClickedVoiceIndicator = require(RobloxGui.Modules.VoiceChat.Components.onClickedVoiceIndicator)
local getPermissions = if var1 then require(RobloxGui.Modules.VoiceChat.Components.getPermissions) else nil
local var2 = nil
local var3

if IsSpatialRobloxGuiEnabled then
    local tbl1 = {
        panelType = PanelType.Chat,
        screenGuiProps = {
            Name = "ExperienceChat",
            ResetOnSpawn = false,
            DisplayOrder = -1,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        }
    }
    var2 = UIManager.getInstance():createUI(tbl1)
    var3 = var2.panelObject

    if isInExperienceUIVREnabled then
        local observable = require(CorePackages.Workspace.Packages.Observable)
        local chatSelector = require(CoreGui.RobloxGui.Modules.ChatSelector)
        local observableValue = observable.ObservableValue.new(chatSelector:GetVisibility())
        chatSelector.VisibilityStateChanged:connect(function(arg1)
            observableValue:set(arg1)
        end)
        UIManager.getInstance():connectPanelVisibility(tbl1.panelType, observableValue)
    end
else
    var3 = Instance.new("ScreenGui")
    var3.Name = "ExperienceChat"
    var3.ResetOnSpawn = false
    var3.DisplayOrder = -1
    var3.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    var3.Parent = CoreGui
end

local function findTextChannel(name: string): Instance?
    local var4 = TextChatService:FindFirstChild(name, true)
    while not var4 do
        wait()
        var4 = TextChatService:FindFirstChild(name, true)
    end

    return var4
end

StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
    if coreGuiType == Enum.CoreGuiType.All or coreGuiType == Enum.CoreGuiType.Chat then
        ExpChat.Events.SetCoreGuiEnabledChanged(enabled)
    end
end)

local IChatSettings = require(RobloxGui.Modules.InGameChat.BubbleChat.Types).IChatSettings
local CreateDefaultTextChannels = if getFFlagExpChatAlwaysRunTCS() then TextChatService.CreateDefaultTextChannels else TextChatService.ChatVersion == Enum.ChatVersion.TextChatService and TextChatService.CreateDefaultTextChannels

if game:GetEngineFeature("TextChatServiceProtectedChatEnabled")
    and game:DefineFastFlag("ExpChatTextChannelWindow", false)
    and TextChatService:IsProtectedChatEnabled()
then
    require(CorePackages.Workspace.Packages.TextChannelWindow).start()
end

local mountClientApp = ExpChat.mountClientApp
local tbl1 = {
    apolloClient = 0,
    getIconVoiceIndicator = 0,
    onClickedVoiceIndicator = 0,
    getPermissions = 0,
    defaultTargetTextChannel = 0,
    defaultSystemTextChannel = 0,
    validateLegacyBubbleChatSettings = 0,
    translator = 0,
    gameTranslator = 0,
    parent = 0,
    isSpatialUIEnabled = 0
}

if not getFFlagAddApolloClientToExperienceChat() then
    ApolloClient = nil
end

tbl1.apolloClient = ApolloClient
tbl1.getIconVoiceIndicator = getIconVoiceIndicator or nil
tbl1.onClickedVoiceIndicator = onClickedVoiceIndicator or nil
tbl1.getPermissions = getPermissions or nil
tbl1.defaultTargetTextChannel = if CreateDefaultTextChannels then findTextChannel("RBXGeneral") else nil
tbl1.defaultSystemTextChannel = if CreateDefaultTextChannels then findTextChannel("RBXSystem") else nil
tbl1.validateLegacyBubbleChatSettings = IChatSettings or nil

tbl1.translator = RobloxTranslator
tbl1.gameTranslator = GameTranslator
tbl1.parent = var3
tbl1.isSpatialUIEnabled = var2 and var2.type == SpatialUIType.SpatialUI
mountClientApp(tbl1)
