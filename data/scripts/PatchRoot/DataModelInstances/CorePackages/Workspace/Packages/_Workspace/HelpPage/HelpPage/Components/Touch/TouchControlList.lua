-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local _ActionText = require(scriptParentParentParent.Components.Common.ActionText)
local ControlActionRow = require(scriptParentParentParent.Components.Common.ControlActionRow)
local TouchControlIcon = require(script.Parent.TouchControlIcon)

return React.memo(function(tbl1) -- name: TouchControlList
    local var1 = Foundation.Hooks.useTokens()
    local showBackground = tbl1.showIconBackground ~= false
    local tbl2 = ({})
    for layoutOrder, control in ipairs(tbl1.controls) do
        local id = control.id
        local createElement = React.createElement
        local var2 = ControlActionRow
        local tbl3 = {
            textVariant = tbl1.textVariant or "label-small",
            actionLabels = {{
                label = control.label,
                disabled = control.disabled
            }},
            layoutOrderReversed = tbl1.layoutOrderReversed,
            layoutOrder = layoutOrder,
            iconWidth = var1.Size.Size_500,
            testId = "TouchActionText-" .. control.id,
            icon = React.createElement(TouchControlIcon, {
                name = control.icon,
                assetId = control.assetId,
                diameter = var1.Size.Size_500,
                iconDiameter = if showBackground then var1.Size.Size_300 else var1.Size.Size_500,
                disabled = control.disabled,
                showBackground = showBackground,
                LayoutOrder = if tbl1.layoutOrderReversed then 1 else 2,
                testId = "TouchActionIcon-" .. control.id
            })
        }
        tbl2[id] = createElement(var2, tbl3)
    end

    return React.createElement(Foundation.View, { tag = "col gap-small size-full-0 auto-y" }, tbl2)
end)
