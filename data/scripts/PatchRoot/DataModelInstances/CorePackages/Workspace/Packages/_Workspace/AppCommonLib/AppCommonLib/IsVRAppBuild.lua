-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:05:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local VRService = game:GetService("VRService")

local isVRModeInStudio = require(script.Parent.isVRModeInStudio)

return function()
    if isVRModeInStudio() then
        return true
    end

    return VRService:IsVRAppBuild()
end
