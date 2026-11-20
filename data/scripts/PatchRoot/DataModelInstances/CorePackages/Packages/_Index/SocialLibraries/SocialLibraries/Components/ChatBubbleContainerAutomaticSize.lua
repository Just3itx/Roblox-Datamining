-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local Object = dependencies.LuauPolyfill.Object

local rect = Rect.new(10, 10, 11, 11)

local tbl1 = {
    isIncoming = false,
    hasTail = false,
    padding = 12,
    LayoutOrder = 0,
    isPending = false
}

tbl1[React.Change.AbsoluteSize] = function(_) end

tbl1.overrideImageColor = false

local function ChatBubbleContainer(arg1)
    local xOffset, var1 = React.useState(0)
    local var2 = arg1[React.Change.AbsoluteSize] or tbl1[React.Change.AbsoluteSize]

    return UIBlox.Style.withStyle(function(arg2)
        local var3 = arg1.children or {}
        local hasTail = arg1.hasTail or tbl1.hasTail
        local isIncoming = arg1.isIncoming or tbl1.isIncoming
        local isPending = arg1.isPending or tbl1.isPending
        local var4 = if isIncoming then arg2.Theme.UIDefault elseif isPending then arg2.Theme.UIMuted else arg2.Theme.UIEmphasis
        local color = var4.Color
        local transparency = var4.Transparency

        if arg1.overrideImageColor or tbl1.overrideImageColor then
            color = nil
            if not isPending then
                transparency = nil
            end
        end

        local uDim2 = isIncoming and UDim2.new(0, 6, 0, 0) or UDim2.new(1, -6, 0, 0)

        local uDim2_2 = isIncoming and UDim2.new(0, 0, 0, 0) or UDim2.new(1, 0, 0, 0)
        local uDim = UDim.new(0, arg1.padding or tbl1.padding)

        local createElement = React.createElement
        local tbl2 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.new(0, xOffset + 6, 0, 0),
            LayoutOrder = arg1.LayoutOrder or tbl1.LayoutOrder,
            BackgroundTransparency = 1
        }
        local tbl3 = { bubble = 0, tail = 0 }
        local createElement2 = React.createElement
        local tbl4 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.new(0, xOffset, 0, 0),
            AnchorPoint = isIncoming and Vector2.new(0, 0) or Vector2.new(1, 0),
            BackgroundTransparency = 1,
            ImageColor3 = color,
            Image = hasTail
                and (if isIncoming then "rbxasset://textures/ui/LuaChat/9-slice/chat-bubble.png" else "rbxasset://textures/ui/LuaChat/9-slice/chat-bubble-self.png")
                or "rbxasset://textures/ui/LuaChat/9-slice/chat-bubble-self2.png",
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = rect,
            ImageTransparency = transparency,
            Position = uDim2
        }

        tbl4[React.Change.AbsoluteSize] = function(arg3)
            var2(arg3)
        end
        local assign = Object.assign
        local var5 = table.clone(var3)
        local tbl5 = {
            ["$margin"] = React.createElement("UIPadding", { PaddingBottom = uDim, PaddingTop = uDim, PaddingRight = uDim, PaddingLeft = uDim })
        }
        local createElement3 = React.createElement
        local tbl6 = {}
        tbl6[React.Change.AbsoluteContentSize] = function(arg3)
            var1(arg3.AbsoluteContentSize.X + uDim.Offset * 2)
        end

        tbl5["$layout"] = createElement3("UIListLayout", tbl6)
        tbl3.bubble = createElement2("ImageLabel", tbl4, assign(var5, tbl5))
        tbl3.tail = React.createElement("ImageLabel", {
            AnchorPoint = isIncoming and Vector2.new(0, 0) or Vector2.new(1, 0),
            Size = UDim2.new(0, 6, 0, 6),
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

return ChatBubbleContainer
