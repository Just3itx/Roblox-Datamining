-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local InExperienceOffers = require(CorePackages.Workspace.Packages.InExperienceOffers)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local useMappedSignal = require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal

local FFlagOfferNotifyOnGlobalIcon = SharedFlags.FFlagOfferNotifyOnGlobalIcon
local FFlagHideOfferNotificationsWhenShopEmpty = SharedFlags.FFlagHideOfferNotificationsWhenShopEmpty
local InExperienceShop = nil
local toggleInExperienceShopWindow = nil
if FFlagOfferNotifyOnGlobalIcon then
    InExperienceShop = require(CorePackages.Workspace.Packages.InExperienceShop)

    toggleInExperienceShopWindow = require(Chrome.Integrations.InExperienceShop.ShopWindowLayout).toggleInExperienceShopWindow
end

local Service = require(Chrome.Service)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local TooltipContext = require(Chrome.ChromeShared.Unibar.Tooltips.TooltipContext)
local useIsTooltipTurn = require(Chrome.ChromeShared.Unibar.Tooltips.useIsTooltipTurn)

local EducationalTooltip = Foundation.EducationalTooltip
local OverlayProvider = Foundation.OverlayProvider
local ButtonVariant = Foundation.Enums.ButtonVariant
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local FeatureKeys = InExperienceOffers.FeatureKeys
local getOffersStore = InExperienceOffers.getOffersStore
local isNotificationEligible = InExperienceOffers.Utils.isNotificationEligible
local selectActiveOffer = InExperienceOffers.Utils.selectActiveOffer
local useOffersForKey = InExperienceOffers.Hooks.useOffersForKey
local useShopHasItems = InExperienceOffers.Hooks.useShopHasItems
local useSignalState = SignalsReact.useSignalState

local num1 = game:DefineFastInt("MenuOfferTooltipPriority", 1500)
local num2 = game:DefineFastInt("MenuOfferTooltipShowDelayMs", 1500)
local num3 = game:DefineFastInt("MenuOfferTooltipDismissDelayMs", 7000)

local function MenuOfferTooltipContent(tbl1)
    local var1 = useOffersForKey(FeatureKeys.RobloxShop)

    local var2 = useSignalState(getOffersStore(false).getOfferExposureSnapshot)

    local var3 = React.useMemo(function()
        if var1 == nil or var2 == nil then
            return nil
        end
        local tbl2 = {}
        for _, value in var1 do
            if isNotificationEligible(value, var2) then
                table.insert(tbl2, value)
            end
        end
        return selectActiveOffer(tbl2, "tooltip")
    end, { var1, var2 })

    local var4, var5 = React.useState(false)

    React.useEffect(function()
        var5(not (tbl1.anchorRef == nil) and tbl1.anchorRef.current ~= nil)
    end, { tbl1.anchorRef })

    local var6, var7 = React.useState(false)

    local var8 = React.useCallback(function()
        var7(true)
    end, {})

    local onActivated = React.useCallback(function()
        var8()
        local inExperienceShopId = Constants.IN_EXPERIENCE_SHOP_ID
        if Service:isWindowOpen(inExperienceShopId) then
            return
        end

        if Service:isIntegrationValid(inExperienceShopId) then
            Service:activate(inExperienceShopId)
        elseif toggleInExperienceShopWindow and getOffersStore(false).getIsInExperienceShopGlobalIconAvailable(false) then
            toggleInExperienceShopWindow()
        end
    end, { var8 })

    local tooltip = if var3 == nil then nil else var3.presentationData.tooltip
    local offerId = if var3 == nil then nil else var3.offerId
    local current = React.useContext(TooltipContext)
    local var11 = useIsTooltipTurn("MENU_OFFER_TOOLTIP") or false

    local var12 = React.useRef(current)
    React.useEffect(function()
        var12.current = current
    end, { current })

    local var13 = Service:integrations()[Constants.IN_EXPERIENCE_SHOP_ID]
    local bool1 = useMappedSignal(if var13 then var13.availability else nil) == Service.AvailabilitySignal.Available
    local var14 = if FFlagOfferNotifyOnGlobalIcon then useSignalState(getOffersStore(false).getHasInExperienceShopOpened) else false
    local var15 = FFlagHideOfferNotificationsWhenShopEmpty and not useShopHasItems()

    local bool2 = false

    if tooltip ~= nil then
        bool2 = false

        if tbl1.visible == true then
            bool2 = bool1

            if bool2 then
                bool2 = var4
                bool2 = bool2 and not var6
            end
        end
    end

    if FFlagOfferNotifyOnGlobalIcon then
        bool2 = not (tooltip == nil or tbl1.visible ~= true) and var4 and not (var6 or var14)
    end
    if var15 then
        bool2 = false
    end

    React.useEffect(function()
        local current = var12.current
        if not bool2 or current == nil then
            return nil
        end

        current.registerTooltip("MENU_OFFER_TOOLTIP", num1, num2, num3)

        return function()
            current.unregisterTooltip("MENU_OFFER_TOOLTIP")
        end
    end, { bool2, offerId })

    local var16 = bool2 and var11

    React.useEffect(function()
        if not bool2 then
            return nil
        end

        local connection = Service:onIntegrationActivated():connect(function()
            var8()
        end)
        local connection2 = GuiService.MenuOpened:Connect(function()
            var8()
        end)

        return function()
            connection:disconnect()
            connection2:Disconnect()
        end
    end, { bool2, var8 })

    if tooltip == nil or not var16 then
        return nil
    end

    local actions = {{
        text = tooltip.buttonText,
        variant = ButtonVariant.Emphasis,
        onActivated = onActivated
    }}

    return React.createElement(OverlayProvider, nil, {
        Tooltip = React.createElement(EducationalTooltip, {
            anchorRef = tbl1.anchorRef,
            title = tooltip.title .. string.rep(" ", 10),
            side = PopoverSide.Bottom,
            align = PopoverAlign.Start,
            isOpen = true,
            actions = actions,
            onClose = var8,
            onPressedOutside = var8,
            testId = "menu-offer-tooltip"
        })
    })
end

return React.memo(function(tbl1) -- name: MenuOfferTooltip
    if FFlagOfferNotifyOnGlobalIcon then
        local var1 = useSignalState(getOffersStore(false).getIsInExperienceShopGlobalIconAvailable)

        local var2 = Service:integrations()[Constants.IN_EXPERIENCE_SHOP_ID]
        local bool1 = useMappedSignal(if var2 then var2.availability else nil) == Service.AvailabilitySignal.Available

        local current = useSignalState(function(arg1)
            local getShopGlobalIconStore = InExperienceShop.GetShopGlobalIconStore
            if getShopGlobalIconStore then
                return (getShopGlobalIconStore(arg1).getIconInstance(arg1))
            end

            return nil
        end)
        local anchorRef = React.useRef(current)
        anchorRef.current = current

        if var1 then
            if anchorRef.current ~= nil then
                return React.createElement(MenuOfferTooltipContent, { anchorRef = anchorRef, visible = true })
            end

            return nil
        end

        if not bool1 then
            return nil
        end
    end

    return React.createElement(MenuOfferTooltipContent, tbl1)
end)
