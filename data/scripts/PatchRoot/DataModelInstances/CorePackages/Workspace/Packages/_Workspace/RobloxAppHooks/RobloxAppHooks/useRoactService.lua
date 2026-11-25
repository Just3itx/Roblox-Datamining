-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent
local React = require(RobloxAppHooksParent.React)
local RoactServicesContext = require(RobloxAppHooksParent.RoactServices).RoactServicesContext

local function useRoactService(arg1)
    local var1 = React.useContext(RoactServicesContext)

    return (arg1.get(var1))
end

return useRoactService
