-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)
local Service = require(Chrome.Service)
local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local WindowSizeSignal = require(Chrome.ChromeShared.Service.WindowSizeSignal)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local initializeShopMenuController = require(Chrome.Integrations.InExperienceShop.initializeShopMenuController)
local ShopChromeWrapper = require(Chrome.Integrations.InExperienceShop.ShopChromeWrapper)
local ShopWindowLayout = require(Chrome.Integrations.InExperienceShop.ShopWindowLayout)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local MappedSignal = ChromeUtils.MappedSignal
local SideSheetPlacement = Chrome2.Enums.SideSheetPlacement

local InExperienceShop = require(CorePackages.Workspace.Packages.InExperienceShop)
local FFlagEnableFreeTrialBlueDot = InExperienceShop.FFlagEnableFreeTrialBlueDot
local FFlagEnableShopPrefetch = InExperienceShop.FFlagEnableShopPrefetch
local FFlagHideShopMenuOnFailure = InExperienceShop.FFlagHideShopMenuOnFailure
local FFlagCenterInExperienceShopWindow = InExperienceShop.FFlagCenterInExperienceShopWindow
local FFlagFixInExperienceShopCursorLock = InExperienceShop.FFlagFixInExperienceShopCursorLock
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableMenuTrailingBadge = SharedFlags.FFlagEnableMenuTrailingBadge
local FFlagShowOfferBadge = SharedFlags.FFlagShowOfferBadge
local FFlagExperienceShopNewIconography = InExperienceShop.FFlagExperienceShopNewIconography

local FFlagEnableAnyFreeTrialToolTip = require(CorePackages.Workspace.Packages.InExperienceShop.FFlagEnableAnyFreeTrialToolTip)
local FFlagEnableFreeTrialShopMenuBadge = InExperienceShop.FFlagEnableFreeTrialShopMenuBadge
local FFlagMenuBadgePreferFreeTrialOverOffer = InExperienceShop.FFlagMenuBadgePreferFreeTrialOverOffer

local engineFeature = game:GetEngineFeature("ShopCoreGuiToggleSupported")
local engineFeature2 = game:GetEngineFeature("EnableOpenShopSignal")

local mappedSignal = MappedSignal.new(Service:onIntegrationStatusChanged(), function()
    return Service:isWindowOpen(Constants.IN_EXPERIENCE_SHOP_ID)
end)

local MAX_WINDOW_WIDTH = ShopWindowLayout.MAX_WINDOW_WIDTH
local MAX_WINDOW_HEIGHT = ShopWindowLayout.MAX_WINDOW_HEIGHT

local windowSizeSignal = WindowSizeSignal.new(MAX_WINDOW_WIDTH, MAX_WINDOW_HEIGHT, false, true)

local localStorageKey = game:DefineFastString("InExperienceShopNewBadgeStorageKey", "InExperienceShopNewBadgeStorageKey")

local num1 = game:DefineFastInt("NewBadgeDismissalMaxCountInExperienceShop", 5)
local var1 = game:DefineFastFlag("EnableNewBadgeInExperienceShop", false) and FFlagEnableMenuTrailingBadge

local var2 = nil
local offerBadgeTextSignal = nil
local dismiss = nil
if FFlagShowOfferBadge then
    local inExperienceOffers = require(CorePackages.Workspace.Packages.InExperienceOffers)

    offerBadgeTextSignal = inExperienceOffers.Utils.createOfferBadgeTextSignal(inExperienceOffers.FeatureKeys.RobloxShop)
    var2 = offerBadgeTextSignal
end

if FFlagEnableFreeTrialShopMenuBadge then
    local submitFreeTrialMenuBadge = require(CorePackages.Workspace.Packages.InExperienceShop.submitFreeTrialMenuBadge)
    local var3 = submitFreeTrialMenuBadge()

    var2 = FFlagMenuBadgePreferFreeTrialOverOffer and offerBadgeTextSignal ~= nil and function(arg1)
        local var4 = var3(arg1)
        if var4 ~= nil then
            return var4
        end
        return offerBadgeTextSignal(arg1)
    end or offerBadgeTextSignal ~= nil and function(arg1)
        local var4 = offerBadgeTextSignal(arg1)
        if var4 ~= nil then
            return var4
        end
        return var3(arg1)
    end or var3

    dismiss = submitFreeTrialMenuBadge.dismiss

    local bool1 = false
    local function reportTrialBadgeSeen()
        if bool1 or var3(false) == nil then
            return
        end

        if not FFlagMenuBadgePreferFreeTrialOverOffer then
            local var4 = offerBadgeTextSignal
            if var4 ~= nil and var4(false) ~= nil then
                return
            end
        end
        if not Service:withinCurrentSubmenu(Constants.IN_EXPERIENCE_SHOP_ID) then
            return
        end
        bool1 = true
        submitFreeTrialMenuBadge.reportMounted()
        submitFreeTrialMenuBadge.reportViewed()
    end

    Service:currentSubMenu():connect(function()
        if not Service:withinCurrentSubmenu(Constants.IN_EXPERIENCE_SHOP_ID) then
            bool1 = false
            return
        end
        reportTrialBadgeSeen()
    end)

    Signals.createEffect(function(arg1)
        var3(arg1)
        if not FFlagMenuBadgePreferFreeTrialOverOffer then
            local var4 = offerBadgeTextSignal
            if var4 ~= nil then
                var4(arg1)
            end
        end
        reportTrialBadgeSeen()
    end)
end

local menuTrailingBadgeConfig = (var1 or var2 ~= nil)
    and {
        localStorageKey = localStorageKey,
        maxViewCount = if var1 then num1 else 0,
        customText = var2
    }
    or nil
local bool1

if engineFeature then
    bool1 = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.All)
    bool1 = bool1 or StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.ExperienceShop)
else
    bool1 = false
end

local bool2 = true

local function getInitialAvailability() -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 and not FFlagHideShopMenuOnFailure then
        return Service.AvailabilitySignal.Available
    end

    bool2 = false
    return Service.AvailabilitySignal.Unavailable
end

local function toggleShopWindow() -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagCenterInExperienceShopWindow then
        ShopWindowLayout.toggleInExperienceShopWindow()
        return
    end
    Service:toggleWindow(Constants.IN_EXPERIENCE_SHOP_ID)
end

local function dismissTrialBadgeIfShopIsClosed() -- Luacid: Inlined by compiler; 2 call sites recovered
    if dismiss ~= nil and not Service:isWindowOpen(Constants.IN_EXPERIENCE_SHOP_ID) then
        dismiss()
    end
end

local var4 = Service:register({
    initialAvailability = getInitialAvailability(),
    id = Constants.IN_EXPERIENCE_SHOP_ID,
    sideSheetPlacement = SideSheetPlacement.AboveFold,
    label = "Feature.Avatar.Action.Shop",
    cachePosition = true,
    draggable = true,
    windowSize = windowSizeSignal,
    startingWindowPosition = ShopWindowLayout.getStartingWindowPosition(),
    activated = function(_)
        dismissTrialBadgeIfShopIsClosed()
        toggleShopWindow()
    end,
    menuTrailingBadgeConfig = menuTrailingBadgeConfig,
    isActivated = mappedSignal,
    components = {
        Icon = function()
            return CommonIcon(if FFlagExperienceShopNewIconography then "ShoppingBasket" else "BuildingStore", nil, mappedSignal)
        end,
        Window = function()
            return React.createElement(
                ShopChromeWrapper,
                {
                    windowSize = windowSizeSignal,
                    maxWindowWidth = MAX_WINDOW_WIDTH,
                    maxWindowHeight = MAX_WINDOW_HEIGHT
                }
            )
        end
    }
})
if FFlagFixInExperienceShopCursorLock then
    initializeShopMenuController(GuiService, mappedSignal)
end

if FFlagEnableShopPrefetch then
    local prefetchShopDataOnGameJoin = require(CorePackages.Workspace.Packages.InExperienceShop.prefetchShopDataOnGameJoin)
    if FFlagHideShopMenuOnFailure then
        task.spawn(prefetchShopDataOnGameJoin, function(bool3: boolean)
            if not bool3 then
                return
            end

            bool2 = true
            if bool1 then
                var4.availability:available()
            end
        end)
    else
        task.spawn(prefetchShopDataOnGameJoin)
    end
end

if FFlagEnableAnyFreeTrialToolTip then
    require(CorePackages.Workspace.Packages.InExperienceShop.submitFreeTrialTooltips)()
end

if FFlagEnableFreeTrialBlueDot then
    require(CorePackages.Workspace.Packages.InExperienceShop.submitFreeTrialBlueDot)()
end

if engineFeature2 then
    MarketplaceService.OpenShopRequested:Connect(function(player: Player)
        if player ~= Players.LocalPlayer then
            return
        end

        if FFlagHideShopMenuOnFailure and not bool2 then
            return
        end
        if not Service:isWindowOpen(Constants.IN_EXPERIENCE_SHOP_ID) then
            dismissTrialBadgeIfShopIsClosed()
            toggleShopWindow()
        end
    end)
end

if engineFeature then
    local function updateShopAvailability() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool1 and (not FFlagHideShopMenuOnFailure or bool2) then
            var4.availability:available()
            return
        end
        if Service:isWindowOpen(Constants.IN_EXPERIENCE_SHOP_ID) then
            Service:toggleWindow(Constants.IN_EXPERIENCE_SHOP_ID)
        end
        var4.availability:unavailable()
    end

    ChromeUtils.setCoreGuiAvailability(var4, Enum.CoreGuiType.ExperienceShop, function(arg1)
        bool1 = arg1
        updateShopAvailability()
    end)
end

return var4
