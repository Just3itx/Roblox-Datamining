-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local memoize = require(AppChatParent.AppCommonLib).memoize
local UIBlox = require(AppChatParent.UIBlox)
local Foundation = require(AppChatParent.Foundation)
local GetTextSize = require(AppChatParent.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local withStyle = UIBlox.Style.withStyle

local var1 = Roact.PureComponent:extend("SystemMessage")
var1.defaultProps = {
    LayoutOrder = nil,
    Text = "PLACEHOLDER This message could not be displayed",
    maxWidth = 250
}

function var1.init(arg1)
    arg1.calculateSize = memoize(function(arg2, x: number?, arg3, arg4)
        return GetTextSize(arg2, arg4, arg3, Vector2.new(x, 1000))
    end)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local captionBody = arg2.Font.CaptionBody
        local textSize = arg2.Font.BaseSize * captionBody.RelativeSize

        local size = arg1.calculateSize(arg1.props.Text, arg1.props.maxWidth, arg2.Tokens.Typography.BodySmall.Font, textSize)

        local createElement = Roact.createElement
        local tbl1 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = arg1.props.LayoutOrder,
            Size = UDim2.new(1, 0, 0, 30 + size.Y + 8)
        }
        local tbl2 = {
            UiListLayout = Roact.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 20) }),
            GreyBox = Roact.createElement("ImageLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BorderSizePixel = 0,
                Image = "rbxasset://textures/ui/LuaChat/9-slice/system-message.png",
                ImageTransparency = 1,
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                ScaleType = Enum.ScaleType.Slice,
                Size = UDim2.new(0, math.min(arg1.props.maxWidth, size.X) + 12, 0, size.Y + 8),
                SliceCenter = Rect.new(3, 3, 4, 4)
            }, {
                SystemText = Roact.createElement("TextLabel", {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.BodySmall.Font),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = arg1.props.Text,
                    TextColor3 = arg2.Theme.TextDefault.Color,
                    TextSize = textSize,
                    TextTransparency = arg2.Theme.TextDefault.Transparency,
                    TextWrapped = true
                })
            })
        }
        return createElement("Frame", tbl1, tbl2)
    end)
end

return var1
