-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local useTokens = require(InExperienceShopParent.Foundation).Hooks.useTokens
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization
local SignalsReact = require(InExperienceShopParent.SignalsReact)
local isSideSheetEnabled = require(InExperienceShopParent.InExperienceSideSheetUtils.isSideSheetEnabled)

local Constants = require(InExperienceShop.Constants)
local SharedFlags = require(InExperienceShopParent.SharedFlags)
local AbuseVector = require(InExperienceShopParent.GenericAbuseReporting.AbuseVector)
local useShopReportOverflow = require(InExperienceShop.Hooks.useShopReportOverflow)

local _Types = require(InExperienceShop.Types)

local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local FFlagCloseShopOnTrialRedemption = require(InExperienceShop.Flags.FFlagCloseShopOnTrialRedemption)
local FFlagShopRobuxPurchaseCompletionModal = require(InExperienceShop.Flags.FFlagShopRobuxPurchaseCompletionModal)
local formatPrice = require(InExperienceShop.Utils.formatPrice)
local GetFixRobuxTileClickInShop = require(InExperienceShop.Flags.GetFixRobuxTileClickInShop)
local shopItemSelection = require(InExperienceShop.Utils.shopItemSelection)
local resolveItemForSelection = shopItemSelection.resolveItemForSelection
local useShopOfferChip = require(InExperienceShop.Hooks.useShopOfferChip)
local InExperienceOffers = require(InExperienceShopParent.InExperienceOffers)
local FFlagHideHeaderForBuyRobuxInExperienceShop = SharedFlags.FFlagHideHeaderForBuyRobuxInExperienceShop

local tbl1 = { homeLabel = "CommonUI.Features.Label.Home" }

local _ShopView = require(script.Parent.ShopView)

local function isQueryValid(str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local _, var1 = string.gsub(str1, " ", "")
    return #str1 - var1 >= Constants.SEARCH_MIN_LENGTH
end

local var1 = nil

local function useShopViewModel(tbl2)
    local var2 = useTokens()
    local var3 = useLocalization(tbl1)
    local fixRobuxTileClickInShop = GetFixRobuxTileClickInShop()
    local var4 = SignalsReact.useSignalState(getInExperienceShopStore)
    local var5 = SignalsReact.useSignalState(var4.getCategories)
    local var6 = SignalsReact.useSignalState(var4.getSections)
    local itemsPerRow = SignalsReact.useSignalState(var4.getItemsPerRow)
    local var8 = SignalsReact.useSignalState(var4.getShouldOpenToRobuxTab)
    local var9 = SignalsReact.useSignalState(var4.getOpenedFromBuyRobux)
    local var10 = nil
    if FFlagShopRobuxPurchaseCompletionModal then
        local var11 = SignalsReact.useSignalState(var4.getPurchasedRobuxAmount)
        React.useEffect(function(): (() -> ())?
            return if var11 == nil then nil else function()
                if var4.getPurchasedRobuxAmount(false) == var11 then
                    var4.dismissRobuxPurchaseSuccess()
                end
            end
        end, { var11, var4 })
        local var12 = useLocalization({
            bodyText = var11 ~= nil and {
                "Feature.InExperienceShop.Message.RobuxPurchaseSuccess",
                ROBUX_AMOUNT = formatPrice(var11)
            } or nil
        })

        var10 = var11 ~= nil and {
            bodyText = var12.bodyText,
            onClose = var4.dismissRobuxPurchaseSuccess
        } or var10
    end

    if FFlagCloseShopOnTrialRedemption then
        local current = SignalsReact.useSignalState(var4.getTrialRedeemSuccessCount)

        local var12 = SignalsReact.useSignalState(var4.getNotificationFreeTrialTopBarChip)
        local var13 = React.useRef(current)
        React.useEffect(function()
            local current2 = var13.current

            var13.current = current
            if current2 < current and var12 then
                tbl2.toggleWindow()
            end
        end, { current, var12, tbl2.toggleWindow })
    end

    local var11 = React.useMemo(function()
        return var1(var5, var6)
    end, { var5, var6 })

    local homeLabel = var3.homeLabel
    local tabs = React.useMemo(function()
        local var12 = table.create(#var11.categories)
        for value, value2 in var11.categories do
            local text = if value2.id == "home" then homeLabel else value2.name
            local tbl3 = {
                id = value2.id,
                text = text
            }
            var12[value] = tbl3
        end
        return var12
    end, { var11.categories, homeLabel })

    local var13 = React.useCallback(function()
        if not isSideSheetEnabled then
            return nil
        end
        for _, value in var11.categories do
            if value.name == "Robux" then
                return value.id
            end
        end
        return nil
    end, { var11.categories })

    local selectedCategoryId, var15 = React.useState(function()
        if isSideSheetEnabled and var8 then
            local var14 = var13()
            if var14 ~= nil then
                return var14
            end
        end

        if #var11.categories > 0 then
            return var11.categories[1].id
        end

        return ""
    end)

    local var16, var17 = React.useState(function()
        return nil
    end)
    local var18, var19 = React.useState(function()
        return nil
    end)
    React.useEffect(function()
        local categories = var11.categories
        if #categories == 0 then
            return
        end
        var15(function(id)
            for _, value in categories do
                if value.id == id then
                    return id
                end
            end
            return categories[1].id
        end)
    end, { var11.categories })

    React.useEffect(function()
        if not isSideSheetEnabled or not var8 or not (#var11.categories > 0) then
            return
        end

        var4.setShouldOpenToRobuxTab(false)
        local var20 = var13()
        if var20 ~= nil then
            var15(var20)
        end
    end, {
        var13,
        var11.categories,
        var8,
        var4.setShouldOpenToRobuxTab
    })

    local var20

    if FFlagHideHeaderForBuyRobuxInExperienceShop then
        var20 = React.useMemo(function()
            if #var11.categories ~= 2 then
                return false
            end
            local bool1 = false
            local bool2 = false
            for _, value in var11.categories do
                if value.name == "CommonUI.Features.Label.Home" then
                    bool1 = true
                elseif value.name == "Robux" then
                    bool2 = true
                end
            end

            return bool1 and bool2
        end, { var11.categories })

        React.useEffect(function()
            return function()
                var4.setOpenedFromBuyRobux(false)
            end
        end, { var4.setOpenedFromBuyRobux })
    else
        var20 = false
    end

    React.useEffect(function()
        if var16 == nil or var18 == nil then
            return
        end

        if resolveItemForSelection(var11.sections, var16, var18, fixRobuxTileClickInShop) == nil then
            var17(nil)
            var19(nil)
        end
    end, {
        var11.sections,
        var16,
        var18,
        fixRobuxTileClickInShop
    })
    local selectedItem = React.useMemo(function()
        return resolveItemForSelection(var11.sections, var16, var18, fixRobuxTileClickInShop)
    end, {
        var11.sections,
        var16,
        var18,
        fixRobuxTileClickInShop
    })
    local selectedItemDisableBuy = React.useMemo(function()
        return shopItemSelection.isRobuxBonusOnlySelection(var11.sections, var16, var18, fixRobuxTileClickInShop)
    end, {
        var11.sections,
        var16,
        var18,
        fixRobuxTileClickInShop
    })

    local onCategorySelected = React.useCallback(function(arg1)
        var15(arg1)
    end, {})

    local searchQuery, var25 = React.useState("")
    local committedQuery, var27 = React.useState("")

    React.useEffect(function()
        if not isQueryValid(searchQuery) then
            var27("")
            return
        end

        local bool1 = false
        task.delay(Constants.SEARCH_DEBOUNCE_SECONDS, function()
            if bool1 then
                return
            end
            var27(searchQuery)
        end)
        return function()
            bool1 = true
        end
    end, { searchQuery })

    local onSearchQueryChanged = React.useCallback(function(str1: string)
        var25(str1)
    end, {})

    local onSearchSubmit = React.useCallback(function(str1: string)
        var25(str1)

        if isQueryValid(str1) then
            var27(str1)
            return
        end
        var27("")
    end, {})

    local onItemActivated = React.useCallback(function(str1: string, arg1)
        if arg1 ~= nil and resolveItemForSelection(var11.sections, str1, arg1, fixRobuxTileClickInShop) ~= nil then
            var17(str1)
            var19(arg1)
        end
    end, { var11.sections, fixRobuxTileClickInShop })

    local onDetailsClose = React.useCallback(function()
        var17(nil)
        var19(nil)
    end, {})

    local isSearchOpen, var33 = React.useState(false)

    local onSearchOpen = React.useCallback(function()
        var33(true)
    end, {})

    local onSearchCancel = React.useCallback(function()
        var33(false)
        var25("")
        var27("")
    end, {})

    local setItemsPerRow = var4.setItemsPerRow

    local var36, var37 = React.useState(false)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X
        if absoluteSizeX == 0 then
            return
        end

        local num1 = math.floor(absoluteSizeX / Constants.MIN_TILE_WIDTH)
        local num2 = math.max(Constants.MIN_COLUMNS, math.min(Constants.ITEMS_PER_SECTION, num1))
        setItemsPerRow(num2)
        var37(absoluteSizeX < Constants.COMPACT_BREAKPOINT_WIDTH)
    end, { setItemsPerRow, var37 })

    local fFlagEnableReportingFlowForExperienceShop = SharedFlags.FFlagEnableReportingFlowForExperienceShop

    local buildReportSession = React.useCallback(function()
        return {
            abuseVector = AbuseVector.InExperienceShop,
            targetId = tostring(game.PlaceId)
        }
    end, {})

    local var40 = useShopReportOverflow.useShopReportOverflow(
        {
            isReportingEnabled = fFlagEnableReportingFlowForExperienceShop,
            buildReportSession = buildReportSession
        }
    )

    local offer = useShopOfferChip(InExperienceOffers.FeatureKeys.RobloxShop, var36)

    return {
        fullScreen = tbl2.fullScreen,
        overMediaColor = var2.Color.OverMedia.OverMedia_0.Color3,
        overMediaTransparency = var2.Color.OverMedia.OverMedia_0.Transparency,
        onClose = tbl2.toggleWindow,
        robuxPurchaseSuccess = var10,
        tabs = tabs,
        hideTabs = FFlagHideHeaderForBuyRobuxInExperienceShop and var9 and var20,
        selectedCategoryId = selectedCategoryId,
        onCategorySelected = onCategorySelected,
        searchQuery = searchQuery,
        committedQuery = committedQuery,
        onSearchQueryChanged = onSearchQueryChanged,
        onSearchSubmit = onSearchSubmit,
        isSearchOpen = isSearchOpen,
        onSearchOpen = onSearchOpen,
        onSearchCancel = onSearchCancel,
        sections = var11.sections,
        selectedItem = selectedItem,
        selectedItemDisableBuy = selectedItemDisableBuy,
        onItemActivated = onItemActivated,
        onDetailsClose = onDetailsClose,
        itemsPerRow = itemsPerRow,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        isReportingEnabled = var40.isReportingEnabled,
        isOverflowMenuOpen = var40.isOverflowMenuOpen,
        topBarReportSession = var40.reportSession,
        onOverflowActivated = var40.onOverflowActivated,
        onOverflowMenuClosed = var40.onOverflowMenuClosed,
        onMenuItemActivated = var40.onMenuItemActivated,
        onTopBarReportClose = var40.onReportClose,
        offer = offer
    }
end

var1 = function(tbl2, sections)
    local tbl3 = {}
    for _, section in sections do
        tbl3[section.id] = true
    end

    local bool1 = #sections > 0

    local categories = {}
    for _, value in tbl2 do
        if tbl3[value.id] or bool1 then
            table.insert(categories, value)
        end
    end

    return { categories = categories, sections = sections }
end

return useShopViewModel
