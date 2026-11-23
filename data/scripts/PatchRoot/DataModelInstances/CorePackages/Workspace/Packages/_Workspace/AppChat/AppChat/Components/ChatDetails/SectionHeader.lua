-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RoactFitComponents = require(AppChatParent.LuaSocialLibrariesDeps).RoactFitComponents

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo

local tbl1 = {
    Text = "Default Title",
    LayoutOrder = 0,
    marginTop = 8,
    marginBottom = 14,
    style = require(AppChat.SocialLibraries).Components.TestStyle
}

function SectionHeader(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local style = var1.style
    local theme = style.Theme
    local font = style.Font

    return React.createElement(RoactFitComponents.FitFrameVertical, {
        BackgroundTransparency = 1,
        LayoutOrder = var1.LayoutOrder,
        width = UDim.new(1, 0),
        margin = {
            top = var1.marginTop,
            left = 12,
            right = 0,
            bottom = var1.marginBottom
        }
    }, {
        SectionHeader = React.createElement(RoactFitComponents.FitTextLabel, {
            width = RoactFitComponents.FitTextLabel.Width.FitToText,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = var1.Text,
            TextColor3 = theme.TextDefault.Color,
            TextSize = font.CaptionHeader.RelativeSize * font.BaseSize,
            Font = font.CaptionHeader.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            AnchorPoint = Vector2.new(0, 1)
        })
    })
end

return memo(SectionHeader)
