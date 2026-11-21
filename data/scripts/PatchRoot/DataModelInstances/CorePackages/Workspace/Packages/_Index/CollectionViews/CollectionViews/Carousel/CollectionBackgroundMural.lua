-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent

local React = require(CollectionViewsParent.React)
local useDesignTokens = require(CollectionViewsParent.Style).useDesignTokens
local useStyle = require(CollectionViewsParent.UIBlox).Core.Style.useStyle
local useTokens = require(CollectionViewsParent.Foundation).Hooks.useTokens
local FFlagSduiComponentsUseFoundationTokens = require(CollectionViewsParent.SharedFlags).FFlagSduiComponentsUseFoundationTokens

return React.memo(function(tbl1) -- name: CollectionBackgroundMural
    local color3, color

    if FFlagSduiComponentsUseFoundationTokens then
        local var1 = useTokens()
        color3 = var1.Color.Extended.Black.Black_100.Color3
        color = var1.Color.Surface.Surface_0.Color3
    else
        color = useStyle().Theme.BackgroundDefault.Color

        color3 = useDesignTokens().Color.Extended.Black.Black_100.Color3
    end

    return React.createElement("ImageLabel", {
        ImageTransparency = 0,
        Image = tbl1.backgroundMuralUrl,
        BackgroundTransparency = 1,
        Size = tbl1.containerSizeBinding:map(function(vector2: Vector2): UDim2
            return UDim2.new(1, 0, 0, vector2.Y)
        end),
        ZIndex = tbl1.ZIndex or -1,
        LayoutOrder = tbl1.LayoutOrder,
        ScaleType = Enum.ScaleType.Crop
    }, {
        GradientFrame = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 0,
            BorderSizePixel = 0
        }, {
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, color3), ColorSequenceKeypoint.new(1, color) }),
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
            })
        })
    })
end)
