-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local ChromeIntegrationUtils = require(Chrome.Integrations.ChromeIntegrationUtils)
local RespawnUtils = require(Chrome.Integrations.RespawnUtils)
local MappedSignal = ChromeUtils.MappedSignal
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local SideSheetPlacement = Chrome2.Enums.SideSheetPlacement

local CommonIcon = require(Chrome.Integrations.CommonIcon)
local CommonFtuxTooltip = require(Chrome.Integrations.CommonFtuxTooltip)
local AvatarSwitcherFtuxTooltip = require(Chrome.Integrations.AvatarSwitcher.AvatarSwitcherFtuxTooltip)
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local PlayerListManager = require(RobloxGui.Modules.PlayerList.PlayerListManager)
local EmotesMenuMaster = require(RobloxGui.Modules.EmotesMenu.EmotesMenuMaster)
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local BackpackScript = if FFlagEnableNewBackpack then nil else require(RobloxGui.Modules.BackpackScript)
local useMappedSignal = Chrome2.Hooks.useMappedSignal
local GetFFlagIsSquadEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagIsSquadEnabled

local useAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy).useAppPolicy

local MenuIcon = require(RobloxGui.Modules.TopBar.ComponentsV2.MenuIcon)

local UIBlox = require(CorePackages.Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider

local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local TooltipContext = require(Chrome.ChromeShared.Unibar.Tooltips.TooltipContext)
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

local SelfieView = require(RobloxGui.Modules.SelfieView)

local GetFStringConnectTooltipLocalStorageKey = require(Chrome.Flags.GetFStringConnectTooltipLocalStorageKey)
local GetFIntRobloxConnectFtuxShowDelayMs = require(Chrome.Flags.GetFIntRobloxConnectFtuxShowDelayMs)
local GetFIntRobloxConnectFtuxDismissDelayMs = require(Chrome.Flags.GetFIntRobloxConnectFtuxDismissDelayMs)

local GetFFlagEnableAppChatInExperience = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableAppChatInExperience
local GetShouldShowPlatformChatBasedOnPolicy = require(Chrome.Flags.GetShouldShowPlatformChatBasedOnPolicy)
local bool1 = game:DefineFastFlag("FixInventoryFilledIcon", false)

local Flags = require(Chrome.ChromeShared.Flags)
local FFlagTokenizeUnibarConstantsWithStyleProvider = Flags.FFlagTokenizeUnibarConstantsWithStyleProvider

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagShowGameAgeRating = SharedFlags.FFlagShowGameAgeRating

local FFlagExperienceAgeRatingBadge = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagExperienceAgeRatingBadge
local MenuIconContext = require(script.Parent.Parent.Parent.TopBar.Components.MenuIconContext)
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls

local bool2 = game:DefineFastFlag("AppChatEnabledChromeDropdownFtuxTooltip", false)
local bool3 = game:DefineFastFlag("AvatarSwitcherFtuxTooltip", false)
local FFlagEnableInExperienceShop = game:DefineFastFlag("InExperienceShopFtuxTooltip", false) and SharedFlags.FFlagEnableInExperienceShop

local FFlagEnableAnyFreeTrialToolTip = require(CorePackages.Workspace.Packages.InExperienceShop.FFlagEnableAnyFreeTrialToolTip)

local FFlagChromeNineDotActivityIndicator = SharedFlags.FFlagOfferNineDotActivityIndicator and Flags.FFlagChromeNineDotActivityIndicator

local FFlagChromeNineDotActivityIndicator2 = require(CorePackages.Workspace.Packages.InExperienceShop.FFlagEnableFreeTrialBlueDot)
    and Flags.FFlagChromeNineDotActivityIndicator
local useInExperienceOfferExposure = require(Chrome.Integrations.InExperienceShop.useInExperienceOfferExposure)

local useOfferNineDotActivityIndicator = if FFlagChromeNineDotActivityIndicator then require(Chrome.Integrations.InExperienceShop.useOfferNineDotActivityIndicator) else nil

local useFreeTrialNineDotActivityIndicator = if FFlagChromeNineDotActivityIndicator2 then require(Chrome.Integrations.InExperienceShop.useFreeTrialNineDotActivityIndicator) else nil

local InExperienceShopFtuxTooltip = if FFlagEnableInExperienceShop then require(Chrome.Integrations.InExperienceShop.InExperienceShopFtuxTooltip) else nil

local MenuOfferTooltip = require(Chrome.Integrations.InExperienceShop.MenuOfferTooltip)
local usePublishShopAvailability = require(Chrome.Integrations.InExperienceShop.usePublishShopAvailability)

local FreeTrialToolTip = nil
local openInExperienceShopWindow = nil
if FFlagEnableAnyFreeTrialToolTip then
    FreeTrialToolTip = require(CorePackages.Workspace.Packages.InExperienceShop.FreeTrialToolTip)

    openInExperienceShopWindow = require(Chrome.Integrations.InExperienceShop.ShopWindowLayout).openInExperienceShopWindow
end

local priority = game:DefineFastInt("UnibarConnectTooltipPriority", 2000)

local num1 = game:DefineFastInt("TrialAvailableTooltipPriority", 1400)

local var1 = nil
var1 = FFlagEnableAnyFreeTrialToolTip and function(arg1) -- name: FreeTrialToolTipChrome
    local tooltipQueue = React.useContext(TooltipContext)
    return React.createElement(FreeTrialToolTip, {
        anchorRef = arg1.anchorRef,
        visible = arg1.visible,
        onOpenShop = arg1.onOpenShop,
        tooltipQueue = tooltipQueue,
        priority = num1
    })
end or var1

local shouldShowPlatformChatBasedOnPolicy = GetFFlagEnableAppChatInExperience() and bool2 and GetShouldShowPlatformChatBasedOnPolicy()

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local InExperienceUIVRIXP = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).InExperienceUIVRIXP

local SELFIE_VIEW_ID = Constants.SELFIE_VIEW_ID

local mappedSignal = MappedSignal.new(PlayerListManager:GetSetVisibleChangedEvent().Event, function()
    return PlayerListManager:GetSetVisible()
end)

local var2 = Service:register({
    id = "leaderboard",
    label = "CoreScripts.TopBar.Leaderboard",
    sideSheetPlacement = SideSheetPlacement.BelowFold,
    activated = function(_)
        if not isInExperienceUIVREnabled and VRService.VREnabled then
            require(RobloxGui.Modules.InGameMenu).openPlayersPage()
        elseif PlayerListManager:GetSetVisible()
            or isInExperienceUIVREnabled and isSpatial() and not InExperienceUIVRIXP:isMovePanelToCenter()
        then
            PlayerListManager:SetVisibility(not PlayerListManager:GetSetVisible())
        else
            ChromeIntegrationUtils.dismissRobloxMenuAndRun(function()
                PlayerListManager:SetVisibility(not PlayerListManager:GetSetVisible())
            end)
        end
    end,
    isActivated = mappedSignal,
    components = {
        Icon = function(_)
            return CommonIcon("icons/controls/leaderboardOff", "icons/controls/leaderboardOn", mappedSignal)
        end
    }
})
ChromeUtils.setCoreGuiAvailability(var2, Enum.CoreGuiType.PlayerList)

local mappedSignal2 = MappedSignal.new(EmotesMenuMaster.EmotesMenuToggled.Event, function()
    return EmotesMenuMaster:isOpen()
end)
local var3 = Service:register({
    id = "emotes",
    label = "CoreScripts.TopBar.Emotes",
    sideSheetPlacement = SideSheetPlacement.BelowFold,
    activated = function(_)
        if EmotesMenuMaster:isOpen() then
            EmotesMenuMaster:close()
        elseif isInExperienceUIVREnabled and isSpatial() and not InExperienceUIVRIXP:isMovePanelToCenter() then
            EmotesMenuMaster:open()
        else
            ChromeIntegrationUtils.dismissRobloxMenuAndRun(function()
                EmotesMenuMaster:open()
            end)
        end
    end,
    isActivated = mappedSignal2,
    components = {
        Icon = function(_)
            return CommonIcon("icons/controls/emoteOff", "icons/controls/emoteOn", mappedSignal2)
        end
    }
})

local bool4 = false
local MenuIsVisible = EmotesMenuMaster.MenuIsVisible

function updateEmoteAvailability()
    if bool4 and MenuIsVisible then
        var3.availability:available()
        return
    end
    var3.availability:unavailable()
end

ChromeUtils.setCoreGuiAvailability(var3, Enum.CoreGuiType.EmotesMenu, function(arg1)
    bool4 = arg1
    updateEmoteAvailability()
end)

EmotesMenuMaster.MenuVisibilityChanged.Event:Connect(function()
    MenuIsVisible = EmotesMenuMaster.MenuIsVisible
    updateEmoteAvailability()
end)

local mappedSignal3 = if FFlagEnableNewBackpack then nil else MappedSignal.new(BackpackScript.StateChanged.Event, function()
    return BackpackScript.IsOpen
end)

local var4

if FFlagEnableNewBackpack then
    local signal = Signal.new()
    Features.onVisibilityChanged(Features.FeatureName.Backpack, function()
        signal:fire()
        return nil
    end)
    var4 = MappedSignal.new(signal, function()
        return Features.getVisibility(Features.FeatureName.Backpack)
    end)
else
    var4 = mappedSignal3
end

if isSideSheetEnabled and FFlagSideSheetFocusNav and FFlagEnableConsoleExpControls then
    var4:connect(function(arg1)
        Service:setHideShortcutBar("Backpack", arg1)
    end)
end

local var5 = Service:register({
    id = "backpack",
    label = "CoreScripts.TopBar.Inventory",
    sideSheetPlacement = SideSheetPlacement.BelowFold,
    activated = function(_)
        if FFlagEnableNewBackpack then
            if Features.getVisibility(Features.FeatureName.Backpack)
                or isInExperienceUIVREnabled and isSpatial() and not InExperienceUIVRIXP:isMovePanelToCenter()
            then
                Features.toggleVisibility(Features.FeatureName.Backpack)
            else
                ChromeIntegrationUtils.dismissRobloxMenuAndRun(function()
                    Features.toggleVisibility(Features.FeatureName.Backpack)
                end)
            end
        elseif BackpackScript.IsOpen or isInExperienceUIVREnabled and isSpatial() and not InExperienceUIVRIXP:isMovePanelToCenter() then
            BackpackScript:OpenClose()
        else
            ChromeIntegrationUtils.dismissRobloxMenuAndRun(function()
                BackpackScript:OpenClose()
            end)
        end
    end,
    isActivated = var4,
    components = {
        Icon = function(_)
            return CommonIcon("icons/menu/inventoryOff", if bool1 then "icons/menu/inventoryOn" else "icons/menu/inventory", mappedSignal3)
        end
    }
})

ChromeUtils.setCoreGuiAvailability(var5, Enum.CoreGuiType.Backpack)

local var6 = Service:register({
    id = "respawn",
    label = "CoreScripts.InGameMenu.QuickActions.Respawn",
    sideSheetPlacement = SideSheetPlacement.BelowFold,
    activated = function(_)
        RespawnUtils.respawnPage()
    end,
    isActivated = RespawnUtils.respawnPageOpenSignal,
    components = {
        Icon = function(_)
            return CommonIcon("icons/actions/respawn")
        end
    }
})

function updateRespawn(arg1)
    if arg1 then
        var6.availability:available()
        return
    end
    var6.availability:unavailable()
end

task.defer(function()
    local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
    settingsHub.RespawnBehaviourChangedEvent.Event:connect(updateRespawn)
    updateRespawn(settingsHub:GetRespawnBehaviour())
end)

local var7 = Service:currentSubMenu()
local mappedSignal4 = MappedSignal.new(var7:signal(), function(): boolean
    return var7:get() == "nine_dot"
end)

if Service:orderAlignment():get() == Enum.HorizontalAlignment.Right then
    mappedSignal4:connect(function(arg1)
        PlayerListManager:SetMinimized(arg1)
    end)
end

function HamburgerButton(arg1)
    local toggleTransition = arg1.toggleTransition
    local var8 = useStyle()
    local anchorRef = React.useRef(nil)

    if not RunService:IsStudio()
        or FFlagChromeNineDotActivityIndicator
        or FFlagChromeNineDotActivityIndicator2
        or FFlagEnableAnyFreeTrialToolTip
    then
        usePublishShopAvailability()
    end

    if not RunService:IsStudio() or FFlagChromeNineDotActivityIndicator then
        useInExperienceOfferExposure()
    end

    if FFlagChromeNineDotActivityIndicator then
        useOfferNineDotActivityIndicator()
    end

    if FFlagChromeNineDotActivityIndicator2 then
        useFreeTrialNineDotActivityIndicator()
    end

    local iconSize, mediumIconSize

    if FFlagTokenizeUnibarConstantsWithStyleProvider then
        local var10 = UnibarStyle.use()
        iconSize = var10.ICON_SIZE
        mediumIconSize = var10.MEDIUM_ICON_SIZE
    else
        iconSize = Constants.ICON_SIZE
        mediumIconSize = Constants.MEDIUM_ICON_SIZE
    end

    local var10 = mappedSignal4 and useMappedSignal(mappedSignal4) or false
    local var11 = if shouldShowPlatformChatBasedOnPolicy then CommonFtuxTooltip({
        id = "CONNECT_TOOLTIP",
        priority = priority,
        isIconVisible = arg1.visible,
        headerKey = if GetFFlagIsSquadEnabled() then "CoreScripts.FTUX.Heading.CheckOutRobloxParty" else "CoreScripts.FTUX.Heading.CheckOutRobloxConnect",
        bodyKey = if GetFFlagIsSquadEnabled() then "CoreScripts.FTUX.Label.PartyWithYourFriendsAnytime" else "CoreScripts.FTUX.Label.ChatWithYourFriendsAnytime",
        localStorageKey = GetFStringConnectTooltipLocalStorageKey(),
        showDelay = GetFIntRobloxConnectFtuxShowDelayMs(),
        dismissDelay = GetFIntRobloxConnectFtuxDismissDelayMs()
    }) else nil

    local var12 = if FFlagShowGameAgeRating then useAppPolicy(function(arg2)
        return arg2.getShowGameAgeRating()
    end) else useAppPolicy(function(arg2)
        return arg2.getShowBadgeOver12()
    end)

    local replacesAgeRating = if FFlagExperienceAgeRatingBadge then React.useContext(MenuIconContext).replacesAgeRating else false
    local createElement = React.createElement
    local str1 = "Frame"

    local tbl1 = {
        Size = UDim2.new(0, iconSize, 0, iconSize),
        BorderSizePixel = 0,
        ref = if RunService:IsStudio() and not FFlagEnableAnyFreeTrialToolTip then nil else anchorRef,
        BackgroundColor3 = var8.Theme.BackgroundOnHover.Color,
        BackgroundTransparency = toggleTransition:map(function(arg2)
            return 1 - (1 - var8.Theme.BackgroundOnHover.Transparency) * arg2
        end)
    }
    local element = React.createElement("UICorner", { Name = "Corner", CornerRadius = UDim.new(1, 0) })
    local element2 = if isSideSheetEnabled then React.createElement(
        SelectionCursorProvider,
        {},
        {
            Icon = React.createElement(MenuIcon, { showBadgeOver12 = var12 and not replacesAgeRating })
        }
    ) else nil
    local element3

    if isSideSheetEnabled then
        element3 = nil
    else
        element3 = React.createElement(ImageSetLabel, {
            Name = "Overflow",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            Image = Images["icons/common/hamburgermenu"],
            Size = toggleTransition:map(function(arg2): UDim2
                arg2 = 1 - arg2
                return UDim2.new(0, iconSize * arg2, 0, iconSize * arg2)
            end),
            ImageColor3 = var8.Theme.IconEmphasis.Color,
            ImageTransparency = toggleTransition:map(function(arg2)
                return arg2 * var8.Theme.IconEmphasis.Transparency
            end)
        })
    end

    local element4 = if isSideSheetEnabled then nil else React.createElement(ImageSetLabel, {
        Name = "Close",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1,
        Image = Images["icons/navigation/close"],
        Size = toggleTransition:map(function(arg2): UDim2
            return UDim2.new(0, mediumIconSize * arg2, 0, mediumIconSize * arg2)
        end),
        ImageColor3 = var8.Theme.IconEmphasis.Color,
        ImageTransparency = toggleTransition:map(function(arg2)
            return (1 - arg2) * var8.Theme.IconEmphasis.Transparency
        end)
    })

    return createElement(str1, tbl1, {
        element,
        element2,
        element3,
        element4,
        if SelfieView.useCameraOn() and not (Service:isWindowOpen(SELFIE_VIEW_ID) or var10) then React.createElement(
            SelfieView.CameraStatusDot,
            {
                Name = "CameraStatusDot",
                Position = UDim2.new(1, -4, 1, -7),
                ZIndex = 2
            }
        ) else nil,
        var11,
        if bool3 then React.createElement(AvatarSwitcherFtuxTooltip, { visible = arg1.visible }) else nil,
        if FFlagEnableInExperienceShop then React.createElement(InExperienceShopFtuxTooltip, { visible = arg1.visible }) else nil,
        if RunService:IsStudio() then nil else React.createElement(MenuOfferTooltip, { anchorRef = anchorRef, visible = arg1.visible }),
        if FFlagEnableAnyFreeTrialToolTip then React.createElement(var1, { anchorRef = anchorRef, visible = arg1.visible, onOpenShop = openInExperienceShopWindow }) else nil
    })
end

return Service:register({
    initialAvailability = Service.AvailabilitySignal.Pinned,
    id = "nine_dot",
    label = if isSideSheetEnabled then "CoreScripts.TopBar.RobloxMenu" else "CoreScripts.TopBar.MoreMenu",
    sideSheetPlacement = SideSheetPlacement.None,
    hotkeyCodes = isSideSheetEnabled and { Enum.KeyCode.Escape } or nil,
    isActivated = mappedSignal4,
    components = {
        Icon = function(arg1)
            return React.createElement(HamburgerButton, arg1)
        end
    }
})
