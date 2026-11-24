-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InteractionFeedbackParent = script:FindFirstAncestor("InteractionFeedback").Parent

local triggerFeedback = require(script.Parent.triggerFeedback)
local InteractionFeedbackContext = require(script.Parent.InteractionFeedbackContext)
local RoactUtils = require(InteractionFeedbackParent.RoactUtils)
local useInputType = RoactUtils.Hooks.useInputType
local useLaserPointerHand = RoactUtils.Hooks.useLaserPointerHand
local React = require(InteractionFeedbackParent.React)
local isSpatial = require(InteractionFeedbackParent.AppCommonLib).isSpatial

local function useHapticPositionAndRadius()
    local var1 = useInputType()
    local var2 = useLaserPointerHand()
    return (React.useMemo(function(): {number | Vector3}
        return if isSpatial() then if var2 == "Right" then { Vector3.new(1, 0, 0), 0.1 } else { Vector3.new(-1, 0, 0), 0.1 } else { Vector3.new(0, 0, 0), 100 }
    end, { var1, var2 }))
end

local function useTriggerFeedback()
    local var1 = React.useContext(InteractionFeedbackContext)

    local var2 = useHapticPositionAndRadius()
    local var3 = var2[1]
    local var4 = var2[2]

    if not var1 then
        error("useTriggerFeedback must be used within an InteractionFeedbackProvider")
    end

    return (React.useCallback(function(str1: string, arg1, str2: string?, tbl1)
        return triggerFeedback(str1, arg1, var1, var3, var4, str2, tbl1)
    end, { var1, var3, var4 }))
end

return useTriggerFeedback
