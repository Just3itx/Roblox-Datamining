-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent

local React = require(IAPExperienceParent.React)

local Foundation = require(IAPExperienceParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

local combineReactTags = require(IAPExperienceParent.RoactUtils).combineReactTags

local function PriceLineItem(tbl1)
    local textStyle = tbl1.textStyle or "text-body-small content-emphasis"
    local tag = React.useMemo(function()
        return combineReactTags("auto-y", textStyle, "content-emphasis", "text-align-x-left", "text-wrap")
    end, { textStyle })
    local var1 = React.useMemo(function()
        return combineReactTags("auto-y", textStyle, "content-emphasis", "text-align-x-right")
    end, { textStyle })

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = tbl1.tag or "row size-full-0 auto-y align-y-top padding-x-xsmall"
        },
        {
            Label = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    Text = tbl1.label,
                    Size = UDim2.new(0.8, 0, 0, 0),
                    tag = tag,
                    RichText = true
                }
            ),
            Amount = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = tbl1.amount,
                    Size = UDim2.new(0.2, 0, 0, 0),
                    tag = var1,
                    RichText = true
                }
            )
        }
    )
end
return PriceLineItem
