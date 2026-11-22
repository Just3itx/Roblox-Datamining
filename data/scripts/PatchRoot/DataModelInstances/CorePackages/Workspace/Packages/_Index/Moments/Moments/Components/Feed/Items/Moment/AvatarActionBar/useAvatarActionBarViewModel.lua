-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Localization = require(MomentsParent.Localization)
local SharedFlags = require(MomentsParent.SharedFlags)
local SignalsReact = require(MomentsParent.SignalsReact)

local LocalizationService = game:GetService("LocalizationService")

local useLocalization = Localization.Hooks.useLocalization
local useSignalState = SignalsReact.useSignalState

local useAvatarLook = require(Moments.Hooks.useAvatarLook)
local MomentContext = require(script.Parent.Parent.MomentContext)
local useMomentsHost = require(Moments.MomentsHostContext).useMomentsHost

local _AvatarActionBar = require(script.Parent.AvatarActionBar)

local FFlagAXEnableUnifiedLoggingAvatarMoment = SharedFlags.FFlagAXEnableUnifiedLoggingAvatarMoment
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed
local FFlagMomentsHideUnavailableAvatarActionBar = require(Moments.Flags.FFlagMomentsHideUnavailableAvatarActionBar)
local FFlagMomentsAvatarActionBarOutfitThumbnail = require(Moments.Flags.FFlagMomentsAvatarActionBarOutfitThumbnail)

local function getLookThumbnail(str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `rbxthumb://type=Look&id={str1}&w={150}&h={150}`
end

local function getOutfitThumbnail(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `rbxthumb://type=Outfit&id={num1}&w={150}&h={150}&includeBackground=true`
end

local function useAvatarActionBarViewModel(tbl1)
    local store = MomentContext.useMoment().store
    local data = store.getData(false)
    local outfit = if FFlagMomentsRenderAvatarPostsInFeed and data.kind == "avatar" then data.outfit else nil
    local outfitId = if data.kind == "experience" then data.outfitId elseif outfit == nil or outfit.source.type ~= "outfit" then nil else outfit.source.id
    local openAvatarLookTryOn = useMomentsHost().openAvatarLookTryOn
    local var2 = useAvatarLook(outfitId)
    local isShopDisabled = useSignalState(store.getIsModerated)

    local var4 = outfit ~= nil
        and outfit.source.type == "look"
        and {
            lookId = outfit.source.id,
            totalPrice = outfit.price,
            itemCount = outfit.itemCount
        }
        or nil

    local var5 = var4 or var2.look
    local var6 = useLocalization({
        shop = "Feature.Avatar.Action.Shop",
        itemCount = {
            "Feature.Catalog.Label.TotalItemsParenthesis",
            itemCount = if var5 == nil then 0 else var5.itemCount
        }
    })
    local lookId = if var5 == nil then nil else var5.lookId
    local module = {
        LayoutOrder = tbl1.LayoutOrder,
        hasLookError = 0,
        isLoading = 0,
        thumbnailImage = 0,
        priceText = 0,
        itemCountText = 0,
        shopText = 0,
        showShopButton = 0,
        isShopDisabled = 0,
        onShop = 0
    }
    local bool1 = FFlagMomentsHideUnavailableAvatarActionBar

    if bool1 then
        if data.kind == "avatar" and var4 == nil then
            bool1 = var2.status == "Unavailable"
        else
            bool1 = false
        end
    end

    module.hasLookError = bool1

    module.isLoading = var4 == nil and var2.status ~= "Ready"
    module.thumbnailImage = if FFlagMomentsAvatarActionBarOutfitThumbnail and outfitId ~= nil then getOutfitThumbnail(outfitId) elseif lookId == nil then nil else getLookThumbnail(lookId)

    module.priceText = if var5 == nil or var5.totalPrice == nil then nil else Localization.NumberLocalization.localize(var5.totalPrice, LocalizationService.RobloxLocaleId)

    module.itemCountText = var6.itemCount
    module.shopText = var6.shop
    module.showShopButton = openAvatarLookTryOn ~= nil
    module.isShopDisabled = isShopDisabled
    function module.onShop()
        if openAvatarLookTryOn == nil or lookId == nil then
            return
        end

        if not FFlagAXEnableUnifiedLoggingAvatarMoment then
            openAvatarLookTryOn(lookId)
            return
        end

        openAvatarLookTryOn(lookId, { feedItemId = data.feedItemId, feedSessionId = data.feedSessionId, outfitId = outfitId })
    end

    return module
end

return useAvatarActionBarViewModel
