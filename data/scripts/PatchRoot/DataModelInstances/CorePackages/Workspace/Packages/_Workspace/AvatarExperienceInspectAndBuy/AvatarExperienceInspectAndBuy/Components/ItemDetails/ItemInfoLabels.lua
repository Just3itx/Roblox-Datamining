-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local TwoPanelLabelWithDivider = require(AvatarExperienceInspectAndBuy.Components.Common.TwoPanelLabelWithDivider)

local function ItemInfoLabels(tbl1)
    local tbl2 = ({})

    for layoutOrder, itemInfoLabel in tbl1.itemInfoLabels do
        if not itemInfoLabel.isVisible then
            continue
        end

        local key = itemInfoLabel.key
        tbl2[key] = React.createElement(
            TwoPanelLabelWithDivider,
            {
                LayoutOrder = layoutOrder,
                labelProps = itemInfoLabel.labelProps,
                showDivider = true
            }
        )
    end

    return React.createElement(Foundation.View, {
        tag = "auto-y size-full-0 padding-top-medium col align-x-left align-y-top gap-small",
        LayoutOrder = tbl1.LayoutOrder or 4
    }, tbl2)
end

return ItemInfoLabels
