-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VRService = game:GetService("VRService")

local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)
local useExternalEvent = require(script.Parent.useExternalEvent)

local function useLaserPointerHand()
    local var1, var2 = React.useState("Right")

    local var3 = React.useCallback(function(arg1)
        if (arg1.KeyCode == Enum.KeyCode.ButtonR1
            or arg1.KeyCode == Enum.KeyCode.ButtonR2
            or arg1.KeyCode == Enum.KeyCode.ButtonR3
            or arg1.KeyCode == Enum.KeyCode.ButtonA
            or arg1.KeyCode == Enum.KeyCode.ButtonB)
            and var1 ~= "Right"
        then
            var2("Right")
        elseif (arg1.KeyCode == Enum.KeyCode.ButtonL1
            or arg1.KeyCode == Enum.KeyCode.ButtonL2
            or arg1.KeyCode == Enum.KeyCode.ButtonL3
            or arg1.KeyCode == Enum.KeyCode.ButtonX
            or arg1.KeyCode == Enum.KeyCode.ButtonY)
            and var1 ~= "Left"
        then
            var2("Left")
        end
    end)

    useExternalEvent(VRService.LaserPointerTriggered, var3)

    return var1
end

return useLaserPointerHand
