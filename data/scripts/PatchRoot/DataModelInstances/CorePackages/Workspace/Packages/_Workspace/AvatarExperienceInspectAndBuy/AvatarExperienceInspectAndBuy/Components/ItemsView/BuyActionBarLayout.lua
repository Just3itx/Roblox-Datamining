-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local Divider = Foundation.Divider
local DividerOrientation = Foundation.Enums.DividerOrientation

local BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)

local function BuyActionBarLayout(tbl1)
    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Size = tbl1.Size,
        Position = tbl1.Position,
        AnchorPoint = tbl1.AnchorPoint,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder or 2,
        BorderSizePixel = 0,
        ZIndex = tbl1.ZIndex,
        Selectable = false,
        Text = "",
        AutoButtonColor = false
    }

    tbl2[React.Event.Activated] = function() end

    return createElement(str1, tbl2, {
        TopBorder = if tbl1.enableTopBorder then React.createElement(Divider, { orientation = DividerOrientation.Horizontal, Position = UDim2.new(0, 0, 0, 0) }) else nil,
        BuyActionBar = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0)
        }, {
            UIPadding = React.createElement(
                "UIPadding",
                {
                    PaddingTop = tbl1.padding,
                    PaddingBottom = tbl1.padding,
                    PaddingLeft = tbl1.padding,
                    PaddingRight = tbl1.padding
                }
            ),
            BuyActionBar = React.createElement(BuyActionBar, tbl1.buyActionBarProps)
        })
    })
end

return BuyActionBarLayout
