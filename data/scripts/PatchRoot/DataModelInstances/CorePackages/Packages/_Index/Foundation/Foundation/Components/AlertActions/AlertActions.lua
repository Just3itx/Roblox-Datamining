-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:11:07Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local Button = require(Foundation.Components.Button)
local InputSize = require(Foundation.Enums.InputSize)
local Logger = require(Foundation.Utility.Logger)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local MAX_ACTION_COUNT = require(script.Parent.AlertConstants).MAX_ACTION_COUNT

local tbl1 = { testId = "--foundation-alert-actions" }

return React.memo(function(tbl2) -- name: AlertActions
    local var1 = withDefaults(tbl2, tbl1)
    React.useEffect(function()
        if var1.actions and #var1.actions > MAX_ACTION_COUNT then
            Logger:warning(`Alert components only support up to {MAX_ACTION_COUNT} actions`)
        end
    end, { var1.actions })

    local var2 = React.useMemo(function()
        if not (var1.actions and #var1.actions > 0) then
            return nil
        end

        local result = {}
        for layoutOrder, action in var1.actions do
            if MAX_ACTION_COUNT < layoutOrder then
                break
            end

            local join = Dash.join
            local tbl3 = {
                LayoutOrder = layoutOrder,
                size = InputSize.Small,
                testId = `{var1.testId}--action-{layoutOrder}`
            }
            local var2 = join(action, tbl3)

            result["ActionButton" .. layoutOrder] = React.createElement(Button, var2)
        end
        return result
    end, { var1.actions, var1.testId })

    if not var2 then
        return nil
    end

    return React.createElement(
        View,
        withCommonProps(var1, { tag = var1.tag or "auto-xy row gap-small", padding = var1.padding }),
        var2
    )
end)
