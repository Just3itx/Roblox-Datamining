-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local ItemCardIcon = require(script.Parent.ItemCardIcon)

local bool1 = game:DefineFastFlag("AXItemCardBadgeCheckText", false)

local function ItemCardBadge(tbl1)
    local var1 = useTokens()

    local tbl2 = {
        ItemCardBadgeCornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
        Border = if tbl1.displayBorder then React.createElement("UIStroke", {
            Color = var1.Color.Stroke.Default.Color3,
            Transparency = var1.Color.Stroke.Default.Transparency,
            Thickness = var1.Stroke.Thick
        }) else nil,
        ItemCardBadgeLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var1.Gap.XSmall)
        }),
        ItemCardBadgePadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, var1.Padding.Small),
            PaddingRight = UDim.new(0, var1.Padding.Small),
            PaddingTop = UDim.new(0, var1.Padding.Small),
            PaddingBottom = UDim.new(0, var1.Padding.Small)
        })
    }

    for layoutOrder, value2 in tbl1.content do
        if value2.type ~= "text" then
            local var2 = value2.icon .. tostring(layoutOrder)
            tbl2[var2] = React.createElement(ItemCardIcon, { icon = value2.icon, LayoutOrder = layoutOrder })
        elseif bool1 then
            if value2.text ~= "" then
                local var2 = value2.text .. tostring(layoutOrder)
                tbl2[var2] = React.createElement(FoundationText, {
                    textStyle = var1.Color.Content.Emphasis,
                    fontStyle = var1.Typography.TitleSmall,
                    LayoutOrder = layoutOrder,
                    Text = value2.text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2.fromScale(0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
            end
        else
            local var2 = value2.text .. tostring(layoutOrder)
            tbl2[var2] = React.createElement(FoundationText, {
                textStyle = var1.Color.Content.Emphasis,
                fontStyle = var1.Typography.TitleSmall,
                LayoutOrder = layoutOrder,
                Text = value2.text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2.fromScale(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
        end
    end

    return React.createElement("Frame", {
        BackgroundColor3 = var1.Color.OverMedia.OverMedia_100.Color3,
        BackgroundTransparency = var1.Color.OverMedia.OverMedia_100.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromScale(0, 0),
        AutomaticSize = Enum.AutomaticSize.XY
    }, tbl2)
end

return ItemCardBadge
