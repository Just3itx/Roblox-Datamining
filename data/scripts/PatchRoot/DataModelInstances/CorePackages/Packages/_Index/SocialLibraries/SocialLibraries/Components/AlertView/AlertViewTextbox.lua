-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local Cryo = dependencies.Cryo
local Images = require(script.Parent.Images)
local normalizeFontFace = dependencies.Foundation.Utility.normalizeFontFace

local ghostGrey = Color3.fromRGB(200, 200, 200)
local rect = Rect.new(7, 8, 7, 8)

local var1 = Roact.PureComponent:extend("AlertViewTextbox")

var1.defaultProps = { LayoutOrder = 0, Text = "", PlaceholderText = nil }

function var1.render(arg1)
    return UIBlox.Style.withStyle(function(arg2)
        local vector2 = Vector2.new(0, 0)
        local vector2_2 = Vector2.new(0, 0)

        local font = arg2.Font
        local layoutOrder = arg1.props.LayoutOrder
        local placeholderText = arg1.props.PlaceholderText
        local theme = arg2.Theme
        local rect2 = rect

        local createElement = Roact.createElement
        local tbl1 = {
            ImageRectSize = vector2_2,
            BackgroundTransparency = 1,
            Image = Images.buttonStroke.Image,
            ImageColor3 = theme.UIDefault.Color,
            ImageRectOffset = vector2,
            LayoutOrder = layoutOrder,
            ScaleType = Enum.ScaleType.Slice,
            Size = UDim2.new(1, 0, 0, 30),
            SliceCenter = rect2
        }
        local tbl2 = { Textbox = 0 }
        local createElement2 = Roact.createElement
        local tbl3 = {
            BackgroundTransparency = 1,
            ClearTextOnFocus = false,
            FontFace = normalizeFontFace(font.Header2.Font),
            PlaceholderText = placeholderText,
            PlaceholderColor3 = ghostGrey,
            Position = UDim2.new(0, 6, 0, 0),
            Size = UDim2.new(1, -12, 1, 0),
            Text = arg1.props.Text,
            TextColor3 = theme.TextDefault.Color,
            TextSize = font.BaseSize * font.CaptionBody.RelativeSize,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left
        }
        tbl3[Roact.Change.Text] = function(arg3)
            if arg1.props.onTextChanged then
                arg1.props.onTextChanged(arg3.Text)
            end
        end

        tbl3[Roact.Ref] = arg1.props.forwardRef
        tbl2.Textbox = createElement2("TextBox", tbl3)
        return createElement("ImageLabel", tbl1, tbl2)
    end)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
