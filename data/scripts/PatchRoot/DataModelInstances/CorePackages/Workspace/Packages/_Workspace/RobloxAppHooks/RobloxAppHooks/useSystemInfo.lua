-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooks = script:FindFirstAncestor("RobloxAppHooks")
local RobloxAppHooksParent = RobloxAppHooks.Parent
local AppSystemInfo = require(RobloxAppHooksParent.RoactServiceTags).AppSystemInfo
local useRoactService = require(RobloxAppHooks.useRoactService)

local function useSystemInfo()
    return useRoactService(AppSystemInfo)
end

return useSystemInfo
