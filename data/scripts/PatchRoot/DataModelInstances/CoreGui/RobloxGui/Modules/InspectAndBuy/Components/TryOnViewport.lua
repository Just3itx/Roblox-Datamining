-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Constants = require(scriptParentParent.Constants)
local AvatarViewport = require(scriptParentParent.Components.AvatarViewport)
local GetHumanoidDescriptionFromCostumeId = require(scriptParentParent.Thunks.GetHumanoidDescriptionFromCostumeId)

local GetFFlagDisplayCollectiblesIcon = require(scriptParentParent.Flags.GetFFlagDisplayCollectiblesIcon)

local var1 = Roact.PureComponent:extend("TryOnViewport")

local function isPartOfBundleAndOffsale(assetInfo): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return if assetInfo then assetInfo.parentBundleId ~= nil and not assetInfo.isForSale else false
end

local function createDefaultHumanoidDescriptionAccessoryInfo(assetTypeId, assetId) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        AssetId = tonumber(assetId),
        Order = Constants.LayeredClothingOrder[assetTypeId],
        AccessoryType = Constants.AssetTypeIdToAccessoryTypeEnum[assetTypeId],
        IsLayered = Constants.LayeredAssetTypes[assetTypeId] ~= nil
    }
end

function var1.init(arg1)
    arg1.model = arg1.props.localPlayerModel
    arg1.model.HumanoidRootPart.Anchored = true
    arg1.humanoidDescriptions = {}
    arg1.humanoidDescriptionForLocalPlayer = arg1.model.Humanoid.HumanoidDescription
    arg1.state = {
        obtainedHumanoidDescriptions = {}
    }
end

function var1.didMount(arg1)
    arg1.isMounted = true
end

function var1.didUpdate(arg1, arg2)
    local assetInfo = arg1.props.assetInfo
    local bundles = arg1.props.bundles
    local tryingOnInfo = arg1.props.tryingOnInfo

    if tryingOnInfo == arg2.tryingOnInfo or not tryingOnInfo.tryingOn or not isPartOfBundleAndOffsale(assetInfo) then
        return
    end

    local costumeId = bundles[assetInfo.parentBundleId].costumeId

    if not costumeId then
        return
    end
    arg1.props.getHumanoidDescriptionFromCostumeId(costumeId, function(arg3)
        if not arg1 or not arg1.isMounted then
            return
        end

        arg1.humanoidDescriptions[costumeId] = arg3
        arg1:setState(
            {
                obtainedHumanoidDescriptions = Cryo.Dictionary.join(arg1.state.obtainedHumanoidDescriptions, { [costumeId] = true })
            }
        )
    end)
end

function var1.tryOnBundleWithoutCostumeId(arg1, arg2, arg3)
    local tbl1 = ({})
    local tbl2 = ({})
    local bool1 = false

    for _, assetId in pairs(arg1.props.bundles[arg2].assetIds) do
        local asset = arg1.props.assets[assetId]
        local var2 = Constants.AssetTypeIdToAccessoryTypeEnum[asset.assetTypeId]
        if not var2 then
            continue
        end

        tbl1[var2] = true
        local var3 = Constants.AssetTypeToAssetCategory[asset.assetTypeId]
        if var3 then
            tbl2[var3] = true
        end

        bool1 = true
    end

    local accessories = arg3:GetAccessories(true)
    local tbl3 = {}

    if bool1 then
        for _, value in pairs(accessories) do
            local var2 = Constants.AccessoryTypeEnumToAssetTypeId[value.AccessoryType]
            local var3 = Constants.AssetTypeToAssetCategory[var2]
            local bool2 = not (var3 and tbl2[var3])

            if not tbl1[value.AccessoryType] and bool2 then
                table.insert(tbl3, value)
            end
        end
    end

    for _, assetId in pairs(arg1.props.bundles[arg2].assetIds) do
        local asset = arg1.props.assets[assetId]
        if Constants.AssetTypeIdToAccessoryTypeEnum[asset.assetTypeId] then
            table.insert(tbl3, createDefaultHumanoidDescriptionAccessoryInfo(asset.assetTypeId, assetId))
        else
            arg3[Constants.AssetTypeIdStringToHumanoidDescriptionProp[asset.assetTypeId]] = assetId
        end
    end

    if bool1 then
        arg3:SetAccessories(tbl3, true)
    end

    return arg3
end

function var1.render(arg1)
    local assetInfo = arg1.props.assetInfo
    local bundles = arg1.props.bundles
    local tryingOnInfo = arg1.props.tryingOnInfo
    local humanoidDescriptionForLocalPlayerClone = arg1.humanoidDescriptionForLocalPlayer:Clone()
    local tryingOn = tryingOnInfo.tryingOn
    local setScrollingEnabled = arg1.props.setScrollingEnabled

    if tryingOnInfo and tryingOnInfo.tryingOn then
        if isPartOfBundleAndOffsale(assetInfo) then
            local parentBundleId = assetInfo.parentBundleId
            local costumeId = bundles[parentBundleId].costumeId

            if costumeId then
                local humanoidDescription = arg1.humanoidDescriptions[costumeId]
                tryingOn = arg1.state.obtainedHumanoidDescriptions[costumeId] == true
                if humanoidDescription then
                    for k, value in pairs(Constants.AssetTypeIdStringToHumanoidDescriptionProp) do
                        if Constants.AssetTypeIdToAccessoryTypeEnum[k] == nil
                            and tonumber(humanoidDescription[value])
                            and tostring(humanoidDescription[value]) ~= "0"
                        then
                            humanoidDescriptionForLocalPlayerClone[value] = humanoidDescription[value]
                        end
                    end

                    humanoidDescriptionForLocalPlayerClone:SetAccessories(humanoidDescription:GetAccessories(true), true)
                end
            else
                humanoidDescriptionForLocalPlayerClone = arg1:tryOnBundleWithoutCostumeId(parentBundleId, humanoidDescriptionForLocalPlayerClone)
            end
        elseif Constants.AssetTypeIdToAccessoryTypeEnum[tryingOnInfo.assetTypeId] then
            local var2 = Constants.AssetTypeIdToAccessoryTypeEnum[tryingOnInfo.assetTypeId]
            local accessories = humanoidDescriptionForLocalPlayerClone:GetAccessories(true)
            local tbl1 = {}

            for _, value in pairs(accessories) do
                local var3 = Constants.AccessoryTypeEnumToAssetTypeId[value.AccessoryType]
                local var4 = Constants.AssetTypeToAssetCategory[tryingOnInfo.assetTypeId]
                local var5 = Constants.AssetTypeToAssetCategory[var3]
                local bool1 = not var4 or var5 ~= var4

                if value.AccessoryType ~= var2 and bool1 then
                    table.insert(tbl1, value)
                end
            end

            table.insert(tbl1, (createDefaultHumanoidDescriptionAccessoryInfo(tryingOnInfo.assetTypeId, tryingOnInfo.assetId)))
            humanoidDescriptionForLocalPlayerClone:SetAccessories(tbl1, true)
        else
            humanoidDescriptionForLocalPlayerClone[Constants.AssetTypeIdStringToHumanoidDescriptionProp[tryingOnInfo.assetTypeId]] = tryingOnInfo.assetId
        end
    end

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, GetFFlagDisplayCollectiblesIcon() and Constants.DetailsThumbnailFrameHeight or 300),
        LayoutOrder = 2,
        Visible = tryingOn
    }, {
        AvatarViewport = Roact.createElement(AvatarViewport, {
            size = UDim2.new(0.75, 0, 1, 0),
            position = UDim2.new(0.5, 0, 0.5, 0),
            humanoidDescription = humanoidDescriptionForLocalPlayerClone,
            model = arg1.model,
            visible = true,
            backgroundTransparency = 1,
            setScrollingEnabled = setScrollingEnabled
        })
    })
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        assets = arg1.assets,
        assetInfo = arg1.assets[assetId],
        bundles = arg1.bundles,
        tryingOnInfo = arg1.tryingOnInfo
    }
end, function(arg1)
    return {
        getHumanoidDescriptionFromCostumeId = function(arg2, arg3)
            return arg1(GetHumanoidDescriptionFromCostumeId(arg2, arg3))
        end
    }
end)(var1)
