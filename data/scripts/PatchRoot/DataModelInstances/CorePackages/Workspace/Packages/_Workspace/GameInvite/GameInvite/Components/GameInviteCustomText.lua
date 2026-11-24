-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)
local UIBlox = require(GameInviteParent.UIBlox)
local normalizeFontFace = require(GameInviteParent.Foundation).Utility.normalizeFontFace
local GameInviteConstants = require(GameInvite.GameInviteConstants)

local useStyle = UIBlox.Core.Style.useStyle

local SidePadding = GameInviteConstants.Layout.SidePadding

return function(tbl1)
    local var1 = useStyle()
    local theme = var1.Theme
    local font = var1.Font

    local textSize = font.BaseSize * font.Body.RelativeSize

    return React.createElement(
        "Frame",
        {
            Size = tbl1.size,
            LayoutOrder = tbl1.layoutOrder,
            BackgroundTransparency = 1,
            ClipsDescendants = true
        },
        {
            UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, SidePadding), PaddingRight = UDim.new(0, SidePadding) }),
            CustomText = React.createElement("TextLabel", {
                Text = tbl1.promptMessage,
                TextSize = textSize,
                TextColor3 = theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.Transparency,
                FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            })
        }
    )
end
