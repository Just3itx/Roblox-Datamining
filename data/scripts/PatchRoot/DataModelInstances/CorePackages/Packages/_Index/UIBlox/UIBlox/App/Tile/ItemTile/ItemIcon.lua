-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local ItemTileEnums = require(scriptParentParent.Enum.ItemTileEnums)

local var1 = Roact.PureComponent:extend("ItemIcon")

local tbl1 = {
    [ItemTileEnums.ItemIconType.AnimationBundle] = Images["icons/status/item/bundle"],
    [ItemTileEnums.ItemIconType.Bundle] = Images["icons/status/item/bundle"],
    [ItemTileEnums.ItemIconType.DynamicHead] = Images["icons/status/dynamicHead_small"]
}

var1.validateProps = t.strictInterface({
    itemIconType = t.intersection(ItemTileEnums.ItemIconType.isEnumValue, function(arg1) -- name: isValidItemIconType
        if tbl1[arg1] then
            return true
        end

        return false, "Unknown ItemType " .. arg1
    end)
})

function var1.render(arg1)
    local itemIconType = arg1.props.itemIconType

    local image = tbl1[itemIconType]
    local var3 = image.ImageRectSize / Images.ImagesResolutionScale

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local tokens = arg2.Tokens

        return Roact.createElement(ImageSetComponent.Label, {
            AnchorPoint = Vector2.new(1, 1),
            BackgroundTransparency = 1,
            Image = image,
            ImageColor3 = theme.IconEmphasis.Color,
            ImageTransparency = theme.IconEmphasis.Transparency,
            Position = UDim2.new(1, -tokens.Size.Size_200, 1, -tokens.Size.Size_200),
            Size = UDim2.new(0, var3.X, 0, var3.Y)
        })
    end)
end

return var1
