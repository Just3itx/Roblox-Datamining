-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)

local function TwoPanelLabelWithDivider(tbl1)
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "auto-y size-full-0 padding-top-medium col align-x-left align-y-top gap-small",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        LabelContainer = React.createElement(
            Foundation.View,
            {
                tag = "auto-y size-full-0 row align-x-center align-y-center gap-small flex-x-between",
                LayoutOrder = 1
            },
            {
                LeftLabel = React.createElement(Foundation.Text, {
                    LayoutOrder = 1,
                    tag = "auto-xy text-title-medium content-default text-align-x-left",
                    Text = tbl1.labelProps.leftLabel
                }),
                RightLabel = if type(tbl1.labelProps.rightLabel) == "string" then React.createElement(Foundation.Text, {
                    LayoutOrder = 2,
                    tag = "auto-xy text-title-medium content-default text-align-x-right",
                    Text = tbl1.labelProps.rightLabel
                }) else tbl1.labelProps.rightLabel
            }
        ),
        Divider = if tbl1.showDivider then React.createElement(
            Foundation.Divider,
            {
                LayoutOrder = 2,
                Orientation = Enum.FillDirection.Horizontal,
                Size = UDim2.new(1, 0, 0, 1)
            }
        ) else nil
    }
    return createElement(view, tbl2, tbl3)
end

return TwoPanelLabelWithDivider
