-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local GameInviteModalManager = require(CorePackages.Workspace.Packages.GameInvite).GameInviteModalManager

local FFlagGameInviteInExpJoinOrInviteLabel = require(CorePackages.Workspace.Packages.GameInvite.FFlagGameInviteInExpJoinOrInviteLabel)
local isPlatformInviteUIEnabled = require(CorePackages.Workspace.Packages.GameInvite.isPlatformInviteUIEnabled)
local AppCommonLib = require(CorePackages.Workspace.Packages.AppCommonLib)

local Service = require(Chrome.Service)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local MappedSignal = require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal
local SideSheetPlacement = Chrome2.Enums.SideSheetPlacement
local Signal = AppCommonLib.Signal

local InGameMenuIntegrationUtils = require(script.Parent.InGameMenuIntegrationUtils)

local signal = Signal.new()
local mappedSignal = MappedSignal.new(signal, function()
    return GameInviteModalManager:isGameModalOpen()
end)
GameInviteModalManager.ToggleGameInviteModalEvent.Event:Connect(function()
    signal:fire()
end)

local function shouldShowInviteFriends(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = not RunService:IsStudio()
    return bool1 and Players.LocalPlayer ~= nil and Players.LocalPlayer.UserId > 0
end

local tbl1 = {
    initialAvailability = if shouldShowInviteFriends() then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable,
    id = "invite_friends",
    label = if FFlagGameInviteInExpJoinOrInviteLabel then if isPlatformInviteUIEnabled() then "CoreScripts.InGameMenu.PageTitle.InviteFriends" else "CoreScripts.InGameMenu.PageTitle.JoinOrInvite" else "CoreScripts.InGameMenu.PageTitle.InviteFriends",
    sideSheetPlacement = SideSheetPlacement.AboveFold,
    activated = InGameMenuIntegrationUtils.toggleInviteFriendsPage,
    isActivated = mappedSignal,
    components = {
        Icon = function()
            return CommonIcon("PersonArrowFromBottomRight", nil, mappedSignal)
        end
    }
}

return Service:register(tbl1)
