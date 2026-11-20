-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local RoactFitComponents = dependencies.RoactFitComponents
local FitFrameOnAxis = RoactFitComponents.FitFrameOnAxis
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox

local rect = Rect.new(10, 10, 11, 11)

local var1 = Roact.PureComponent:extend("ChatBubbleContainer")
var1.TAIL_WIDTH = 6

local defaultProps = {
    isIncoming = false,
    hasTail = false,
    padding = 12,
    LayoutOrder = 0,
    isPending = false
}

defaultProps[Roact.Change.AbsoluteSize] = function() end

defaultProps.overrideImageColor = false
var1.defaultProps = defaultProps

function var1.init(arg1)
    local bubbleSize, updateBubbleSize = Roact.createBinding(Vector2.new(0, 0))
    arg1.bubbleSize = bubbleSize
    arg1.updateBubbleSize = updateBubbleSize
end

function var1.render(arg1)
    return UIBlox.Style.withStyle(function(arg2)
        local prop = arg1.props[Roact.Children] or {}
        local hasTail = arg1.props.hasTail
        local isIncoming = arg1.props.isIncoming
        local isPending = arg1.props.isPending
        local var2 = if isIncoming then arg2.Theme.UIDefault elseif isPending then arg2.Theme.UIMuted else arg2.Theme.UIEmphasis
        local color = var2.Color
        local transparency = var2.Transparency

        if arg1.props.overrideImageColor then
            color = nil
            if not isPending then
                transparency = nil
            end
        end

        local uDim2 = isIncoming and UDim2.new(0, arg1.TAIL_WIDTH, 0, 0) or UDim2.new(1, -arg1.TAIL_WIDTH, 0, 0)

        local uDim2_2 = isIncoming and UDim2.new(0, 0, 0, 0) or UDim2.new(1, 0, 0, 0)

        local createElement = Roact.createElement

        local tbl2 = {
            Size = arg1.bubbleSize:map(function(arg3): UDim2
                return UDim2.new(0, arg3.X + arg1.TAIL_WIDTH, 0, arg3.Y)
            end),
            LayoutOrder = arg1.props.LayoutOrder,
            BackgroundTransparency = 1
        }
        local tbl3 = { bubble = 0, tail = 0 }
        local createElement2 = Roact.createElement
        local var3 = FitFrameOnAxis
        local tbl4 = {
            AnchorPoint = isIncoming and Vector2.new(0, 0) or Vector2.new(1, 0),
            axis = FitFrameOnAxis.Axis.Both,
            BackgroundTransparency = 1,
            ImageColor3 = color,
            ImageSet = {
                Image = hasTail
                    and (if isIncoming then "rbxasset://textures/ui/LuaChat/9-slice/chat-bubble.png" else "rbxasset://textures/ui/LuaChat/9-slice/chat-bubble-self.png")
                    or "rbxasset://textures/ui/LuaChat/9-slice/chat-bubble-self2.png",
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = rect
            },
            ImageTransparency = transparency,
            margin = RoactFitComponents.Rect.square(arg1.props.padding),
            Position = uDim2
        }

        tbl4[Roact.Change.AbsoluteSize] = function(arg3)
            arg1.updateBubbleSize(arg3.AbsoluteSize)
            arg1.props[Roact.Change.AbsoluteSize](arg3)
        end

        tbl3.bubble = createElement2(var3, tbl4, prop)
        tbl3.tail = Roact.createElement("ImageLabel", {
            AnchorPoint = isIncoming and Vector2.new(0, 0) or Vector2.new(1, 0),
            Size = UDim2.new(0, arg1.TAIL_WIDTH, 0, arg1.TAIL_WIDTH),
            BackgroundTransparency = 1,
            ImageColor3 = color,
            Position = uDim2_2,
            Image = if isIncoming then "rbxasset://textures/ui/LuaChat/9-slice/chat-bubble-tip.png" else "rbxasset://textures/ui/LuaChat/9-slice/chat-bubble-self-tip.png",
            ImageTransparency = transparency,
            Visible = hasTail
        })
        return createElement("Frame", tbl2, tbl3)
    end)
end

return var1
