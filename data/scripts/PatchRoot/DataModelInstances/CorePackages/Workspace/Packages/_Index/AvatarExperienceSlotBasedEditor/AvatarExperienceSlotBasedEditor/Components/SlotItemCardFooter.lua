-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local React = require(AvatarExperienceSlotBasedEditorParent.React)
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Responsive = require(AvatarExperienceSlotBasedEditorParent.Responsive)

local FFlagAXAddTextXAlignmentProp = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXAddTextXAlignmentProp

local function SlotItemCardFooter(tbl1)
    local var1 = useTokens()
    local bool1 = Responsive.useOrientation() == Responsive.BreakpointConfig.Enum.Portrait

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        ItemCardFooterLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, var1.Gap.XSmall)
        }),
        ItemCardFooterInfo = 0
    }
    local var2

    if tbl1.title then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl4 = {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 1
        }

        local tbl5 = {
            ItemCardFooterInfoLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, var1.Gap.XXSmall)
            }),
            ItemCardFooterInfoTitle = 0
        }
        local element

        if tbl1.title then
            element = React.createElement(FoundationText, {
                textStyle = var1.Color.Content.Emphasis,
                fontStyle = if bool1 then var1.Typography.CaptionSmall else var1.Typography.CaptionMedium,
                LayoutOrder = 1,
                Text = tbl1.title,
                TextXAlignment = if FFlagAXAddTextXAlignmentProp and tbl1.TextXAlignment then tbl1.TextXAlignment else Enum.TextXAlignment.Left,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                TextTruncate = Enum.TextTruncate.SplitWord
            })
        else
            element = nil
        end

        tbl5.ItemCardFooterInfoTitle = element
        var2 = createElement2(str2, tbl4, tbl5)
    else
        var2 = nil
    end

    tbl3.ItemCardFooterInfo = var2
    return createElement(str1, tbl2, tbl3)
end

return SlotItemCardFooter
