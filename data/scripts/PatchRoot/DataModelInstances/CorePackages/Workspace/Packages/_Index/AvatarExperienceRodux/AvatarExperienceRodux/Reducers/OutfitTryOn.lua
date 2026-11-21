-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)
local Cryo = require(AvatarExperienceRoduxParent.Cryo)
local AvatarExperienceModel = require(AvatarExperienceRoduxParent.AvatarExperienceModel)
local AvatarExperienceFlags = require(AvatarExperienceRoduxParent.AvatarExperienceFlags)
local AvatarExperienceCommon = require(AvatarExperienceRoduxParent.AvatarExperienceCommon)
local tutils = require(AvatarExperienceRoduxParent.tutils)

local _RoduxTypes = require(AvatarExperienceRodux.Types.RoduxTypes)
local _OutfitTryOn = require(AvatarExperienceRodux.Types.OutfitTryOn)

local TryOnLooksOutfit = require(AvatarExperienceRodux.Actions.TryOnLooksOutfit)
local ToggleTryOn = require(AvatarExperienceRodux.Actions.ToggleTryOn)
local TryOnColorUpdated = require(AvatarExperienceRodux.Actions.TryOnColorUpdated)
local SetEquippedInTryOnManager = require(AvatarExperienceRodux.Actions.SetEquippedInTryOnManager)
local SetSelectedTimedOption = require(AvatarExperienceRodux.Actions.SetSelectedTimedOption)
local RemoveUnselectedItemsFromTryOn = require(AvatarExperienceRodux.Actions.RemoveUnselectedItemsFromTryOn)
local RemoveFromTryOn = require(AvatarExperienceRodux.Actions.RemoveFromTryOn)
local RemoveLook = require(AvatarExperienceRodux.Actions.RemoveLook)
local RemoveLookFromTryOn = require(AvatarExperienceRodux.Actions.RemoveLookFromTryOn)
local RemoveLookItemsFromTryOn = require(AvatarExperienceRodux.Actions.RemoveLookItemsFromTryOn)
local ReceivedBundleInfoForTryOn = require(AvatarExperienceRodux.Actions.ReceivedBundleInfoForTryOn)
local ClearTryOns = require(AvatarExperienceRodux.Actions.ClearTryOns)
local SetBackgroundPreview = require(AvatarExperienceRodux.Actions.SetBackgroundPreview)
local SetOrderForTryOns = require(AvatarExperienceRodux.Actions.SetOrderForTryOns)
local AddSelectedBundleInfo = require(AvatarExperienceRodux.Actions.AddSelectedBundleInfo)
local SetOutfitTryOns = require(AvatarExperienceRodux.Actions.SetOutfitTryOns)
local SetAccessoryAdjustments = require(AvatarExperienceRodux.Actions.SetAccessoryAdjustments)
local ReducerUtils = require(AvatarExperienceRodux.Utils.ReducerUtils)
local TryOnClassicHeadShape = require(AvatarExperienceRodux.Actions.TryOnClassicHeadShape)
local NavigatedToNonTryOnPage = require(AvatarExperienceRodux.Actions.NavigatedToNonTryOnPage)
local NavigatedToTryOnPage = require(AvatarExperienceRodux.Actions.NavigatedToTryOnPage)
local DefaultTryOnBodyColorsToggled = require(AvatarExperienceRodux.Actions.DefaultTryOnBodyColorsToggled)
local findItemInTryOnItems = AvatarExperienceCommon.Utils.findItemInTryOnItems
local getTryOnItemReducerKey = AvatarExperienceCommon.Utils.getTryOnItemReducerKey
local getFilteredTryOnItems = AvatarExperienceCommon.Utils.getFilteredTryOnItems
local removeMakeupAssetsFromTryOnsIfOverLimit = AvatarExperienceCommon.Utils.removeMakeupAssetsFromTryOnsIfOverLimit
local SetLastToggledLookType = require(AvatarExperienceRodux.Actions.SetLastToggledLookType)
local ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE = AvatarExperienceCommon.Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE
local LAYERED_MAKEUP_ORDER = AvatarExperienceCommon.Constants.LAYERED_MAKEUP_ORDER
local MAKEUP_LOOK_ASSET_TYPES = AvatarExperienceCommon.Constants.MAKEUP_LOOK_ASSET_TYPES
local LOOK_TYPE = AvatarExperienceCommon.Constants.LOOK_TYPE
local Constants = AvatarExperienceCommon.Constants
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum
local ASSET_TYPE_NAME_TO_ID_STRING = Constants.ASSET_TYPE_NAME_TO_ID_STRING
local BundleTypeIdStrings = AvatarExperienceModel.Constants.BundleTypeIdStrings
local BUNDLE_TYPE_ID_STRING_TO_NAME_FOR_BACKEND = Constants.BUNDLE_TYPE_ID_STRING_TO_NAME_FOR_BACKEND
local LAYERED_CLOTHING_ORDER = Constants.LAYERED_CLOTHING_ORDER
local LAYERED_ASSET_TYPES = Constants.LAYERED_ASSET_TYPES
local ASSET_TYPE_TO_ACCESSORY_TYPE = Constants.ASSET_TYPE_TO_ACCESSORY_TYPE

local CharacterHistoryStateChangeButtonActivated = AvatarExperienceCommon.State.Actions.CharacterHistoryStateChangeButtonActivated
local FFlagAXCatalogMakeupSupport = AvatarExperienceFlags.FFlagAXCatalogMakeupSupport
local FFlagAXMISEnableMultiShopping = AvatarExperienceFlags.FFlagAXMISEnableMultiShopping
local FFlagAXDurablesForMIS = AvatarExperienceFlags.FFlagAXDurablesForMIS
local FFlagParseHeadShapeFromAPIResponse = AvatarExperienceFlags.FFlagParseHeadShapeFromAPIResponse
local FFlagHeadRefinementFacialAnimationToggle = AvatarExperienceFlags.FFlagHeadRefinementFacialAnimationToggle
local FFlagAXPhotoboothMomentsPage = AvatarExperienceFlags.FFlagAXPhotoboothMomentsPage
local FFlagAXTryOnWithoutEquippedBody = AvatarExperienceFlags.FFlagAXTryOnWithoutEquippedBody

local FFlagAXPhotoboothMomentsTryOnAccessoryAdjustments = AvatarExperienceFlags.FFlagAXPhotoboothMomentsTryOnAccessoryAdjustments

local num1 = 0

local function formatItem(arg1, isUnequipped: boolean)
    local bool1 = not not arg1.receivedBundleInfo

    local bundleInfo = arg1.bundleInfo
    if FFlagAXMISEnableMultiShopping and arg1.bundleItems and not bool1 then
        bundleInfo = {}
        for _, bundleItem in arg1.bundleItems do
            if bundleItem.type ~= ItemTypeEnum.Asset then
                continue
            end

            local assetType = bundleItem.assetType
            if not assetType and arg1.itemSubType == BundleTypeIdStrings.DynamicHead then
                assetType = ASSET_TYPE_NAME_TO_ID_STRING.DynamicHead
            end
            if not assetType then
                continue
            end

            local tbl1 = { assetType = assetType }
            if FFlagParseHeadShapeFromAPIResponse and bundleItem.meta and bundleItem.meta.headShape ~= nil then
                tbl1.headShape = bundleItem.meta.headShape
            end

            if FFlagHeadRefinementFacialAnimationToggle and bundleItem.meta and bundleItem.meta.staticFacialAnimation ~= nil then
                tbl1.staticFacialAnimation = bundleItem.meta.staticFacialAnimation
            end
            bundleInfo[bundleItem.id] = tbl1
        end

        bool1 = true
    end

    local tbl1 = {
        version = "1",
        itemId = arg1.itemId,
        itemType = arg1.itemType,
        itemSubType = arg1.itemSubType,
        selectedInTryOnManager = arg1.selectedInTryOnManager,
        isUnequipped = isUnequipped,
        receivedBundleInfo = bool1,
        bundleInfo = 0,
        widgetInfo = 0,
        isRecolorable = 0,
        selectedTimedOptionIndex = 0
    }

    if not FFlagAXMISEnableMultiShopping then
        bundleInfo = arg1.bundleInfo
    end

    tbl1.bundleInfo = bundleInfo
    tbl1.widgetInfo = arg1.widgetInfo
    tbl1.isRecolorable = arg1.isRecolorable
    local selectedTimedOptionIndex = if FFlagAXDurablesForMIS then arg1.selectedTimedOptionIndex else nil
    tbl1.selectedTimedOptionIndex = selectedTimedOptionIndex

    if ASSET_TYPE_TO_ACCESSORY_TYPE[arg1.itemSubType] then
        local tbl2 = {
            order = arg1.overrideOrder or LAYERED_CLOTHING_ORDER[arg1.itemSubType],
            isLayered = LAYERED_ASSET_TYPES[arg1.itemSubType] ~= nil
        }

        tbl1 = Cryo.Dictionary.join(tbl1, tbl2)
    elseif ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE[arg1.itemSubType] then
        local tbl2 = {
            order = arg1.overrideOrder or LAYERED_MAKEUP_ORDER[arg1.itemSubType],
            isLayered = true
        }

        tbl1 = Cryo.Dictionary.join(tbl1, tbl2)
    end

    if not isUnequipped then
        tbl1.itemRecency = num1
        num1 += 1
    end

    return tbl1
end

local function formatItemFromLookOutfit(arg1, arg2, lookId: string?, outfitId: string?)
    local tbl1 = {
        version = "1",
        itemId = arg1.itemId,
        itemType = arg1.itemType,
        itemSubType = arg1.itemSubType,
        selectedInTryOnManager = arg1.isNotSelectable ~= true,
        isUnequipped = false,
        receivedBundleInfo = false,
        lookId = lookId,
        outfitId = if FFlagAXPhotoboothMomentsPage then outfitId else nil,
        headShape = if FFlagAXTryOnWithoutEquippedBody then arg1.headShape else nil,
        staticFacialAnimation = if FFlagAXTryOnWithoutEquippedBody then arg1.staticFacialAnimation else nil
    }

    if ASSET_TYPE_TO_ACCESSORY_TYPE[arg1.itemSubType] then
        local tbl2 = {
            order = arg1.order or LAYERED_CLOTHING_ORDER[arg1.itemSubType],
            isLayered = LAYERED_ASSET_TYPES[arg1.itemSubType] ~= nil
        }
        tbl1 = Cryo.Dictionary.join(tbl1, tbl2)
        if FFlagAXPhotoboothMomentsTryOnAccessoryAdjustments and outfitId ~= nil then
            tbl1.position = arg1.position
            tbl1.rotation = arg1.rotation
            tbl1.scale = arg1.scale
        end
    elseif ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE[arg1.itemSubType] then
        local tbl2 = {
            order = arg1.order or LAYERED_MAKEUP_ORDER[arg1.itemSubType],
            isLayered = true
        }

        tbl1 = Cryo.Dictionary.join(tbl1, tbl2)
    end

    local itemRecency = if arg2 == LOOK_TYPE.Avatar or FFlagAXCatalogMakeupSupport and arg2 == LOOK_TYPE.Makeup then arg1.tryOnItemOrder else num1
    tbl1.itemRecency = itemRecency

    num1 += 1

    return tbl1
end

local function formatBundleFromLookOutfit(arg1, lookId: string?)
    local tbl1 = {
        version = "1",
        selectedInTryOnManager = arg1.isNotSelectable ~= true,
        isUnequipped = false,
        receivedBundleInfo = false,
        itemType = arg1.itemType,
        itemId = arg1.itemId,
        itemSubType = if FFlagAXMISEnableMultiShopping then arg1.itemSubType else nil,
        lookId = lookId
    }

    local bundleInfo = ({})
    for _, item in arg1.items do
        local itemId = item.itemId
        bundleInfo[itemId] = {
            assetType = item.itemSubType,
            order = LAYERED_CLOTHING_ORDER[item.itemSubType] or LAYERED_MAKEUP_ORDER[item.itemSubType],
            headShape = if FFlagParseHeadShapeFromAPIResponse then item.headShape else nil
        }
    end

    tbl1.bundleInfo = bundleInfo
    tbl1.itemRecency = arg1.tryOnItemOrder or num1
    num1 += 1

    return tbl1
end

local function removeItem(arg1, arg2, tbl1)
    local tryOnItemReducerKey = getTryOnItemReducerKey(tbl1.itemId, tbl1.itemType)
    local lastToggledItem = arg2[tryOnItemReducerKey]
    lastToggledItem.isUnequipped = true

    local bool1 = tbl1.itemSubType == ASSET_TYPE_NAME_TO_ID_STRING.Face
    local bool2 = tbl1.itemType == ItemTypeEnum.Bundle and BUNDLE_TYPE_ID_STRING_TO_NAME_FOR_BACKEND[tbl1.itemSubType] == "Body"
    return Cryo.Dictionary.join(arg1, {
        TryOnItems = Cryo.Dictionary.join(arg2, { [tryOnItemReducerKey] = Cryo.None }),
        LastToggledItem = lastToggledItem,
        LastTryOnClassicHeadShape = if bool1 then Cryo.None else nil,
        BodyColor3s = if bool2 then Cryo.None else nil,
        BodyPartColorRangeIds = if bool2 then Cryo.None else nil
    })
end

local function isAnimationOrEmoteItem(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1.itemType == ItemTypeEnum.Asset and tbl1.itemSubType == ASSET_TYPE_NAME_TO_ID_STRING.EmoteAnimation
        or tbl1.itemType == ItemTypeEnum.Bundle and tbl1.itemSubType == tostring(BundleTypeIdStrings.Animations)
end

local function getTryOnItemsContainsRecolorableBody(tbl1)
    for _, value in tbl1 do
        if value.itemType == "Bundle"
            and BUNDLE_TYPE_ID_STRING_TO_NAME_FOR_BACKEND[value.itemSubType] == "Body"
            and value.isRecolorable
        then
            return true
        end
    end
    return false
end

local function getTryOnItemsMakeupAndAvatarLookIds(tryOnItems)
    local none = Cryo.None
    local none2 = Cryo.None
    for _, tryOnItem in tryOnItems do
        if tryOnItem.lookId and not MAKEUP_LOOK_ASSET_TYPES[tryOnItem.itemSubType] then
            none = tryOnItem.lookId
        end

        if tryOnItem.lookId and MAKEUP_LOOK_ASSET_TYPES[tryOnItem.itemSubType] then
            none2 = tryOnItem.lookId
        end
    end
    return none, none2
end

local function reconcileAllTryOnState(tbl1)
    local tryOnItems = tbl1.TryOnItems
    local var1, var2

    if FFlagAXMISEnableMultiShopping then
        var1, var2 = getTryOnItemsMakeupAndAvatarLookIds(tryOnItems)
    else
        var2 = nil
        var1 = nil
    end
    local tryOnItemsContainsRecolorableBody = getTryOnItemsContainsRecolorableBody(tryOnItems)

    if FFlagAXMISEnableMultiShopping then
        tryOnItemsContainsRecolorableBody = tryOnItemsContainsRecolorableBody or var1 ~= nil
    end

    if FFlagAXPhotoboothMomentsPage then
        tryOnItemsContainsRecolorableBody = tryOnItemsContainsRecolorableBody or tbl1.OutfitId ~= nil
    end

    local bodyColor3s = if tryOnItemsContainsRecolorableBody then tbl1.BodyColor3s else Cryo.None
    local bodyPartColorRangeIds = if tryOnItemsContainsRecolorableBody then tbl1.BodyPartColorRangeIds else Cryo.None
    local defaultTryOnBodyColorsToggled = if tryOnItemsContainsRecolorableBody then tbl1.DefaultTryOnBodyColorsToggled else false
    local bool1 = if FFlagAXMISEnableMultiShopping then tutils.fieldCount(tryOnItems) == 0 else nil
    local var5 = if FFlagAXMISEnableMultiShopping then if bool1 then Cryo.None else tbl1.LookType else nil
    local var6 = if FFlagAXMISEnableMultiShopping then if bool1 or not var2 then Cryo.None else LOOK_TYPE.Makeup else nil
    local join = Cryo.Dictionary.join
    local tbl2 = {
        BodyColor3s = bodyColor3s,
        BodyPartColorRangeIds = bodyPartColorRangeIds,
        DefaultTryOnBodyColorsToggled = defaultTryOnBodyColorsToggled,
        LookId = 0,
        LookType = 0,
        MakeupLookId = 0,
        MakeupLookType = 0,
        ShouldTryOnWithoutEquippedItems = 0,
        ShouldTryOnWithoutEquippedBody = 0
    }

    if not FFlagAXMISEnableMultiShopping then
        var1 = nil
    end

    tbl2.LookId = var1
    if not FFlagAXMISEnableMultiShopping then
        var5 = nil
    end

    tbl2.LookType = var5
    if not FFlagAXMISEnableMultiShopping then
        var2 = nil
    end

    tbl2.MakeupLookId = var2
    if not FFlagAXMISEnableMultiShopping then
        var6 = nil
    end

    tbl2.MakeupLookType = var6
    tbl2.ShouldTryOnWithoutEquippedItems = if FFlagAXMISEnableMultiShopping then not bool1 and tbl1.ShouldTryOnWithoutEquippedItems else nil

    tbl2.ShouldTryOnWithoutEquippedBody = if FFlagAXTryOnWithoutEquippedBody then not bool1 and tbl1.ShouldTryOnWithoutEquippedBody else nil
    return join(tbl1, tbl2)
end

local tbl1 = {
    TryOnItems = {},
    DefaultTryOnBodyColorsToggled = false,
    LookId = nil,
    LookType = nil,
    MakeupLookId = nil,
    MakeupLookType = nil,
    LastToggledLookType = nil,
    LastTryOnClassicHeadShape = nil,
    OutfitIdMap = {},
    ShouldTryOnWithoutEquippedItems = not FFlagAXMISEnableMultiShopping and nil,
    ShouldTryOnWithoutEquippedBody = not FFlagAXTryOnWithoutEquippedBody and nil,
    BackgroundPreview = nil,
    AvatarType = nil,
    OutfitId = nil
}

local createReducer = Rodux.createReducer

local tbl2 = {}
tbl2[TryOnColorUpdated.name] = function(tbl3, arg1)
    local var1 = table.clone(tbl3 or tbl1)
    var1.BodyColor3s = arg1.colors
    var1.BodyPartColorRangeIds = arg1.bodyPartColorRangeIds
    return var1
end

tbl2[ToggleTryOn.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1
    local var2 = var1.TryOnItems or {}
    local bool1 = var1.LookId ~= nil
    local tryOnItemReducerKey = getTryOnItemReducerKey(arg1.itemId, arg1.itemType)

    if if FFlagAXMISEnableMultiShopping then var2[tryOnItemReducerKey] ~= nil else not (var2[tryOnItemReducerKey] == nil) and not bool1 then
        if FFlagAXMISEnableMultiShopping then
            return reconcileAllTryOnState(removeItem(var1, var2, arg1))
        end
        return removeItem(var1, var2, arg1)
    end

    if FFlagAXMISEnableMultiShopping then
        var2 = arg1.resetTryOnsBeforeToggleOn and {} or var2
    end

    local var3 = ReducerUtils.filterTryOns(var2, arg1)
    local lastToggledItem = formatItem(arg1, false)
    if FFlagAXMISEnableMultiShopping then
        var3 = getFilteredTryOnItems(var2, lastToggledItem)
    end

    local lastAnimOrEmoteToggledItem = if isAnimationOrEmoteItem(lastToggledItem) then lastToggledItem else nil

    if not FFlagAXMISEnableMultiShopping and bool1 then
        return Cryo.Dictionary.join(var1, {
            TryOnItems = {
                [arg1.itemId] = lastToggledItem
            },
            LastToggledItem = lastToggledItem,
            LastAnimOrEmoteToggledItem = lastAnimOrEmoteToggledItem,
            LookId = Cryo.None,
            BodyColor3s = {},
            BodyPartColorRangeIds = Cryo.None,
            DefaultTryOnBodyColorsToggled = false
        })
    end

    local var6 = Cryo.Dictionary.join(var3, { [tryOnItemReducerKey] = lastToggledItem })

    local tryOnItemsContainsRecolorableBody = getTryOnItemsContainsRecolorableBody(var6)

    if FFlagAXPhotoboothMomentsPage then
        tryOnItemsContainsRecolorableBody = tryOnItemsContainsRecolorableBody or var1.OutfitId ~= nil
    end

    local bodyColor3s = if tryOnItemsContainsRecolorableBody then var1.BodyColor3s else Cryo.None
    local bodyPartColorRangeIds = if tryOnItemsContainsRecolorableBody then var1.BodyPartColorRangeIds else Cryo.None
    local defaultTryOnBodyColorsToggled = if tryOnItemsContainsRecolorableBody then var1.DefaultTryOnBodyColorsToggled else false
    local var9 = Cryo.Dictionary.join(var1, {
        TryOnItems = var6,
        LastToggledItem = lastToggledItem,
        LastAnimOrEmoteToggledItem = lastAnimOrEmoteToggledItem,
        BodyColor3s = bodyColor3s,
        BodyPartColorRangeIds = bodyPartColorRangeIds,
        DefaultTryOnBodyColorsToggled = defaultTryOnBodyColorsToggled
    })
    if not FFlagAXMISEnableMultiShopping then
        return var9
    end

    if FFlagAXCatalogMakeupSupport then
        var6 = removeMakeupAssetsFromTryOnsIfOverLimit(var6)
    end

    local var10 = Cryo.Dictionary.join(
        var9,
        {
            TryOnItems = var6,
            LastToggledItem = lastToggledItem,
            LastAnimOrEmoteToggledItem = lastAnimOrEmoteToggledItem
        }
    )
    return reconcileAllTryOnState(var10)
end

tbl2[TryOnClassicHeadShape.name] = function(tbl3, arg1)
    return Cryo.Dictionary.join(tbl3, { LastTryOnClassicHeadShape = if arg1.headShape then arg1.headShape else Cryo.None })
end

tbl2[TryOnLooksOutfit.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1
    local var2

    if FFlagAXMISEnableMultiShopping and FFlagAXCatalogMakeupSupport and arg1.lookType == LOOK_TYPE.Makeup then
        var2 = table.clone(var1.TryOnItems)

        for value, value2 in var2 do
            if MAKEUP_LOOK_ASSET_TYPES[value2.itemSubType] then
                var2[value] = nil
            end
        end
    else
        var2 = {}
    end

    for _, value in arg1.assetItemIdTypeAndSubtype do
        local tryOnItemReducerKey = getTryOnItemReducerKey(value.itemId, value.itemType)
        local func1 = formatItemFromLookOutfit

        local lookType = arg1.lookType
        local lookId = if FFlagAXMISEnableMultiShopping then arg1.lookId else nil
        local outfitId = if FFlagAXPhotoboothMomentsPage then arg1.outfitId else nil
        var2[tryOnItemReducerKey] = func1(value, lookType, lookId, outfitId)
    end

    if arg1.bundleItemIdTypeAndSubtype ~= nil then
        for _, value in arg1.bundleItemIdTypeAndSubtype do
            local tryOnItemReducerKey = getTryOnItemReducerKey(value.itemId, value.itemType)

            local func1 = formatBundleFromLookOutfit
            local lookId = if FFlagAXMISEnableMultiShopping then arg1.lookId else nil
            var2[tryOnItemReducerKey] = func1(value, lookId)
        end
    end

    if FFlagAXMISEnableMultiShopping and FFlagAXCatalogMakeupSupport and arg1.lookType == LOOK_TYPE.Makeup then
        return Cryo.Dictionary.join(var1, {
            TryOnItems = var2,
            MakeupLookId = if arg1.lookId then arg1.lookId else Cryo.None,
            MakeupLookType = arg1.lookType,
            LastToggledLookType = arg1.lookType,
            MakeupLookAnalyticsInfo = if arg1.analyticsInfo then arg1.analyticsInfo else Cryo.None
        })
    end

    return Cryo.Dictionary.join(var1, {
        TryOnItems = var2,
        LookId = if arg1.lookId then arg1.lookId else Cryo.None,
        LookAnalyticsInfo = if arg1.analyticsInfo then arg1.analyticsInfo else Cryo.None,
        LookType = arg1.lookType,
        MakeupLookId = Cryo.None,
        MakeupLookType = Cryo.None,
        MakeupLookAnalyticsInfo = Cryo.None,
        LastToggledLookType = if FFlagAXMISEnableMultiShopping then arg1.lookType else nil,
        BodyColor3s = if arg1.bodyColor3s then arg1.bodyColor3s else Cryo.None,
        BodyPartColorRangeIds = if arg1.bodyPartColorRangeIds then arg1.bodyPartColorRangeIds else Cryo.None,
        DefaultTryOnBodyColorsToggled = Cryo.None,
        Scale = if arg1.scale then arg1.scale else Cryo.None,
        ShouldTryOnWithoutEquippedItems = if FFlagAXMISEnableMultiShopping then arg1.lookId ~= nil or FFlagAXPhotoboothMomentsPage and arg1.outfitId ~= nil else nil,
        ShouldTryOnWithoutEquippedBody = if FFlagAXTryOnWithoutEquippedBody then arg1.shouldTryOnWithoutEquippedBody == true else nil,
        AvatarType = if FFlagAXPhotoboothMomentsPage then if arg1.avatarType then arg1.avatarType else Cryo.None else nil,
        OutfitId = if FFlagAXPhotoboothMomentsPage then if arg1.outfitId ~= nil then arg1.outfitId else Cryo.None else nil
    })
end

tbl2[SetEquippedInTryOnManager.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1
    local var2 = var1.TryOnItems or {}

    local tryOnItemReducerKey = getTryOnItemReducerKey(arg1.itemId, arg1.itemType)
    if var2[tryOnItemReducerKey] == nil then
        return var1
    end

    return Cryo.Dictionary.join(var1, {
        TryOnItems = Cryo.Dictionary.join(var2, {
            [tryOnItemReducerKey] = Cryo.Dictionary.join(var2[tryOnItemReducerKey], { selectedInTryOnManager = arg1.selectedInTryOnManager })
        })
    })
end

tbl2[SetSelectedTimedOption.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1
    local var2 = var1.TryOnItems or {}

    local tryOnItemReducerKey = getTryOnItemReducerKey(arg1.itemId, arg1.itemType)
    if var2[tryOnItemReducerKey] == nil then
        return var1
    end

    return Cryo.Dictionary.join(var1, {
        TryOnItems = Cryo.Dictionary.join(var2, {
            [tryOnItemReducerKey] = Cryo.Dictionary.join(var2[tryOnItemReducerKey], { selectedTimedOptionIndex = arg1.selectedTimedOptionIndex })
        })
    })
end

tbl2[RemoveUnselectedItemsFromTryOn.name] = function(tbl3, _)
    local var1 = tbl3 or tbl1

    local tryOnItems = ({})

    for value, value2 in var1.TryOnItems or {} do
        if value2.selectedInTryOnManager then
            tryOnItems[value] = value2
        end
    end

    return Cryo.Dictionary.join(var1, { TryOnItems = tryOnItems })
end

tbl2[RemoveLookFromTryOn.name] = FFlagAXMISEnableMultiShopping and function(tbl3, arg1)
    local var1 = tbl3 or tbl1

    local tryOnItems = ({})

    for value, value2 in var1.TryOnItems or {} do
        if value2.lookId ~= arg1.lookId then
            tryOnItems[value] = value2
        end
    end

    if FFlagAXCatalogMakeupSupport and var1.MakeupLookId == arg1.lookId then
        return Cryo.Dictionary.join(var1, {
            TryOnItems = tryOnItems,
            MakeupLookId = Cryo.None,
            MakeupLookType = Cryo.None,
            MakeupLookAnalyticsInfo = Cryo.None,
            LastToggledLookType = Cryo.None
        })
    end

    return Cryo.Dictionary.join(var1, {
        TryOnItems = tryOnItems,
        LookId = Cryo.None,
        LookType = Cryo.None,
        LookAnalyticsInfo = Cryo.None,
        BodyColor3s = Cryo.None,
        BodyPartColorRangeIds = Cryo.None,
        Scale = Cryo.None,
        LastToggledLookType = Cryo.None,
        ShouldTryOnWithoutEquippedItems = false,
        ShouldTryOnWithoutEquippedBody = not FFlagAXTryOnWithoutEquippedBody and nil
    })
end or nil

tbl2[RemoveFromTryOn.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1
    local var2 = var1.TryOnItems or {}

    local itemInTryOnItems = findItemInTryOnItems(var2, arg1.itemId, arg1.itemType)

    if itemInTryOnItems ~= nil then
        return reconcileAllTryOnState(removeItem(var1, var2, itemInTryOnItems))
    end

    return var1
end

tbl2[RemoveLookItemsFromTryOn.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1

    if arg1.lookId == var1.LookId then
        local var2 = var1.TryOnItems or {}

        for _, assetId in arg1.assetIds do
            local tryOnItemReducerKey = getTryOnItemReducerKey(assetId, ItemTypeEnum.Asset)
            if var2[tryOnItemReducerKey] ~= nil then
                var2 = Cryo.Dictionary.join(var2, { [tryOnItemReducerKey] = Cryo.None })
            end
        end

        if arg1.bundleIds ~= nil then
            for _, bundleId in arg1.bundleIds do
                local tryOnItemReducerKey = getTryOnItemReducerKey(bundleId, ItemTypeEnum.Bundle)
                if var2[tryOnItemReducerKey] ~= nil then
                    var2 = Cryo.Dictionary.join(var2, { [tryOnItemReducerKey] = Cryo.None })
                end
            end
        end

        var1 = Cryo.Dictionary.join(var1, {
            TryOnItems = var2,
            LookId = Cryo.None,
            LookType = Cryo.None,
            BodyColor3s = Cryo.None,
            BodyPartColorRangeIds = Cryo.None,
            Scale = Cryo.None,
            ShouldTryOnWithoutEquippedItems = not FFlagAXMISEnableMultiShopping and nil,
            ShouldTryOnWithoutEquippedBody = not FFlagAXTryOnWithoutEquippedBody and nil
        })
    end

    if FFlagAXMISEnableMultiShopping and FFlagAXCatalogMakeupSupport and arg1.lookId == var1.MakeupLookId then
        local var2 = var1.TryOnItems or {}

        for _, assetId in arg1.assetIds do
            local tryOnItemReducerKey = getTryOnItemReducerKey(assetId, ItemTypeEnum.Asset)
            if var2[tryOnItemReducerKey] ~= nil then
                var2 = Cryo.Dictionary.join(var2, { [tryOnItemReducerKey] = Cryo.None })
            end
        end

        if arg1.bundleIds ~= nil then
            for _, bundleId in arg1.bundleIds do
                local tryOnItemReducerKey = getTryOnItemReducerKey(bundleId, ItemTypeEnum.Bundle)
                if var2[tryOnItemReducerKey] ~= nil then
                    var2 = Cryo.Dictionary.join(var2, { [tryOnItemReducerKey] = Cryo.None })
                end
            end
        end

        var1 = Cryo.Dictionary.join(var1, { TryOnItems = var2, MakeupLookId = Cryo.None, MakeupLookType = Cryo.None })
    end

    return var1
end

tbl2[ReceivedBundleInfoForTryOn.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1
    local var2 = var1.TryOnItems or {}

    local tryOnItemReducerKey = getTryOnItemReducerKey(arg1.itemId, ItemTypeEnum.Bundle)
    if not var2[tryOnItemReducerKey] then
        return var1
    end

    local outfitIdMap = table.clone(var1.OutfitIdMap or {})
    outfitIdMap[arg1.itemId] = arg1.outfitId

    return Cryo.Dictionary.join(var1, {
        TryOnItems = Cryo.Dictionary.join(
            var2,
            {
                [tryOnItemReducerKey] = Cryo.Dictionary.join(var2[tryOnItemReducerKey], { receivedBundleInfo = true })
            }
        ),
        OutfitIdMap = outfitIdMap
    })
end

tbl2[ClearTryOns.name] = function(tbl3, arg1)
    if not tbl3 then
        return tbl1
    end

    local retainTryOnColor = not (if FFlagAXPhotoboothMomentsPage then tbl3.LookId ~= nil or tbl3.OutfitId ~= nil else tbl3.LookId ~= nil)
        and arg1.retainTryOnColor
    return Cryo.Dictionary.join(tbl1, {
        LastTryOnClassicHeadShape = tbl3.LastTryOnClassicHeadShape,
        DefaultTryOnBodyColorsToggled = if retainTryOnColor then tbl3.DefaultTryOnBodyColorsToggled else nil,
        BodyColor3s = if retainTryOnColor then tbl3.BodyColor3s else nil,
        BodyPartColorRangeIds = if retainTryOnColor then tbl3.BodyPartColorRangeIds else nil,
        OutfitIdMap = not tbl3 and {} or tbl3.OutfitIdMap,
        ShouldTryOnWithoutEquippedItems = not FFlagAXMISEnableMultiShopping and nil,
        ShouldTryOnWithoutEquippedBody = not FFlagAXTryOnWithoutEquippedBody and nil,
        LastToggledLookType = if FFlagAXMISEnableMultiShopping and FFlagAXCatalogMakeupSupport then Cryo.None else nil
    })
end

tbl2[NavigatedToNonTryOnPage.name] = function(tbl3, _)
    local var1 = table.clone(tbl1)
    if tbl3 and tbl3.OutfitIdMap then
        var1.OutfitIdMap = tbl3.OutfitIdMap
    end
    return var1
end

tbl2[NavigatedToTryOnPage.name] = function(tbl3, _)
    local var1 = table.clone(tbl1)
    if tbl3 and tbl3.OutfitIdMap then
        var1.OutfitIdMap = tbl3.OutfitIdMap
    end
    return var1
end

tbl2[SetBackgroundPreview.name] = function(tbl3, arg1)
    local var1 = table.clone(tbl3 or tbl1)
    var1.BackgroundPreview = arg1.previewKey
    return var1
end

tbl2[DefaultTryOnBodyColorsToggled.name] = function(tbl3, arg1)
    local var1 = table.clone(tbl3 or tbl1)

    var1.DefaultTryOnBodyColorsToggled = arg1.state
    return var1
end

tbl2[SetOrderForTryOns.name] = function(tbl3, arg1)
    local itemIdToOrderMap = arg1.itemIdToOrderMap
    local var1 = tbl3 or tbl1

    for value, order in itemIdToOrderMap do
        local var2 = var1.TryOnItems or {}

        local tryOnItemReducerKey = getTryOnItemReducerKey(value, ItemTypeEnum.Asset)

        if var2[tryOnItemReducerKey] and var2[tryOnItemReducerKey].itemType ~= ItemTypeEnum.Bundle then
            local join = Cryo.Dictionary.join
            local tbl4 = {
                TryOnItems = Cryo.Dictionary.join(
                    var2,
                    {
                        [tryOnItemReducerKey] = Cryo.Dictionary.join(var2[tryOnItemReducerKey], { order = order })
                    }
                )
            }
            var1 = join(var1, tbl4)
        elseif not var2[tryOnItemReducerKey] then
            for value3, value4 in var2 do
                if not value4.bundleInfo or not value4.bundleInfo[value] or value4.itemId == Constants.AVATAR_BLOCKY_DEFAULT_BUNDLE_ID then
                    continue
                end

                local bundleInfo = value4.bundleInfo
                local var3 = Cryo.Dictionary.join(bundleInfo, { [value] = Cryo.Dictionary.join(bundleInfo[value], { order = order }) })

                local join = Cryo.Dictionary.join
                local tbl4 = {
                    TryOnItems = Cryo.Dictionary.join(var2, { [value3] = Cryo.Dictionary.join(var2[value3], { bundleInfo = var3 }) })
                }
                var1 = join(tbl3, tbl4)
                break
            end
        end
    end

    return var1
end

tbl2[SetAccessoryAdjustments.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1
    local var2 = var1.TryOnItems or {}
    for value, value2 in var2 do
        if value2.itemType == "Asset" then
            if value2.itemId == arg1.itemId then
                return Cryo.Dictionary.join(var1, {
                    TryOnItems = Cryo.Dictionary.join(
                        var2,
                        {
                            [value] = Cryo.Dictionary.join(value2, { position = arg1.position, rotation = arg1.rotation, scale = arg1.scale })
                        }
                    )
                })
            end
        elseif value2.itemType == "Bundle" then
            for value3, value4 in var2 do
                if not (value4.bundleInfo and value4.bundleInfo[arg1.itemId]) then
                    continue
                end

                local bundleInfo = value4.bundleInfo
                local var3 = Cryo.Dictionary.join(bundleInfo, {
                    [arg1.itemId] = Cryo.Dictionary.join(
                        bundleInfo[arg1.itemId],
                        {
                            position = arg1.position,
                            rotation = arg1.rotation,
                            scale = arg1.scale
                        }
                    )
                })
                return Cryo.Dictionary.join(
                    tbl3,
                    {
                        TryOnItems = Cryo.Dictionary.join(var2, { [value3] = Cryo.Dictionary.join(var2[value3], { bundleInfo = var3 }) })
                    }
                )
            end
        end
    end

    return var1
end

tbl2[AddSelectedBundleInfo.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1
    local var2 = var1.TryOnItems or {}

    local tryOnItemReducerKey = getTryOnItemReducerKey(arg1.bundleId, ItemTypeEnum.Bundle)

    if not var2[tryOnItemReducerKey] then
        return var1
    end

    return Cryo.Dictionary.join(var1, {
        TryOnItems = Cryo.Dictionary.join(
            var2,
            {
                [tryOnItemReducerKey] = Cryo.Dictionary.join(var2[tryOnItemReducerKey], { bundleInfo = arg1.bundleInfo })
            }
        )
    })
end

tbl2[SetOutfitTryOns.name] = function(_, arg1)
    return arg1.outfitTryOns
end

tbl2[RemoveLook.name] = function(tbl3, arg1)
    local var1 = tbl3 or tbl1

    if arg1.lookId == var1.LookId
        or FFlagAXMISEnableMultiShopping and FFlagAXCatalogMakeupSupport and arg1.lookId == var1.MakeupLookId
    then
        local tryOnItems = ({})

        if FFlagAXMISEnableMultiShopping then
            for value, value2 in var1.TryOnItems or {} do
                if value2.lookId ~= arg1.lookId then
                    tryOnItems[value] = value2
                end
            end
        end

        if FFlagAXMISEnableMultiShopping and FFlagAXCatalogMakeupSupport then
            if arg1.lookId == var1.LookId then
                var1 = Cryo.Dictionary.join(var1, {
                    TryOnItems = tryOnItems,
                    LookId = Cryo.None,
                    LookType = Cryo.None,
                    BodyColor3s = Cryo.None,
                    BodyPartColorRangeIds = Cryo.None,
                    Scale = Cryo.None,
                    ShouldTryOnWithoutEquippedItems = false,
                    ShouldTryOnWithoutEquippedBody = not FFlagAXTryOnWithoutEquippedBody and nil,
                    LastToggledLookType = Cryo.None
                })
            end

            if arg1.lookId == var1.MakeupLookId then
                return (Cryo.Dictionary.join(
                    var1,
                    {
                        TryOnItems = tryOnItems,
                        MakeupLookId = Cryo.None,
                        MakeupLookType = Cryo.None,
                        LastToggledLookType = Cryo.None
                    }
                ))
            end
        else
            var1 = Cryo.Dictionary.join(var1, {
                TryOnItems = tryOnItems,
                LookId = Cryo.None,
                LookType = Cryo.None,
                BodyColor3s = Cryo.None,
                BodyPartColorRangeIds = Cryo.None,
                Scale = Cryo.None,
                ShouldTryOnWithoutEquippedItems = not FFlagAXMISEnableMultiShopping and nil,
                ShouldTryOnWithoutEquippedBody = not FFlagAXTryOnWithoutEquippedBody and nil
            })
        end
    end

    return var1
end

tbl2[CharacterHistoryStateChangeButtonActivated.name] = function(arg1, arg2)
    if arg2.tryOn and arg2.tryOn.OutfitTryOn then
        return table.clone(arg2.tryOn.OutfitTryOn)
    end
    return arg1
end

tbl2[SetLastToggledLookType.name] = FFlagAXMISEnableMultiShopping and function(tbl3, arg1)
    return Cryo.Dictionary.join(tbl3 or tbl1, { LastToggledLookType = arg1.lastToggledLookType })
end or nil

return createReducer(tbl1, tbl2)
