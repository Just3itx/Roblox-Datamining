-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCardsParent = script:FindFirstAncestor("SocialCards").Parent

local Foundation = require(SocialCardsParent.Foundation)
local React = require(SocialCardsParent.React)

local useTokens = Foundation.Hooks.useTokens

local function AltTextCard(tbl1)
    local var1 = useTokens()

    return React.createElement(Foundation.Text, {
        AutomaticSize = Enum.AutomaticSize.XY,
        fontStyle = {
            Font = var1.Typography.BodyMedium.Font,
            FontSize = var1.Typography.BodyMedium.FontSize
        },
        padding = {
            bottom = UDim.new(0, var1.Padding.Medium),
            left = UDim.new(0, var1.Padding.Medium),
            right = UDim.new(0, var1.Padding.Medium),
            top = UDim.new(0, var1.Padding.Medium)
        },
        Text = tbl1.altText,
        textStyle = {
            Color3 = var1.Color.Content.Muted.Color3,
            Transparency = var1.Color.Content.Muted.Transparency
        },
        TextWrapped = true
    })
end

return AltTextCard
