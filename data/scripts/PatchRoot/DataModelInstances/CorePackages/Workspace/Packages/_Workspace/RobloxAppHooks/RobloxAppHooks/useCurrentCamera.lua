-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent
local useProperty = require(RobloxAppHooksParent.GuiObjectUtils).useProperty

local function useCurrentCamera()
    return useProperty(workspace, "CurrentCamera")
end

return useCurrentCamera
