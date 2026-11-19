-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local SharedFlagsParent = script:FindFirstAncestor("SharedFlags").Parent
local isTenFootInterface = require(SharedFlagsParent.AppCommonLib).isTenFootInterface

game:DefineFastFlag("DebugLuaAppAlwaysUseGamepad", false)

game:DefineFastInt("DebugLuaAppForceGamepad", 0)

return function()
    return game:GetFastFlag("DebugLuaAppAlwaysUseGamepad") and RunService:IsStudio() and isTenFootInterface()
        or game:GetFastInt("DebugLuaAppForceGamepad") > 0
end
