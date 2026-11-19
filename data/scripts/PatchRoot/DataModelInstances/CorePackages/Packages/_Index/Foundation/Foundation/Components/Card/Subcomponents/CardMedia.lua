-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:30:47Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)

local function CardMedia(tbl1)
    local var1 = nil
    local var2 = nil
    local var3

    if tbl1.isEnd then
        var3 = UDim2.new(0, tbl1.width, if tbl1.isFillHeight then 1 else 0, 0)
        var1 = {
            MaxSize = Vector2.new(tbl1.width, math.huge)
        }
        var2 = {
            FlexMode = Enum.UIFlexMode.Shrink,
            ItemLineAlignment = Enum.ItemLineAlignment.Stretch
        }
    else
        var3 = UDim2.new(1, 0, 0, tbl1.bottomHeight)
    end

    return React.createElement(Image, {
        Image = tbl1.image,
        ScaleType = Enum.ScaleType.Crop,
        tag = tbl1.tag,
        Size = var3,
        sizeConstraint = var1,
        flexItem = var2,
        LayoutOrder = 2,
        testId = `{tbl1.testId}--image`
    })
end

return CardMedia
