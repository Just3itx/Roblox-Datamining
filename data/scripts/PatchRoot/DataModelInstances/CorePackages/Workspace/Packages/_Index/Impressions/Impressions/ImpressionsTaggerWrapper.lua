-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent

local React = require(ImpressionsParent.React)

local useImpressionsTagger = require(script.Parent.useImpressionsTagger)

local function ImpressionsTagWrapper(tbl1)
    local ref = React.useRef(nil)

    useImpressionsTagger(ref, tbl1.impressionsTag, tbl1.impressionsIndex)

    return React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            LayoutOrder = tbl1.impressionsIndex,
            ref = ref
        },
        {
            ComponentWithImpressionsTag = tbl1.renderComponent()
        }
    )
end
return ImpressionsTagWrapper
