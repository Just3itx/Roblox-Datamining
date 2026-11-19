-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")

return function(arg1)
    if arg1 then
        UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceShow
    elseif VRService.VREnabled then
        UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
    else
        UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
    end
end
