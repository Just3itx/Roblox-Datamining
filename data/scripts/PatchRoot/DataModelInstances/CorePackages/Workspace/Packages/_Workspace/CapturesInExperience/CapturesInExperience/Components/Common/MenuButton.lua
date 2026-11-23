-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local GetTextSize = require(scriptParentParentParentParent.Style).GetTextSize

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useStyle = UIBlox.Core.Style.useStyle

return function(tbl1)
    local var1 = useStyle()

    local font = var1.Tokens.Typography.TitleLarge.Font
    local var2 = var1.Font.BaseSize * var1.Font.Header2.RelativeSize

    local xOffset = React.useMemo(function()
        if tbl1.buttonWidth then
            return tbl1.buttonWidth
        end

        return GetTextSize(tbl1.text, var2, font, Vector2.new(10000, 10000)).X + 24
    end, {
        tbl1.text,
        font,
        var2,
        tbl1.buttonWidth
    })

    local uDim2 = if tbl1.buttonHeight then UDim2.fromOffset(xOffset, tbl1.buttonHeight) else UDim2.new(0, xOffset, 1, 0)
    return React.createElement("Frame", {
        AnchorPoint = tbl1.AnchorPoint,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        Position = tbl1.Position,
        Size = uDim2
    }, {
        ShowMoreButton = React.createElement(
            Button,
            {
                buttonType = ButtonType.Secondary,
                onActivated = tbl1.onActivated,
                size = UDim2.fromScale(1, 1),
                text = tbl1.text
            }
        )
    })
end
