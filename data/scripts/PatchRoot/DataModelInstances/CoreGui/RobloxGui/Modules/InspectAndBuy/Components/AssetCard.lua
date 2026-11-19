-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local scriptParentParent = script.Parent.Parent
local Images = require(CorePackages.Packages.UIBlox).App.ImageSet.Images
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local Colors = require(scriptParentParent.Colors)
local Constants = require(scriptParentParent.Constants)
local SetDetailsInformation = require(scriptParentParent.Actions.SetDetailsInformation)
local getSelectionImageObjectRegular = require(scriptParentParent.getSelectionImageObjectRegular)
local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)
local LimitedLabel = require(scriptParentParent.Components.LimitedLabel)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)

local GetFFlagDisplayCollectiblesIcon = require(scriptParentParent.Flags.GetFFlagDisplayCollectiblesIcon)

local GetFFlagIBEnableCollectiblesSystemSupport = require(scriptParentParent.Flags.GetFFlagIBEnableCollectiblesSystemSupport)

local var1 = Roact.Component:extend("AssetCard")

function var1.init(arg1)
    arg1.selectedImage = getSelectionImageObjectRegular()
end

function var1.render(arg1)
    local view = arg1.props.view
    local equipped = arg1.props.equipped
    local assetInfo = arg1.props.assetInfo
    local openDetails = arg1.props.openDetails
    local assetCardSizeX = arg1.props.assetCardSizeX
    local iconsStatusItemLimited = Images["icons/status/item/limited"]
    local var2 = iconsStatusItemLimited and iconsStatusItemLimited.ImageRectSize / Images.ImagesResolutionScale or Vector2.new(0, 0)

    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(arg2)
            local var3 = arg2[view]
            local var4 = GetFFlagDisplayCollectiblesIcon() and UtilityFunctions.isCollectibles(assetInfo)
            local var5, var6, var7

            if GetFFlagIBEnableCollectiblesSystemSupport() then
                var5 = UtilityFunctions.hasLimitedQuantity(assetInfo)
                var6 = UtilityFunctions.isLimited1Point0_LimitedUnique(assetInfo)
                    or UtilityFunctions.isLimited2Point0_Or_LimitedCollectible(assetInfo)
                local var8 = if var6 then Constants.LimitedIconFrameSizeXOffset * 2 else Constants.LimitedIconFrameSizeXOffset
                var7 = UDim2.new(0, var2.X + var8, 0, var2.Y + Constants.LimitedIconFrameSizeYOffset)
            else
                var5 = nil
                var7 = nil
                var6 = nil
            end

            local createElement = Roact.createElement
            local str1 = "ImageButton"
            local tbl1 = {
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                BackgroundColor3 = Colors.Gray2,
                Selectable = true,
                SelectionImageObject = arg1.selectedImage
            }

            tbl1[Roact.Event.Activated] = function()
                openDetails(assetInfo.assetId)
            end
            local tbl2 = {
                AssetThumbnail = 0,
                AssetNameBackground = 0,
                EquippedFrame = 0,
                Corner = 0,
                LimitedLabel = 0
            }
            local createElement2 = Roact.createElement
            local tbl3 = {
                Size = UDim2.new(1, 0, 0, assetCardSizeX),
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                BackgroundColor3 = Colors.Graphite,
                Selectable = false,
                AutoButtonColor = false,
                Image = "rbxthumb://type=Asset&id=" .. assetInfo.assetId .. "&w=150&h=150"
            }

            tbl3[Roact.Event.Activated] = function()
                openDetails(assetInfo.assetId)
            end

            tbl2.AssetThumbnail = createElement2("ImageButton", tbl3)

            tbl2.AssetNameBackground = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, -assetCardSizeX),
                Position = UDim2.new(0, 0, 0, assetCardSizeX),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(44, 45, 47)
            }, {
                AssetName = Roact.createElement(
                    "TextLabel",
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, -10, 1, -10),
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Position = UDim2.new(0, 5, 0, 5),
                        TextWrapped = true,
                        Text = assetInfo.name or "",
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Center,
                        TextSize = 12,
                        TextScaled = true,
                        Font = AppFonts.default:getDefault(),
                        TextColor3 = Color3.new(1, 1, 1)
                    },
                    {
                        UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = var3.AssetTextMaxSize })
                    }
                )
            })
            tbl2.EquippedFrame = Roact.createElement("ImageLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = 2,
                Visible = equipped,
                Image = "rbxasset://textures/ui/InspectMenu/gr-item-selector.png",
                ImageColor3 = Colors.Green,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(2.5, 2.5, 2.5, 2.5)
            })
            tbl2.Corner = Roact.createElement("ImageLabel", {
                Position = UDim2.new(1, -25, 0, 0),
                Size = UDim2.new(0, 25, 0, 25),
                BackgroundTransparency = 1,
                ZIndex = 2,
                Visible = equipped,
                Image = "rbxasset://textures/ui/InspectMenu/gr-item-selector-triangle.png",
                ImageColor3 = Colors.Green
            })

            if GetFFlagIBEnableCollectiblesSystemSupport() then
                var4 = var5
            end

            if var4 then
                local createElement3 = Roact.createElement
                local var8 = LimitedLabel
                local tbl4 = {
                    frameSize = 0,
                    framePosition = 0,
                    imageSize = 0,
                    imagePosition = 0,
                    textSize = 0,
                    textPosition = 0,
                    text = 0
                }

                if not GetFFlagIBEnableCollectiblesSystemSupport() then
                    var7 = UDim2.new(0, var2.X + 18, 0, var2.Y + 4)
                end

                tbl4.frameSize = var7

                tbl4.framePosition = UDim2.new(0, 16, 0, assetCardSizeX - var2.Y - 20)
                tbl4.imageSize = UDim2.new(0, var2.X, 0, var2.Y)
                tbl4.imagePosition = UDim2.new(0, 5, 0, 2)
                tbl4.textSize = UDim2.new(0, var2.X, 0, var2.Y)
                tbl4.textPosition = UDim2.new(0, 5 + var2.X, 0, 2)
                tbl4.text = if not GetFFlagIBEnableCollectiblesSystemSupport() or var6 then "#" else nil
                var4 = createElement3(var8, tbl4)
            end

            tbl2.LimitedLabel = var4
            return createElement(str1, tbl1, tbl2)
        end
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, arg2)
    local assetId = arg2.assetInfo.assetId

    return {
        view = arg1.view,
        equipped = arg1.equippedAssets[assetId] == true,
        locale = arg1.locale
    }
end, function(callback)
    return {
        openDetails = function(arg1)
            callback(SetDetailsInformation(true, arg1))
        end
    }
end)(var1)
