-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsRoactCommon = script:FindFirstAncestor("CoreScriptsRoactCommon")
local CoreScriptsRoactCommonParent = CoreScriptsRoactCommon.Parent

local TeleportBack = require(CoreScriptsRoactCommon.Traversal.TeleportBack)
local React = require(CoreScriptsRoactCommonParent.React)

local function useTeleportBack(num1: number?)
    return React.useCallback(function()
        TeleportBack(num1)
    end, {})
end

return useTeleportBack
