-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local React = require(CorePackages.Packages.React)
local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local MappedSignal = ChromeUtils.MappedSignal
local WindowSizeSignal = require(Chrome.ChromeShared.Service.WindowSizeSignal)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local AvatarSwitcherChromeWrapper = require(Chrome.Integrations.AvatarSwitcher.AvatarSwitcherChromeWrapper)
local AvatarSwitcherIcon = require(Chrome.Integrations.AvatarSwitcher.AvatarSwitcherIcon)
local Url = require(CorePackages.Workspace.Packages.Http).Url

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagChromeWindowSignalConstraintsToggle = SharedFlags.FFlagChromeWindowSignalConstraintsToggle
local FFlagRemoveAvatarSwitcherIfUnsupported = SharedFlags.FFlagRemoveAvatarSwitcherIfUnsupported
local FFlagAvatarWorkshopReplacesAvatarSwitcher = SharedFlags.FFlagAvatarWorkshopReplacesAvatarSwitcher

local mappedSignal = MappedSignal.new(Service:onIntegrationStatusChanged(), function()
    return Service:isWindowOpen(Constants.AVATAR_SWITCHER_ID)
end)

local apiUrl = if FFlagRemoveAvatarSwitcherIfUnsupported then Url.AVATAR_URL .. "v2/avatar/experience/get-experience-avatar-support" else nil
local windowSizeSignal = if FFlagChromeWindowSignalConstraintsToggle then WindowSizeSignal.new(844, 754, false, true) else WindowSizeSignal.new(844, 754, false)
local coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.All) or StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.AvatarSwitcher)

local function getInitialAvailability() -- Luacid: Inlined by compiler; 1 call site recovered
    return if coreGuiEnabled and not FFlagRemoveAvatarSwitcherIfUnsupported then Service.AvailabilitySignal.Available else Service.AvailabilitySignal.Unavailable
end

local var1 = Service:register({
    initialAvailability = getInitialAvailability(),
    id = Constants.AVATAR_SWITCHER_ID,
    label = if FFlagAvatarWorkshopReplacesAvatarSwitcher then "CommonUI.Features.Label.Avatar" else "Feature.AvatarSwitcher.Heading.SwitchAvatar",
    sideSheetPlacement = SideSheetPlacement.AboveFold,
    activated = function(_)
        Service:toggleWindow(Constants.AVATAR_SWITCHER_ID)
    end,
    isActivated = mappedSignal,
    cachePosition = true,
    draggable = true,
    windowSize = windowSizeSignal,
    components = {
        Icon = function()
            return React.createElement(AvatarSwitcherIcon, { isActive = mappedSignal })
        end,
        Window = function()
            return React.createElement(
                AvatarSwitcherChromeWrapper,
                { windowSize = windowSizeSignal, maxWindowWidth = 844, maxWindowHeight = 754 }
            )
        end
    }
})

local bool1 = not FFlagRemoveAvatarSwitcherIfUnsupported

local function updateAvatarSwitcherAvailability() -- Luacid: Inlined by compiler; 2 call sites recovered
    if coreGuiEnabled and bool1 then
        var1.availability:available()
        return
    end
    if Service:isWindowOpen(Constants.AVATAR_SWITCHER_ID) then
        Service:toggleWindow(Constants.AVATAR_SWITCHER_ID)
    end
    var1.availability:unavailable()
end

ChromeUtils.setCoreGuiAvailability(var1, Enum.CoreGuiType.AvatarSwitcher, function(arg1)
    coreGuiEnabled = arg1
    updateAvatarSwitcherAvailability()
end)

if FFlagRemoveAvatarSwitcherIfUnsupported then
    task.spawn(function()
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end

        local success, result = pcall(function()
            local asyncFullUrl = HttpRbxApiService:GetAsyncFullUrl(apiUrl)
            return HttpService:JSONDecode(asyncFullUrl)
        end)

        if success and result and result.experienceAvatarSupportType ~= 0 then
            bool1 = true
            updateAvatarSwitcherAvailability()
        end
    end)
end

return var1
