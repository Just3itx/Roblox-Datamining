-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local ActionText = require(script.Parent.ActionText)

return React.memo(function(tbl1) -- name: ControlActionRow
    local var1 = Foundation.Hooks.useTokens()
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "row align-y-center gap-small size-full-0 auto-y",
        LayoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId .. "Row"
    }
    local tbl3 = { ActionTextContainer = 0, IconRow = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        Size = UDim2.new(1, -tbl1.iconWidth - var1.Gap.Small, 0, 0),
        tag = "auto-y",
        LayoutOrder = if tbl1.layoutOrderReversed then 2 else 1,
        testId = tbl1.testId .. "Container"
    }
    local tbl5 = {
        ActionText = React.createElement(ActionText, {
            actionLabels = tbl1.actionLabels,
            textVariant = tbl1.textVariant,
            textXAlignment = if tbl1.layoutOrderReversed then Enum.TextXAlignment.Left else Enum.TextXAlignment.Right,
            testId = tbl1.testId
        })
    }
    tbl3.ActionTextContainer = createElement2(view2, tbl4, tbl5)

    tbl3.IconRow = tbl1.icon
    return createElement(view, tbl2, tbl3)
end)
