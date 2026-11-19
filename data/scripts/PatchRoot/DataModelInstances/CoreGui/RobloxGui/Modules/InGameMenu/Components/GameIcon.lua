-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t
local scriptParentParent = script.Parent.Parent

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Images = UIBlox.App.ImageSet.Images
local AssetImage = require(scriptParentParent.Components.AssetImage)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Image = require(CorePackages.Packages.Foundation).Image
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local getGameIconRequestSize = require(scriptParentParent.Components.getGameIconRequestSize)

local var1 = Roact.PureComponent:extend("GameIcon")

var1.validateProps = t.strictInterface({
    gameId = t.number,
    iconSize = t.numberMin(0),
    layoutOrder = t.optional(t.number),
    cornerRadius = t.optional(t.UDim),
    Position = t.optional(t.UDim2),
    AnchorPoint = t.optional(t.Vector2)
})

function var1.render(arg1)
    local iconSize = arg1.props.iconSize
    local gameIconRequestSize = getGameIconRequestSize(iconSize)
    local gameId = arg1.props.gameId
    local cornerRadius = arg1.props.cornerRadius

    local image = ("rbxthumb://type=GameIcon&id=%d&w=%d&h=%d"):format(gameId, gameIconRequestSize, gameIconRequestSize)

    if gameId ~= 0 then
        return Roact.createElement("ImageLabel", {
            Image = image,
            Size = UDim2.fromOffset(iconSize, iconSize),
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder,
            Position = arg1.props.Position,
            AnchorPoint = arg1.props.AnchorPoint
        }, {
            UICorner = if cornerRadius and cornerRadius ~= UDim.new(0, 0) then Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil else nil
        })
    end

    local num1 = if iconSize <= 44 then iconSize else 44

    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                PlaceHolder = {
                    Color = arg2.Color.Common.Shimmer.Color3,
                    Transparency = arg2.Color.Common.Shimmer.Transparency
                },
                UIDefault = {
                    Color = arg2.Color.Shift.Shift_200.Color3,
                    Transparency = arg2.Color.Shift.Shift_200.Transparency
                }
            }
        }
    end, function(arg2)
        local createElement = Roact.createElement
        local label = AssetImage.Label
        local tbl1 = {
            imageKey = "RoundedRect",
            Size = UDim2.fromOffset(iconSize, iconSize),
            ImageColor3 = arg2.Theme.PlaceHolder.Color,
            ImageTransparency = arg2.Theme.PlaceHolder.Transparency,
            LayoutOrder = arg1.props.layoutOrder,
            Position = arg1.props.Position,
            AnchorPoint = arg1.props.AnchorPoint
        }
        local tbl2 = { PlaceholderIcon = 0 }
        local element

        if FFlagCoreUiMigrateUIBloxToFoundation then
            element = Roact.createElement(Image, {
                Size = UDim2.fromOffset(num1, num1),
                Position = UDim2.fromScale(0.5, 0.5),
                Image = "icons/imageUnavailable",
                imageStyle = {
                    Color3 = arg2.Theme.UIDefault.Color,
                    Transparency = arg2.Theme.UIDefault.Transparency
                },
                AnchorPoint = Vector2.new(0.5, 0.5),
                cornerRadius = cornerRadius
            })
        else
            element = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(num1, num1),
                Position = UDim2.fromScale(0.5, 0.5),
                Image = Images["icons/imageUnavailable"],
                ImageColor3 = arg2.Theme.UIDefault.Color,
                ImageTransparency = arg2.Theme.UIDefault.Transparency,
                AnchorPoint = Vector2.new(0.5, 0.5)
            }, {
                UICorner = if cornerRadius and cornerRadius ~= UDim.new(0, 0) then Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil else nil
            })
        end

        tbl2.PlaceholderIcon = element
        return createElement(label, tbl1, tbl2)
    end)
end

return var1
