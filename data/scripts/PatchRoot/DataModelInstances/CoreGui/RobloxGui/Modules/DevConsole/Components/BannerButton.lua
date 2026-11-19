-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Immutable = require(script.Parent.Parent.Immutable)
local Constants = require(script.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor
local ArrowWidth = Constants.GeneralFormatting.ArrowWidth
local RightArrow = Constants.Image.RightArrow
local DownArrow = Constants.Image.DownArrow

local var1 = Roact.Component:extend("BannerButton")

function var1.render(arg1)
    local prop = arg1.props[Roact.Children] or {}

    local size = arg1.props.size
    local pos = arg1.props.pos
    local isExpandable = arg1.props.isExpandable
    local isExpanded = arg1.props.isExpanded
    local layoutOrder = arg1.props.layoutOrder
    local inset = arg1.props.inset or 0
    local hideLines = arg1.props.hideLines

    local onButtonPress = arg1.props.onButtonPress
    local onMouseEnter = arg1.props.onMouseEnter
    local onMouseLeave = arg1.props.onMouseLeave
    local onMouseMove = arg1.props.onMouseMove
    local onMouse2Click = arg1.props.onMouse2Click

    local tbl1 = {
        BannerButtonArrow = onButtonPress
            and Roact.createElement("ImageLabel", {
                Visible = isExpandable,
                Image = isExpanded and DownArrow or RightArrow,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, ArrowWidth, 0, ArrowWidth),
                Position = UDim2.new(0, inset, 0.5, -ArrowWidth / 2)
            })
    }

    if not hideLines then
        tbl1.HorizontalLineTop = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, LineWidth),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }
        )

        tbl1.HorizontalLineBottom = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, LineWidth),
            Position = UDim2.new(0, 0, 1, -LineWidth),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        })
    end

    return Roact.createElement("ImageButton", {
        Size = size,
        Position = pos,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,
        [Roact.Event.Activated] = onButtonPress,
        [Roact.Event.MouseEnter] = onMouseEnter,
        [Roact.Event.MouseLeave] = onMouseLeave,
        [Roact.Event.MouseMoved] = onMouseMove,
        [Roact.Event.MouseButton2Click] = onMouse2Click
    }, Immutable.JoinDictionaries(tbl1, prop))
end

return var1
