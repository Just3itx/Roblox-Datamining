-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")

local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local function useCloseOnEscapeEffect(actionName: string, current: (...any) -> (...any))
    local var1 = React.useRef(current)
    React.useEffect(function()
        var1.current = current
    end, { current })

    React.useEffect(function()
        ContextActionService:BindCoreAction(actionName, function(_, userInputState): Enum.ContextActionResult
            if userInputState == Enum.UserInputState.Begin then
                var1.current()
            end

            return Enum.ContextActionResult.Pass
        end, false, Enum.KeyCode.Escape)

        return function()
            ContextActionService:UnbindCoreAction(actionName)
        end
    end, { actionName })
end

return useCloseOnEscapeEffect
