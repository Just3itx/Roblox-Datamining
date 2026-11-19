-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local HeaderBarSlot = require(Foundation.Enums.HeaderBarSlot)
local IconButton = require(Foundation.Components.IconButton)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local constants = require(Foundation.Components.HeaderBar.constants)
local useHeaderBarContext = require(Foundation.Components.HeaderBar.useHeaderBarContext)
local useTokens = require(Foundation.Providers.Style.useTokens)

return React.memo(function(tbl1) -- name: HeaderBarActions
    local var1 = useHeaderBarContext()
    local var2 = useTokens()

    local layoutOrder, padding = React.useMemo(function()
        if var1.slot == HeaderBarSlot.Leading then
            return constants.LEADING_ACTIONS_LAYOUT_ORDER, {
                left = UDim.new(0, -var2.Size.Size_200)
            }
        elseif var1.slot == HeaderBarSlot.Trailing then
            return constants.TRAILING_ACTIONS_LAYOUT_ORDER, {
                right = UDim.new(0, -var2.Size.Size_200)
            }
        end

        return nil, nil
    end, { var1.slot, var2.Size.Size_200 })

    local tbl2 = ({})
    for k, action in tbl1.actions do
        local str1 = tostring(action.id)
        tbl2[str1] = React.createElement(IconButton, {
            icon = action.icon,
            onActivated = action.onActivated,
            LayoutOrder = k,
            testId = `{var1.testId}--actions--{action.id}`
        })
    end

    return React.createElement(View, {
        tag = "row align-y-center shrink gap-small auto-xy",
        padding = padding,
        LayoutOrder = layoutOrder,
        testId = `{var1.testId}--actions`
    }, tbl2)
end)
