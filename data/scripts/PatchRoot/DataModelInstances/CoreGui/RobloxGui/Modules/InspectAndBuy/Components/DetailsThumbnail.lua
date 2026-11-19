-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Images = require(CorePackages.Packages.UIBlox).App.ImageSet.Images
local scriptParentParent = script.Parent.Parent
local LimitedLabel = require(scriptParentParent.Components.LimitedLabel)
local Constants = require(scriptParentParent.Constants)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)

local GetFFlagDisplayCollectiblesIcon = require(scriptParentParent.Flags.GetFFlagDisplayCollectiblesIcon)

local GetFFlagIBEnableCollectiblesSystemSupport = require(scriptParentParent.Flags.GetFFlagIBEnableCollectiblesSystemSupport)
local bool1 = game:DefineFastFlag("FixBundleThumbnailOnDetailPage", false)

local var1 = Roact.PureComponent:extend("DetailsThumbnail")

local function isPartOfBundleAndOffsale(assetInfo): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not not (assetInfo and assetInfo.parentBundleId ~= nil)
end

function var1.getUrl(arg1)
    local assetInfo = arg1.props.assetInfo
    local detailsInformation = arg1.props.detailsInformation
    local bundles = arg1.props.bundles
    local bundleId = UtilityFunctions.getBundleId(assetInfo)

    if isPartOfBundleAndOffsale(assetInfo) and bundles[bundleId] and bundles[bundleId].costumeId then
        if bool1 then
            return "rbxthumb://type=BundleThumbnail&id=" .. tostring(bundleId) .. "&w=420&h=420"
        end

        return "rbxthumb://type=Outfit&id=" .. bundles[bundleId].costumeId .. "&w=420&h=420"
    end

    return "rbxthumb://type=Asset&id=" .. detailsInformation.assetId .. "&w=420&h=420"
end

function var1.render(arg1)
    local view = arg1.props.view
    local detailsInformation = arg1.props.detailsInformation
    local tryingOnInfo = arg1.props.tryingOnInfo
    local locale = arg1.props.locale
    local assetInfo = arg1.props.assetInfo
    local iconsStatusItemLimited = Images["icons/status/item/limited"]
    local var2 = iconsStatusItemLimited and iconsStatusItemLimited.ImageRectSize / Images.ImagesResolutionScale or Vector2.new(0, 0)

    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(arg2)
            local var3 = arg2[view]
            local var4 = GetFFlagDisplayCollectiblesIcon() and UtilityFunctions.isCollectibles(assetInfo)
            local var5, var6, var7

            if GetFFlagIBEnableCollectiblesSystemSupport() and assetInfo then
                var5 = UtilityFunctions.hasLimitedQuantity(assetInfo)
                local var8 = UtilityFunctions.isLimited1Point0_LimitedUnique(assetInfo)
                    or UtilityFunctions.isLimited2Point0_Or_LimitedCollectible(assetInfo)
                local var9 = if var8 then Constants.LimitedIconFrameSizeXOffset * 2 else Constants.LimitedIconFrameSizeXOffset
                var6 = UDim2.new(0, var2.X + var9, 0, var2.Y + Constants.LimitedIconFrameSizeYOffset)

                if var8 then
                    var7 = "#" .. "    " .. RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.LimitedItems", locale)
                else
                    var7 = "    " .. RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.LimitedItems", locale)
                end
            else
                var5 = nil
                var6 = nil
                var7 = nil
            end

            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl1 = {
                Position = var3.DetailsThumbnailFramePosition,
                Size = UDim2.new(1, 0, 0, GetFFlagDisplayCollectiblesIcon() and Constants.DetailsThumbnailFrameHeight or 300),
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Visible = not tryingOnInfo.tryingOn
            }
            local tbl2 = {
                Thumbnail = detailsInformation.viewingDetails
                    and Roact.createElement("ImageLabel", {
                        Position = var3.DetailsThumbnailPosition,
                        AnchorPoint = var3.DetailsThumbnailAnchorPoint,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Image = arg1:getUrl()
                    }, {
                        AspectRatioConstraint = Roact.createElement(
                            "UIAspectRatioConstraint",
                            {
                                AspectRatio = 1,
                                AspectType = Enum.AspectType.FitWithinMaxSize,
                                DominantAxis = var3.DetailsThumbnailARDominantAxis
                            }
                        )
                    }),
                LimitedLabel = 0
            }

            if GetFFlagIBEnableCollectiblesSystemSupport() then
                var4 = var5
            end

            if var4 then
                local createElement2 = Roact.createElement
                local var8 = LimitedLabel
                local tbl3 = {
                    frameSize = 0,
                    framePosition = 0,
                    imageSize = 0,
                    imagePosition = 0,
                    textSize = 0,
                    textPosition = 0,
                    text = 0
                }

                if not GetFFlagIBEnableCollectiblesSystemSupport() then
                    var6 = UDim2.new(0, var2.X + 18, 0, var2.Y + 6)
                end

                tbl3.frameSize = var6

                tbl3.framePosition = UDim2.new(0, 0, 0, Constants.DetailsThumbnailFrameHeight - var2.Y - 8)
                tbl3.imageSize = UDim2.new(0, var2.X, 0, var2.Y)
                tbl3.imagePosition = UDim2.new(0, 4, 0, 3)
                tbl3.textSize = UDim2.new(0, 4 + var2.X, 0, var2.Y)
                tbl3.textPosition = UDim2.new(0, 5 + var2.X, 0, 3)
                if not GetFFlagIBEnableCollectiblesSystemSupport() then
                    var7 = "#" .. "    " .. RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Label.LimitedItems", locale)
                end

                tbl3.text = var7
                var4 = createElement2(var8, tbl3)
            end

            tbl2.LimitedLabel = var4
            return createElement(str1, tbl1, tbl2)
        end
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        view = arg1.view,
        tryingOnInfo = arg1.tryingOnInfo,
        detailsInformation = arg1.detailsInformation,
        assetInfo = arg1.assets[assetId],
        locale = arg1.locale,
        bundles = arg1.bundles
    }
end)(var1)
