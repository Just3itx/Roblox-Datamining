-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local React = require(InterventionSharedParent.React)
local useEffect = React.useEffect
local LuauPolyfill = require(InterventionSharedParent.LuauPolyfill)
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local Snackbar = require(InterventionSharedParent.Foundation).Snackbar

local num1 = game:DefineFastInt("GenericInterventionSnackbarAutoDismissDelaySeconds", 4)

return React.memo(function(tbl1) -- name: GenericInterventionSnackbar
    useEffect(function()
        local var1 = tbl1.autoDismissDelaySeconds or num1

        local var2 = setTimeout(function()
            tbl1.onDismiss()
        end, var1 * 1000)

        return function()
            if var2 then
                clearTimeout(var2)
            end
        end
    end, { tbl1.onDismiss, tbl1.autoDismissDelaySeconds })

    return (React.createElement(
        Snackbar,
        {
            title = tbl1.titleText,
            icon = tbl1.iconName,
            Position = UDim2.new(0.5, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0)
        }
    ))
end)
