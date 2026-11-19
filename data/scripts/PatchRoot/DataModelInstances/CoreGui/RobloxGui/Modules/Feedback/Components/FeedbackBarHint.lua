-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)
local Roact = require(CorePackages.Packages.Roact)

local withStyle = UIBlox.Core.Style.withStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local bool1 = game:DefineFastFlag("FeedbackBarHintSizeAdjustment", false)

local var1 = Roact.PureComponent:extend("FeedbackBarHint")

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.integer),
    text = t.string,
    maxWidth = t.optional(t.number),
    hintTextSize = t.optional(t.number)
})

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            LayoutOrder = arg1.props.layoutOrder,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X
        }
        local tbl2 = {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 8)
            }),
            FeedbackBarHintText = Roact.createElement(StyledTextLabel, {
                textSize = arg1.props.hintTextSize,
                maxSize = if arg1.props.maxWidth then if bool1 then Vector2.new(1000, arg1.props.maxWidth) else Vector2.new(arg1.props.maxWidth) else nil,
                layoutOrder = 2,
                fontStyle = font.Header2,
                colorStyle = theme.TextEmphasis,
                automaticSize = if arg1.props.maxWidth then nil else Enum.AutomaticSize.X,
                fluidSizing = not not arg1.props.maxWidth,
                text = arg1.props.text,
                textTruncate = if arg1.props.maxWidth then Enum.TextTruncate.AtEnd else nil,
                textXAlignment = Enum.TextXAlignment.Left,
                textYAlignment = Enum.TextYAlignment.Center
            })
        }
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
