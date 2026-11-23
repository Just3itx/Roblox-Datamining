-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextService = game:GetService("TextService")
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)

local var1 = Roact.PureComponent:extend("NoticeText")
local defaultProps = {
    AnchorPoint = Vector2.new(0, 0),
    Font = Enum.Font.Gotham,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    LayoutOrder = 1,
    Position = UDim2.new(0, 0, 0, 0),
    Text = "PLACEHOLDER Not everyone in this chat can see your message.",
    TextColor3 = nil,
    TextSize = 17,
    TextTransparency = nil,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
}

defaultProps[Roact.Change.AbsoluteSize] = function() end

defaultProps.margin = { top = 0, left = 0, right = 0, bottom = 0 }

defaultProps.maxWidth = 0
defaultProps.width = UDim.new(1, 0)
var1.defaultProps = defaultProps

function var1.render(arg1)
    local x = math.max(0, arg1.props.maxWidth - (arg1.props.margin.left + arg1.props.margin.right))

    local vector2 = Vector2.new(x, math.huge)
    local vector2_2 = TextService:GetTextSize(arg1.props.Text, arg1.props.TextSize, arg1.props.Font, vector2)

    local createElement = Roact.createElement
    local tbl2 = {
        AnchorPoint = arg1.props.AnchorPoint,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = arg1.props.LayoutOrder,
        Position = arg1.props.Position,
        [Roact.Change.AbsoluteSize] = arg1.props[Roact.Change.AbsoluteSize],
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(arg1.props.width, UDim.new(0, 0))
    }
    local tbl3 = {
        Layout = Roact.createElement("UIListLayout", { HorizontalAlignment = arg1.props.HorizontalAlignment }),
        Padding = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, arg1.props.margin.bottom),
            PaddingRight = UDim.new(0, arg1.props.margin.right),
            PaddingLeft = UDim.new(0, arg1.props.margin.left),
            PaddingTop = UDim.new(0, arg1.props.margin.top)
        }),
        NoticeText = Roact.createElement(
            "TextLabel",
            {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Font = arg1.props.Font,
                Text = arg1.props.Text,
                TextColor3 = arg1.props.TextColor3,
                TextSize = arg1.props.TextSize,
                TextTransparency = arg1.props.TextTransparency,
                TextWrapped = arg1.props.TextWrapped,
                TextXAlignment = arg1.props.TextXAlignment,
                TextYAlignment = arg1.props.TextYAlignment,
                Size = UDim2.fromOffset(math.ceil(vector2_2.X), math.ceil(vector2_2.Y))
            },
            {
                SizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(x, math.huge) })
            }
        )
    }
    return createElement("Frame", tbl2, tbl3)
end

return var1
