-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local tbl1 = {
    affordance = Foundation.Enums.StateLayerAffordance.None
}

local function OptionSelector(tbl2)
    local var1 = useTokens()
    local bool1 = tbl2.isSelected == true
    local selectionStyle = tbl2.selectionStyle or "committed"
    local tag = if bool1 and selectionStyle == "intermediate" then "col gap-large size-full-0 auto-y padding-large stroke-standard stroke-contrast radius-large bg-surface-0" else "col gap-large size-full-0 auto-y padding-large stroke-standard stroke-default radius-large bg-surface-0"

    local element = React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        onActivated = tbl2.onActivated,
        stateLayer = if bool1 and selectionStyle == "committed" then tbl1 else nil,
        testId = tbl2.testId,
        tag = tag,
        ZIndex = 3
    }, {
        Content = React.createElement(View, { LayoutOrder = 1, tag = "col size-full-0 auto-y" }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl2.title,
                tag = "size-full-0 auto-y text-title-small text-wrap text-align-x-left content-emphasis"
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl2.description,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-default"
            })
        })
    })

    if not bool1 or selectionStyle ~= "committed" then
        return element
    end

    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "col size-full-0 auto-y"
    }, {
        Card = React.cloneElement(element, { LayoutOrder = 1 }),
        StackLayers = React.createElement(View, {
            LayoutOrder = 2,
            tag = "size-full-400",
            ZIndex = 1
        }, {
            FirstLayer = React.createElement(View, {
                Position = UDim2.new(0, var1.Size.Size_400, 0, -var1.Size.Size_200),
                Size = UDim2.new(1, -2 * var1.Size.Size_400, 0, var1.Size.Size_400),
                tag = "stroke-standard stroke-default radius-medium bg-surface-0",
                ZIndex = 2
            }),
            SecondLayer = React.createElement(View, {
                Position = UDim2.new(0, var1.Size.Size_800, 0, 0),
                Size = UDim2.new(1, -2 * var1.Size.Size_800, 0, var1.Size.Size_400),
                tag = "stroke-standard stroke-default radius-medium bg-surface-0",
                ZIndex = 1
            })
        })
    })
end

return OptionSelector
