-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Cryo = require(CorePackages.Packages.Cryo)
local UIBlox = require(CorePackages.Packages.UIBlox)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local Notification = require(scriptParentParent.Components.Notification)
local Favorites = require(scriptParentParent.Components.Favorites)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)
local Colors = require(scriptParentParent.Colors)
local Constants = require(scriptParentParent.Constants)
local getSelectionImageObjectRegular = require(scriptParentParent.getSelectionImageObjectRegular)

local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)

local iconsStatusPremium = Images["icons/status/premium"]

local var1 = Roact.PureComponent:extend("DetailsText")

function var1.init(arg1)
    arg1.name = ""
    arg1.creator = ""
    arg1.selectedImage = getSelectionImageObjectRegular()
end

function var1.setText(arg1)
    local assetInfo = arg1.props.assetInfo or {}
    local bool1 = assetInfo.parentBundleId ~= nil

    local bundleInfo = arg1.props.bundleInfo or {}

    if bool1 then
        local bundleId = UtilityFunctions.getBundleId(assetInfo)
        if bundleInfo[bundleId] then
            arg1.name = bundleInfo[bundleId].name or ""
            arg1.creator = bundleInfo[bundleId].creatorName or ""
        end
    elseif assetInfo then
        arg1.name = assetInfo.name or ""
        arg1.creator = assetInfo.creatorName or ""
    end
end

function var1.render(arg1)
    arg1:setText()
    local view = arg1.props.view
    local showFavoritesCount = arg1.props.showFavoritesCount
    local assetInfo = arg1.props.assetInfo or {}
    local bool1 = assetInfo.parentBundleId ~= nil
    local var2 = arg1.props.assetBundles[assetInfo.assetId]
    local bool2 = bool1 and #var2 > 1

    local bool3 = assetInfo.premiumPricing ~= nil
    local xOffset = bool3 and IconSize.Regular + 5 or 0
    local var3 = not (Constants.LayeredAssetTypes[assetInfo.assetTypeId] == nil)
        and arg1.props.localPlayerModel
        and arg1.props.localPlayerModel.Humanoid.RigType == Enum.HumanoidRigType.R6
    local var4 = UtilityFunctions.isLimited1Point0(assetInfo)

    local var5 = nil
    if bool2 then
        var5 = Constants.NotificationKeys.MultipleBundleNoticeKey
    elseif bool1 then
        var5 = Constants.NotificationKeys.SingleBundleNoticeKey
    elseif var4 then
        var5 = Constants.NotificationKeys.LimitedItemNoticeKey
    elseif var3 then
        var5 = Constants.NotificationKeys.LayeredClothingOnR6Key
    end

    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(arg2)
            local var6 = arg2[view]
            return Roact.createElement(
                "Frame",
                {
                    Position = var6.DetailsFramePosition,
                    Size = UDim2.new(1, 0, 0, 131),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1
                },
                {
                    Layout = Roact.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                        FillDirection = Enum.FillDirection.Vertical
                    }),
                    Notification = var5 and Roact.createElement(Notification, { noticeKey = var5 }),
                    AssetName = Roact.createElement(
                        "Frame",
                        {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, -10, 0, 50),
                            LayoutOrder = 1
                        },
                        {
                            PremiumIcon = bool3
                                and Roact.createElement(
                                    "ImageLabel",
                                    Cryo.Dictionary.join(iconsStatusPremium, {
                                        AnchorPoint = Vector2.new(0, 0.5),
                                        Position = UDim2.new(0, 0, 0.5, 0),
                                        BackgroundTransparency = 1,
                                        Size = UDim2.new(0, IconSize.Regular, 0, IconSize.Regular),
                                        ImageColor3 = Color3.new(1, 1, 1)
                                    })
                                )
                                or nil,
                            PlayerName = Roact.createElement(
                                "TextLabel",
                                {
                                    BackgroundTransparency = 1,
                                    Position = UDim2.new(0, xOffset, 0, 0),
                                    Size = UDim2.new(1, xOffset, 0, 50),
                                    LayoutOrder = 1,
                                    Text = arg1.name or "",
                                    TextXAlignment = Enum.TextXAlignment.Left,
                                    TextYAlignment = Enum.TextYAlignment.Center,
                                    TextScaled = true,
                                    TextSize = 20,
                                    Font = AppFonts.default:getBold(),
                                    TextColor3 = Colors.White
                                },
                                {
                                    UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = 32 })
                                }
                            )
                        }
                    )
                        or Roact.createElement(
                            "TextLabel",
                            {
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, -10, 0, 50),
                                LayoutOrder = 1,
                                Text = arg1.name or "",
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextYAlignment = Enum.TextYAlignment.Center,
                                TextScaled = true,
                                TextSize = 20,
                                Font = AppFonts.default:getBold(),
                                TextColor3 = Colors.White
                            },
                            {
                                UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = 32 })
                            }
                        ),
                    FavoriteContainer = showFavoritesCount and Roact.createElement(Favorites)
                }
            )
        end
    })
end
return RoactRodux.connect(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        view = arg1.view,
        locale = arg1.locale,
        assetInfo = arg1.assets[assetId],
        bundleInfo = arg1.bundles,
        assetBundles = arg1.assetBundles,
        showFavoritesCount = not arg1.isSubjectToChinaPolicies
    }
end)(var1)
