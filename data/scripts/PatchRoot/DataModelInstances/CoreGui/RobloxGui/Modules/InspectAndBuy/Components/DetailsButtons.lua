-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Constants = require(scriptParentParent.Constants)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)
local FavoritesButton = require(scriptParentParent.Components.FavoritesButton)
local TryOnButton = require(scriptParentParent.Components.TryOnButton)
local BuyButton = require(scriptParentParent.Components.BuyButton)
local InspectAndBuyControllerBar = require(scriptParentParent.Components.InspectAndBuyControllerBar)
local GetIsFavorite = require(scriptParentParent.Selectors.GetIsFavorite)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local tutils = require(CorePackages.Packages.tutils)

local GetFFlagIBGateUGC4ACollectibleAssetsBundles = require(scriptParentParent.Flags.GetFFlagIBGateUGC4ACollectibleAssetsBundles)

local GetFFlagIBEnableCollectiblesSystemSupport = require(scriptParentParent.Flags.GetFFlagIBEnableCollectiblesSystemSupport)

local var1 = Roact.PureComponent:extend("DetailsButtons")

local function isAnimationAsset(assetTypeId): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return Constants.AnimationAssetTypes[assetTypeId] ~= nil
end

local function getBuyText(arg1, arg2, arg3, arg4)
    local price = nil

    local var2 = arg1.isLimited or GetFFlagIBEnableCollectiblesSystemSupport() and arg1.isLimitedUnique

    if arg4 then
        return (RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Action.FromResale", arg2, { PRICE = tostring(arg4) }))
    end
    if arg3 and arg1.isForSale then
        return (RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Action.LimitReached", arg2))
    end
    if arg1.price ~= nil and arg1.productType == Constants.ProductType.CollectibleItem and arg1.isForSale then
        return arg1.price
    end

    if arg1.owned then
        return (RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.Owned", arg2))
    end

    if var2 then
        return (RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.Limited", arg2))
    end

    if not (arg1.isForSale or var2) then
        return (RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.Offsale", arg2))
    end

    if arg1.isForSale then
        if arg1.premiumPricing ~= nil then
            if Players.LocalPlayer.MembershipType == Enum.MembershipType.Premium then
                return arg1.premiumPricing.premiumPriceInRobux
            elseif arg1.price == nil then
                return (RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.PremiumOnly", arg2))
            end
            return arg1.price
        end

        price = arg1.price
    end

    return price
end

function var1.init(arg1)
    arg1.tryOnButtonRef = Roact.createRef()
    arg1.buyButtonRef = Roact.createRef()
    arg1.favoriteButtonRef = Roact.createRef()
end

function var1.didUpdate(arg1, arg2)
    local detailsInformation = arg1.props.detailsInformation
    local gamepadEnabled = arg1.props.gamepadEnabled

    if detailsInformation.viewingDetails then
        local visible = arg1.props.visible

        if gamepadEnabled and visible then
            GuiService.SelectedCoreObject = arg1.favoriteButtonRef.current
        end
    elseif arg1.props.assetInfo.bundlesAssetIsIn == nil and detailsInformation.viewingDetails and gamepadEnabled then
        GuiService.SelectedCoreObject = nil
    end

    local overlay = arg1.props.overlay
    local overlay2 = arg2.overlay
    if gamepadEnabled and overlay and overlay.overlay == nil and overlay2 and overlay2.overlay ~= nil then
        GuiService.SelectedCoreObject = arg1.tryOnButtonRef.current
    end
end

function var1.calculateBuyStatusForLimitedItem(arg1, arg2, arg3, arg4)
    local var2 = UtilityFunctions.isLimited2Point0_Or_LimitedCollectible(arg2)
    local var3 = UtilityFunctions.isLimited1Point0(arg2) or UtilityFunctions.isLimited1Point0_LimitedUnique(arg2)
    local var4 = nil
    local collectibleLowestResalePrice = nil
    local collectibleLowestAvailableResaleItemInstanceId = nil
    local collectibleLowestAvailableResaleProductId = nil
    local collectibleItemId = nil

    if var2 then
        arg4 = arg2.isForSale

        local resellableInstances = arg1.props.resellableInstances
        var4 = resellableInstances
            and resellableInstances[arg2.collectibleItemId]
            and tutils.fieldCount(resellableInstances[arg2.collectibleItemId])
        if var4 then
            if arg2.collectibleQuantityLimitPerUser == nil or not (arg2.collectibleQuantityLimitPerUser > 0) then
                var4 = false
            else
                var4 = arg2.collectibleQuantityLimitPerUser <= var4
            end
        end

        local var5 = arg2.collectibleLowestAvailableResaleProductId and arg2.collectibleLowestAvailableResaleProductId ~= ""
        local var6 = if arg2.remaining > 0 then var5 and (arg2.price or 0) > arg2.collectibleLowestResalePrice else var5 and arg2.collectibleLowestResalePrice

        if var5 then
            if not arg4 or var4 or var6 then
                collectibleLowestResalePrice = arg2.collectibleLowestResalePrice
                collectibleLowestAvailableResaleItemInstanceId = arg2.collectibleLowestAvailableResaleItemInstanceId
                collectibleLowestAvailableResaleProductId = arg2.collectibleLowestAvailableResaleProductId
                collectibleItemId = arg2.collectibleItemId
                arg4 = true
            end
        elseif var4 then
            arg4 = false
        end
    else
        arg4 = arg2.isForSale and not (arg2.owned or var3)
    end

    if arg4 and arg2.price == nil and arg2.premiumPricing ~= nil then
        arg4 = Players.LocalPlayer.MembershipType == Enum.MembershipType.Premium
    end
    return {
        buyText = getBuyText(arg2, arg3, var4, collectibleLowestResalePrice),
        showRobuxIcon = if arg2.price ~= nil and not arg2.owned and arg4 then arg4 else collectibleLowestResalePrice ~= nil
            or not (arg2.price == nil) and arg2.productType == Constants.ProductType.CollectibleItem and arg4,
        forSale = arg4,
        collectibleQuantityLimitReached = var4,
        collectibleLowestResalePrice = collectibleLowestResalePrice,
        collectibleLowestAvailableResaleItemInstanceId = collectibleLowestAvailableResaleItemInstanceId,
        collectibleLowestAvailableResaleProductId = collectibleLowestAvailableResaleProductId,
        collectibleItemId = collectibleItemId
    }
end

function var1.render(arg1)
    local locale = arg1.props.locale
    local assetInfo = arg1.props.assetInfo

    local forSale = nil
    local bundleId = nil
    local bool1, bool2, var2, assetId, buyText, showRobuxIcon, collectibleLowestResalePrice, collectibleLowestAvailableResaleProductId, collectibleLowestAvailableResaleItemInstanceId, collectibleItemId, bool3

    if assetInfo then
        bool1 = assetInfo.parentBundleId ~= nil

        bool2 = bool1 and not assetInfo.isForSale

        if bool1 then
            bundleId = UtilityFunctions.getBundleId(assetInfo)
            var2 = Constants.ItemType.Bundle
            assetId = bundleId
        else
            var2 = Constants.ItemType.Asset
            assetId = assetInfo.assetId
        end

        local var3 = arg1:calculateBuyStatusForLimitedItem(assetInfo, locale, forSale)

        buyText = var3.buyText
        showRobuxIcon = var3.showRobuxIcon
        forSale = var3.forSale
        local _collectibleQuantityLimitReached = var3.collectibleQuantityLimitReached
        collectibleLowestResalePrice = var3.collectibleLowestResalePrice
        collectibleLowestAvailableResaleProductId = var3.collectibleLowestAvailableResaleProductId
        collectibleLowestAvailableResaleItemInstanceId = var3.collectibleLowestAvailableResaleItemInstanceId
        collectibleItemId = var3.collectibleItemId
        bool3 = not isAnimationAsset(assetInfo.assetTypeId)

        if Constants.AssetTypeIdStringToHumanoidDescriptionProp[assetInfo.assetTypeId] == nil
            and Constants.AssetTypeIdToAccessoryTypeEnum[assetInfo.assetTypeId] == nil
        then
            bool3 = false
        end
    else
        var2 = nil
        bool1 = nil
        bool3 = false
        bool2 = nil
        assetId = nil
        showRobuxIcon = false
        buyText = nil
        collectibleItemId = nil
        collectibleLowestAvailableResaleProductId = nil
        collectibleLowestAvailableResaleItemInstanceId = nil
        collectibleLowestResalePrice = nil
    end

    local var3 = if GetFFlagIBGateUGC4ACollectibleAssetsBundles() then UtilityFunctions.isUnlimitedCollectibleAsset(var2, assetInfo)
        or UtilityFunctions.isLimitedBundle(var2, assetInfo)
        or UtilityFunctions.isUnlimitedCollectibleBundle(var2, assetInfo) else nil

    if assetInfo then
        collectibleItemId = assetInfo.collectibleItemId

        local var4 = arg1.props.assetBundles[assetInfo.assetId]
        var3 = bool1 and #var4 > 1
    end

    local gamepadEnabled = arg1.props.detailsInformation.viewingDetails and arg1.props.gamepadEnabled

    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 51),
            Position = UDim2.new(0, 0, 1, -51)
        },
        {
            UIListLayout = Roact.createElement(
                "UIListLayout",
                {
                    Padding = UDim.new(0, 10),
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            ControllerBar = gamepadEnabled
                and Roact.createElement(
                    InspectAndBuyControllerBar,
                    {
                        showTryOn = bool3,
                        tryingOn = arg1.props.tryingOn,
                        showFavorite = true,
                        isFavorited = arg1.props.isFavorited
                    }
                ),
            FavoriteButton = Roact.createElement(FavoritesButton, { favoriteButtonRef = arg1.favoriteButtonRef }),
            TryOnButton = Roact.createElement(TryOnButton, {
                showTryOn = bool3,
                assetInfo = assetInfo,
                partOfBundleAndOffsale = bool2,
                bundleId = bundleId,
                tryOnButtonRef = arg1.tryOnButtonRef,
                localPlayerModel = arg1.props.localPlayerModel
            }),
            TryOnFiller = Roact.createElement("ImageLabel", {
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 1,
                Size = UDim2.new(0.5, -32, 0, 44),
                Visible = not bool3,
                LayoutOrder = 2,
                Image = "",
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(5, 5, 120, 20)
            }),
            BuyButton = if GetFFlagIBGateUGC4ACollectibleAssetsBundles() and var3 then nil else Roact.createElement(BuyButton, {
                itemType = var2,
                itemId = assetId,
                showRobuxIcon = showRobuxIcon,
                forSale = forSale,
                buyText = buyText,
                buyButtonRef = arg1.buyButtonRef,
                collectibleItemId = collectibleItemId,
                collectibleLowestAvailableResaleProductId = collectibleLowestAvailableResaleProductId,
                collectibleLowestAvailableResaleItemInstanceId = collectibleLowestAvailableResaleItemInstanceId,
                collectibleLowestResalePrice = collectibleLowestResalePrice
            })
        }
    )
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    local isFavorited = GetIsFavorite(arg1)

    return {
        visible = arg1.visible,
        assetInfo = arg1.assets[assetId] or {},
        assetBundles = arg1.assetBundles,
        detailsInformation = arg1.detailsInformation,
        bundleInfo = arg1.bundles,
        locale = arg1.locale,
        gamepadEnabled = arg1.gamepadEnabled,
        isFavorited = isFavorited,
        tryingOn = arg1.tryingOnInfo.tryingOn,
        resellableInstances = arg1.collectibleResellableInstances,
        overlay = arg1.overlay
    }
end)(var1)
