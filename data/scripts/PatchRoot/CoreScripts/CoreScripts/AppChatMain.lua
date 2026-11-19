-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local ChatEntryPointNames = require(CorePackages.Workspace.Packages.SocialCommon).Enums.ChatEntryPointNames

local ApolloClient = require(CoreGui.RobloxGui.Modules.ApolloClient)

local GetFFlagFixSettingshubImportOrder = require(RobloxGui.Modules.Flags.GetFFlagFixSettingshubImportOrder)

local FFlagRemoveLoadingTimeout = require(RobloxGui.Modules.Flags.FFlagRemoveLoadingTimeout)
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
if GetFFlagFixSettingshubImportOrder() and not (FFlagRemoveLoadingTimeout and var1) then
    CoreGui:WaitForChild("TopBarApp", FFlagRemoveLoadingTimeout and math.huge or nil)
end
local SettingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
local ParentContainer = require(CorePackages.Workspace.Packages.AppChat.ParentContainer)
local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)

local renderCoreScriptInExperienceAppChat = require(CorePackages.Workspace.Packages.AppChat.renderCoreScriptInExperienceAppChat)
local ViewportUtil = require(RobloxGui.Modules.Chrome.ChromeShared.Service.ViewportUtil)
local ChatSelector = require(RobloxGui.Modules.ChatSelector)
local PlayerListManager = require(RobloxGui.Modules.PlayerList.PlayerListManager)

local Constants = require(RobloxGui.Modules.TopBar.Constants)
local GetFFlagIsSquadEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagIsSquadEnabled
local ChatChromeIntegration = if var1 then require(RobloxGui.Modules.Chrome.Integrations.ExpChat.ChatChromeIntegration) else nil
local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)
local openConversation = require(CorePackages.Workspace.Packages.FriendsChat.openConversation)
local Promise = require(CorePackages.Packages.Promise)
local engineFeature = game:GetEngineFeature("SSUIMetaLua")

local var2 = Constants.ApplyDisplayScale(Constants.TopBarTopMargin)

InExperienceAppChatModal.default:initialize(var2, SettingsHub, ViewportUtil, ChatSelector, PlayerListManager)

if engineFeature then
    pcall(function()
        local SafetyService = game:GetService("SafetyService")
        InExperienceAppChatModal.default.visibilitySignal.Event:Connect(function(arg1)
            if arg1 then
                SafetyService:ReportPartyChatWindowOpen()
                return
            end
            SafetyService:ReportPartyChatWindowClose()
        end)
    end)
end

local function func1(arg1)
    InExperienceAppChatModal:setUnreadCount(arg1)
end

local chatOpenCapability = if ChatChromeIntegration then ChatChromeIntegration.chatOpenCapability else nil

local openFriendsChatConversation = not chatOpenCapability and function(_: string)
    return Promise.resolve(false)
end or ParentContainer.createOpenFriendsChatConversation({
    isChatAvailable = chatOpenCapability.isAvailable,
    openConversation = openConversation,
    requestSelectFriendsTab = ExpChat.requestSelectFriendsTab,
    ensureOpenChat = chatOpenCapability.ensureOpenChat
})

renderCoreScriptInExperienceAppChat(ApolloClient, {
    getParentContainer = function()
        return InExperienceAppChatModal.default.frame
    end,
    visibilitySignal = InExperienceAppChatModal.default.visibilitySignal.Event,
    getRequestedRoute = function()
        return InExperienceAppChatModal.default.requestedRoute
    end,
    requestedRouteSignal = InExperienceAppChatModal.default.requestedRouteSignal.Event,
    clearRequestedRoute = function()
        InExperienceAppChatModal.default:clearRequestedRoute()
    end,
    getShouldSetAppChatVisible = function(...)
        return InExperienceAppChatModal:getVisible()
    end,
    entryPoint = ChatEntryPointNames.ChromeDropdown,
    hideParentContainer = function()
        InExperienceAppChatModal.default:setVisible(false)
    end,
    showParentContainer = function()
        InExperienceAppChatModal.default:setVisible(true)
    end,
    updateCurrentSquadId = function(arg1)
        if GetFFlagIsSquadEnabled() then
            InExperienceAppChatModal:setCurrentSquadId(arg1)
        end
    end,
    openFriendsChatConversation = openFriendsChatConversation
}, func1)
