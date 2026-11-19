-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local SocialService = game:GetService("SocialService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Modules = CoreGui:WaitForChild("RobloxGui").Modules
local Settings = Modules.Settings
local ShareGame = Settings.Pages.ShareGame

local GetFFlagFixSettingshubImportOrder = require(Modules.Flags.GetFFlagFixSettingshubImportOrder)

local SettingsHub = if GetFFlagFixSettingshubImportOrder() then nil else require(Settings.SettingsHub)

local GetFFlagEnableNewInviteMenuCustomization = require(Modules.Flags.GetFFlagEnableNewInviteMenuCustomization)
local GetFFlagEnableInvitePromptLoadingState = require(Modules.Flags.GetFFlagEnableInvitePromptLoadingState)

local Diag = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.Diag

local EventStream = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventStream

local GameInviteAnalytics = require(CorePackages.Workspace.Packages.GameInvite).GameInviteAnalytics

local GameInvite = require(CorePackages.Workspace.Packages.GameInvite)
local GameInviteModalManager = GameInvite.GameInviteModalManager
local GetCustomizedInvitePromptTrigger = GameInvite.GetCustomizedInvitePromptTrigger
local GameInviteConstants = GameInvite.GameInviteConstants
local GameInviteAnalyticsManager = GameInvite.GameInviteAnalyticsManager

local var1 = GameInviteAnalytics.new():withEventStream((EventStream.new(RbxAnalyticsService))):withDiag(
    Diag.new(RbxAnalyticsService)
):withButtonName(
    GameInviteAnalytics.ButtonName.ModalPrompt
)
local var2 = require(ShareGame.InviteToGamePrompt).new(CoreGui):withSocialServiceAndLocalPlayer(SocialService, Players.LocalPlayer):withAnalytics(
    var1
)
local ApiGetCanSendAndCanCustomizeInvites = require(ShareGame.Thunks.ApiGetCanSendAndCanCustomizeInvites)
local getCustomizedInvitePromptParams = require(ShareGame.getCustomizedInvitePromptParams)

local function canSendGameInviteAsync(player: Player) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): boolean
        return SocialService:CanSendGameInviteAsync(player)
    end)
    return success and result
end

SocialService.PromptInviteRequested:Connect(function(player: Instance, experienceInviteOptions: Instance)
    if player ~= Players.LocalPlayer then
        return
    end

    if GetFFlagFixSettingshubImportOrder() then
        SettingsHub = require(Settings.SettingsHub)
    end

    if SettingsHub:GetVisibility() then
        if Players and Players.LocalPlayer then
            SocialService:InvokeGameInvitePromptClosed(Players.LocalPlayer, {})
        end
        return
    end

    local var3 = experienceInviteOptions or nil

    local trigger = GetCustomizedInvitePromptTrigger(var3)

    if trigger == GameInviteConstants.Triggers.DeveloperMultiple then
        GameInviteAnalyticsManager:withButtonName(GameInviteAnalyticsManager.ButtonName.ModalPrompt)
        GameInviteAnalyticsManager:inputShareGameEntryPoint()

        GameInviteModalManager:openModal({ trigger = trigger }, var3)

        return
    end

    if not GetFFlagEnableNewInviteMenuCustomization() then
        if not canSendGameInviteAsync(player) then
            return
        end
        var2:show()
        return
    end

    local fFlagEnableInvitePromptLoadingState = GetFFlagEnableInvitePromptLoadingState()
    if fFlagEnableInvitePromptLoadingState then
        var2:show({ isLoading = true })
    end

    local customizedInvitePromptParams = getCustomizedInvitePromptParams(var3, ApiGetCanSendAndCanCustomizeInvites)
    if customizedInvitePromptParams then
        var2:show(customizedInvitePromptParams)
    elseif fFlagEnableInvitePromptLoadingState then
        var2:hide()
    end
end)
