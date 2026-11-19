-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local DetailsText = require(scriptParentParent.Components.DetailsText)
local DetailsThumbnail = require(scriptParentParent.Components.DetailsThumbnail)
local DetailsDescription = require(scriptParentParent.Components.DetailsDescription)
local DetailsButtons = require(scriptParentParent.Components.DetailsButtons)
local TryOnViewport = require(scriptParentParent.Components.TryOnViewport)
local OpenOverlay = require(scriptParentParent.Actions.OpenOverlay)
local Overlay = require(scriptParentParent.Enums.Overlay)
local GetAssetBundles = require(scriptParentParent.Thunks.GetAssetBundles)
local ReportOpenDetailsPage = require(scriptParentParent.Thunks.ReportOpenDetailsPage)
local GetEconomyProductInfo = require(scriptParentParent.Thunks.GetEconomyProductInfo)
local GetCollectibleResellableInstances = require(scriptParentParent.Thunks.GetCollectibleResellableInstances)
local Colors = require(scriptParentParent.Colors)
local Constants = require(scriptParentParent.Constants)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)
local tutils = require(CorePackages.Packages.tutils)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local ItemInfoList = require(CorePackages.Workspace.Packages.ItemDetails).ItemInfoList
local AttributionConstants = require(scriptParentParent.AttributionConstants)

local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)
local GetFFlagDisplayCollectiblesIcon = require(scriptParentParent.Flags.GetFFlagDisplayCollectiblesIcon)
local GetItemDetails = require(scriptParentParent.Thunks.GetItemDetails)
local SetAssetFromBundleInfo = require(scriptParentParent.Actions.SetAssetFromBundleInfo)

local Modules = CoreGui.RobloxGui.Modules
local Theme = require(Modules.Settings.Theme)

local ControllerBarHeight = require(CoreGui.RobloxGui.Modules.InGameMenuConstants).ControllerBarHeight

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local var1 = Roact.PureComponent:extend("AssetDetails")

function var1.setScrollingEnabled(arg1, scrollingEnabled)
    if arg1.state.scrollingEnabled ~= scrollingEnabled then
        arg1:setState({ scrollingEnabled = scrollingEnabled })
    end
end

function var1.getInfoRowProps(arg1)
    local assetInfo = arg1.props.assetInfo or {}
    local locale = arg1.props.locale

    local bool1 = assetInfo.parentBundleId ~= nil

    local tbl1 = {
        infoName = RobloxTranslator:FormatByKeyForLocale("Feature.Catalog.Label.Filter.Creator", locale),
        infoData = assetInfo.creatorName or "",
        hasVerifiedBadge = assetInfo.creatorHasVerifiedBadge,
        LayoutOrder = 1,
        Selectable = false
    }

    local var2 = nil

    local creatingUniverseId = assetInfo.creatingUniverseId
    if creatingUniverseId then
        local var3 = arg1.props.creatingExperiences[creatingUniverseId]

        if var3 then
            local playabilityStatus = var3.playabilityStatus

            if AttributionConstants.ShowPlayableAttributionMapper[playabilityStatus] then
                local name = var3.name or ""

                var2 = {
                    infoName = RobloxTranslator:FormatByKeyForLocale("Feature.Catalog.Label.Attribution", locale),
                    infoData = name,
                    onActivate = function()
                        arg1.props.openOverlay(Overlay.AttributionTraversal, var3)
                    end,
                    LayoutOrder = 2,
                    [Roact.Ref] = arg1.attributionRef,
                    Selectable = true
                }
            end
        end
    end

    local var3 = nil
    if bool1 then
        var3 = RobloxTranslator:FormatByKeyForLocale("Feature.Catalog.Label.Bundle", locale)
    else
        local var4 = Constants.AssetTypeIdToCategory[assetInfo.assetTypeId]
        local var5 = Constants.AssetCategoriesLocalized[var4]
        local var6 = Constants.AssetTypeIdToTypeLocalized[assetInfo.assetTypeId]

        if var5 and var6 then
            var3 = RobloxTranslator:FormatByKeyForLocale(var5, locale) .. " | " .. RobloxTranslator:FormatByKeyForLocale(var6, locale)
        end
    end

    return {
        tbl1,
        var2,
        {
            infoName = RobloxTranslator:FormatByKeyForLocale("Feature.Catalog.Label.CategoryType", locale),
            infoData = var3,
            LayoutOrder = 3,
            Selectable = false
        }
    }
end

function var1.init(arg1)
    arg1.state = { scrollingEnabled = true }

    arg1.attributionRef = Roact.createRef()
end

function var1.willUpdate(arg1, arg2)
    if UtilityFunctions.isCollectibles(arg1.props.assetInfo) then
        local collectibleItemId = arg1.props.assetInfo.collectibleItemId
        local resellableInstances = arg1.props.resellableInstances
        local resellableInstances2 = arg2.resellableInstances
        if resellableInstances
            and resellableInstances[collectibleItemId]
            and resellableInstances2
            and resellableInstances2[collectibleItemId]
            and tutils.fieldCount(resellableInstances[collectibleItemId]) ~= tutils.fieldCount(resellableInstances2[collectibleItemId])
        then
            arg1:setState({})
        end
    end

    local parentBundleId = arg1.props.assetInfo and arg1.props.assetInfo.parentBundleId
    local bundles = arg1.props.bundles
    local bundles2 = arg2.bundles
    if parentBundleId
        and bundles
        and bundles[parentBundleId]
        and bundles2
        and bundles2[parentBundleId]
        and bundles2[parentBundleId] ~= bundles[parentBundleId]
    then
        arg1.props.setAssetFromBundleInfo(arg1.props.assetInfo.assetId, bundles2[parentBundleId])
    end
end

function var1.didUpdate(arg1, arg2)
    local reportOpenDetailsPage = arg1.props.reportOpenDetailsPage
    local assetInfo = arg1.props.assetInfo
    local assetInfo2 = arg2.assetInfo

    if assetInfo and assetInfo ~= assetInfo2 then
        local bundles = arg1.props.bundles
        local bool1 = assetInfo.parentBundleId ~= nil
        local bundleId = bool1 and UtilityFunctions.getBundleId(assetInfo)

        if not bool1 and assetInfo.owned == nil or bool1 and bundles[bundleId].owned == nil then
            local assetId = assetInfo.assetId
            local asset = Enum.AvatarItemType.Asset
            if bool1 then
                asset = Enum.AvatarItemType.Bundle
            else
                bundleId = assetId
            end
            arg1.props.getItemDetails(bundleId, asset)
        end
    end

    if arg1.props.detailsInformation.viewingDetails and not arg2.detailsInformation.viewingDetails then
        reportOpenDetailsPage(assetInfo)
    end
end

function var1.render(arg1)
    local view = arg1.props.view
    local detailsInformation = arg1.props.detailsInformation
    local assetInfo = arg1.props.assetInfo or {}
    local localPlayerModel = arg1.props.localPlayerModel
    local scrollingEnabled = arg1.state.scrollingEnabled
    local locale = arg1.props.locale
    local iconsStatusItemOwned = Images["icons/status/item/owned"]
    local var2 = iconsStatusItemOwned and iconsStatusItemOwned.ImageRectSize / Images.ImagesResolutionScale or Vector2.new(0, 0)

    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(arg2)
            local var3 = arg2[view]
            local num1 = 0
            local var4

            if GetFFlagDisplayCollectiblesIcon() and UtilityFunctions.isCollectibles(assetInfo) then
                local getCollectibleResellableInstances = arg1.props.getCollectibleResellableInstances
                local resellableInstances = arg1.props.resellableInstances
                local userId = Players.LocalPlayer and Players.LocalPlayer.UserId

                getCollectibleResellableInstances(assetInfo.collectibleItemId, userId)
                var4 = resellableInstances
                    and resellableInstances[assetInfo.collectibleItemId]
                    and tutils.fieldCount(resellableInstances[assetInfo.collectibleItemId])
                    or 0
            else
                var4 = 0
            end

            local var5 = UtilityFunctions.isLimited2Point0_Or_LimitedCollectible(assetInfo)

            if arg1.props.gamepadEnabled then
                num1 = -1 * ControllerBarHeight
            end
            local yOffset = num1 + -Theme.DefaultCornerRadius.Offset

            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl1 = {
                Position = UDim2.new(0, var3.BorderPaddingSize, 0, 0),
                Size = UDim2.new(1, -(2 * var3.BorderPaddingSize), 1, yOffset),
                BackgroundTransparency = 0,
                BackgroundColor3 = Colors.Carbon,
                BorderSizePixel = 0,
                Visible = detailsInformation.viewingDetails
            }

            local tbl2 = {
                DetailsButtons = Roact.createElement(DetailsButtons, { localPlayerModel = localPlayerModel }),
                Container = Roact.createElement("ScrollingFrame", {
                    BackgroundTransparency = 1,
                    ScrollBarThickness = 0,
                    Size = UDim2.new(1, 0, 1, -55),
                    ScrollingEnabled = scrollingEnabled,
                    Selectable = false,
                    CanvasSize = UDim2.new(1, 0, 0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y
                }, {
                    UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10) }),
                    DetailsThumbnail = Roact.createElement(DetailsThumbnail),
                    TryOnViewport = if isInExperienceUIVREnabled then if detailsInformation.viewingDetails and localPlayerModel then Roact.createElement(TryOnViewport, {
                        localPlayerModel = localPlayerModel,
                        setScrollingEnabled = function(arg3)
                            arg1:setScrollingEnabled(arg3)
                        end
                    }) else nil else localPlayerModel and Roact.createElement(TryOnViewport, {
                        localPlayerModel = localPlayerModel,
                        setScrollingEnabled = function(arg3)
                            arg1:setScrollingEnabled(arg3)
                        end
                    }),
                    DetailsText = Roact.createElement(DetailsText, { localPlayerModel = localPlayerModel }),
                    ItemOwnedLabelContainer = var5
                        and Roact.createElement("Frame", {
                            Size = UDim2.new(1, 0, 0, var2.Y + 20),
                            BorderSizePixel = 0,
                            LayoutOrder = 3,
                            BackgroundColor3 = Color3.fromRGB(57, 59, 61)
                        }, {
                            Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
                            OwnedIcon = Roact.createElement(ImageSetLabel, {
                                Size = UDim2.new(0, var2.X, 0, var2.Y),
                                Position = UDim2.new(0, 12, 0, 10),
                                Image = iconsStatusItemOwned,
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0
                            }),
                            ItemOwnedLabel = Roact.createElement("TextLabel", {
                                Size = UDim2.new(0, var2.X, 0, var2.Y),
                                Position = UDim2.new(0, var2.X + 60, 0, 10),
                                Text = RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.OwnedItems", locale, { QUANTITY = tostring(var4) }),
                                Font = AppFonts.default:getDefault(),
                                TextSize = 12,
                                TextColor3 = Color3.new(1, 1, 1),
                                BackgroundTransparency = 1
                            })
                        }),
                    DetailsDescription = Roact.createElement(DetailsDescription),
                    ItemInfoList = Roact.createElement(ItemInfoList, { rowData = arg1:getInfoRowProps(), LayoutOrder = 5 })
                })
            }

            return createElement(str1, tbl1, tbl2)
        end
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        view = arg1.view,
        detailsInformation = arg1.detailsInformation,
        assetInfo = arg1.assets[assetId],
        bundles = arg1.bundles,
        gamepadEnabled = arg1.gamepadEnabled,
        locale = arg1.locale,
        resellableInstances = arg1.collectibleResellableInstances,
        creatingExperiences = arg1.creatingExperiences
    }
end, function(callback)
    return {
        getAssetBundles = function(arg1)
            callback(GetAssetBundles(arg1))
        end,
        getEconomyProductInfo = function(arg1, arg2, arg3)
            callback(GetEconomyProductInfo(arg1, arg2, arg3))
        end,
        reportOpenDetailsPage = function(arg1)
            callback(ReportOpenDetailsPage(arg1))
        end,
        getCollectibleResellableInstances = function(arg1, arg2)
            callback(GetCollectibleResellableInstances(arg1, arg2))
        end,
        openOverlay = function(arg1, arg2)
            callback(OpenOverlay(arg1, arg2))
        end,
        getItemDetails = function(arg1, arg2)
            callback(GetItemDetails(arg1, arg2))
        end,
        setAssetFromBundleInfo = function(arg1, arg2)
            callback(SetAssetFromBundleInfo(arg1, arg2))
        end
    }
end)(var1)
