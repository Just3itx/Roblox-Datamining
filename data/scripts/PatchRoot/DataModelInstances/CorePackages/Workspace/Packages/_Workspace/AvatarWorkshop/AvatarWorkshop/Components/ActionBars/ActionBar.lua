-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local _ButtonVariant = Foundation.Enums.ButtonVariant

local function ActionBar(tbl1)
    local var1 = useTokens()

    local actionsLen = #tbl1.actions

    local var2 = if actionsLen > 0 then var1.Gap.Small * (actionsLen - 1) / actionsLen else 0

    local tbl2 = ({})
    for layoutOrder, action in tbl1.actions do
        local key = action.key
        local createElement = React.createElement
        local view = Foundation.View
        local tbl3 = {
            tag = "row auto-y",
            Size = UDim2.new(1 / actionsLen, -var2, 0, 0),
            LayoutOrder = layoutOrder
        }
        local tbl4 = {
            Button = React.createElement(Foundation.Button, {
                text = action.text,
                onActivated = action.onActivated,
                variant = action.variant,
                size = Foundation.Enums.ButtonSize.Medium,
                fillBehavior = Foundation.Enums.FillBehavior.Fill,
                testId = action.testId
            })
        }
        tbl2[key] = createElement(view, tbl3, tbl4)
    end

    return React.createElement(Foundation.View, { tag = "row gap-small size-full-0 auto-y" }, tbl2)
end

return ActionBar
