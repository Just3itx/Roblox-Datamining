-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedBadges = script:FindFirstAncestor("VerifiedBadges")

local Cryo = require(VerifiedBadges.Parent.Cryo)
local Foundation = require(VerifiedBadges.Parent.Foundation)
local React = require(VerifiedBadges.Parent.React)
local ReactRoblox = require(VerifiedBadges.Parent.ReactRoblox)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local tbl1 = {
    anchorPoint = Vector2.new(),
    position = UDim2.new(),
    color = Color3.fromHex("#fff"),
    font = Enum.Font.Gotham,
    size = UDim2.fromScale(1, 0),
    automaticSize = Enum.AutomaticSize.XY,
    verticalAlignment = Enum.VerticalAlignment.Center
}

local function EmojiWrapper(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    if var1.children then
        assert(React.Children.count(var1.children) <= 1, "EmojiWrapper can only contain one child")
    end

    if var1.emoji == "" then
        return var1.children
    end

    local textSize, var3 = React.useState(0)
    local var4, var5 = React.useState(-1)

    local var6 = React.useCallback(function(arg1)
        local absoluteSizeY = if var1.maximumEmojiSize then math.min(arg1.AbsoluteSize.Y, var1.maximumEmojiSize) else arg1.AbsoluteSize.Y

        if absoluteSizeY ~= var4 then
            var5(textSize)
            var3(absoluteSizeY)
        end
    end, { textSize, var4 })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = var1.layoutOrder,
        AnchorPoint = var1.anchorPoint,
        Position = var1.position,
        Size = var1.size,
        AutomaticSize = var1.automaticSize,
        BackgroundTransparency = 1
    }
    local tbl4 = {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = var1.horizontalAlignment,
            VerticalAlignment = var1.verticalAlignment,
            Padding = UDim.new(0, -textSize)
        }),
        ChildrenWrapper = React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            [ReactRoblox.Change.AbsoluteSize] = var6
        }, {
            Padding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, textSize) }),
            Children = React.createElement(React.Fragment, nil, var1.children)
        }),
        Emoji = 0
    }

    local createElement2 = React.createElement
    local str2 = "TextLabel"
    local tbl5 = {
        LayoutOrder = 2,
        Text = var1.emoji,
        FontFace = normalizeFontFace(var1.font),
        TextColor3 = var1.color,
        TextSize = textSize,
        BackgroundTransparency = 1,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextXAlignment = Enum.TextXAlignment.Center,
        Size = UDim2.fromOffset(textSize, textSize)
    }
    local tbl6 = {
        Button = tbl2.onActivated
            and React.createElement(
                "ImageButton",
                {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    [ReactRoblox.Event.Activated] = tbl2.onActivated
                }
            ),
        UITextSizeConstraint = React.createElement("UITextSizeConstraint", { MaxTextSize = math.max(textSize, 1), MinTextSize = 0 })
    }
    tbl4.Emoji = createElement2(str2, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end

return EmojiWrapper
