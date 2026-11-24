-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)

return React.memo(function(tbl1) -- name: TouchControlIcon
    local var1 = Foundation.Hooks.useTokens()
    local var2 = if tbl1.iconDiameter then tbl1.diameter else var1.Size.Size_600
    local scale = if tbl1.diameter == var2 then nil else tbl1.diameter / var2
    local size = tbl1.iconDiameter or var1.Size.Size_400
    local bool1 = not (tbl1.showBackground == false) and tbl1.assetId == nil
    local style = if not bool1 or tbl1.inverted then var1.Color.Content.Emphasis else var1.Color.Surface.Surface_100
    local var6 = if tbl1.inverted then var1.Color.Surface.Surface_100 else var1.Color.Content.Muted
    local num1 = if tbl1.disabled then 0.5 else 1

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        Size = UDim2.fromOffset(var2, var2),
        scale = scale,
        Position = tbl1.Position,
        AnchorPoint = tbl1.AnchorPoint,
        LayoutOrder = tbl1.LayoutOrder,
        tag = {
            ["align-x-center align-y-center radius-circle"] = bool1,
            ["align-x-center align-y-center"] = not bool1
        },
        backgroundStyle = bool1 and {
            Color3 = var6.Color3,
            Transparency = 1 - (1 - var6.Transparency) * num1
        } or var1.Color.None,
        testId = tbl1.testId .. "Container"
    }
    local tbl3 = { Icon = 0 }
    local element

    if tbl1.assetId ~= nil then
        element = React.createElement("ImageLabel", {
            Size = UDim2.fromScale(1, 1),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = tbl1.assetId,
            ImageTransparency = 1 - num1,
            ScaleType = Enum.ScaleType.Fit,
            [React.Tag] = "data-testid=" .. tbl1.testId
        })
    else
        element = React.createElement(
            Foundation.Icon,
            {
                name = tbl1.name,
                variant = Foundation.Enums.IconVariant.Filled,
                size = size,
                style = style,
                testId = tbl1.testId
            }
        )
    end

    tbl3.Icon = element
    return createElement(view, tbl2, tbl3)
end)
