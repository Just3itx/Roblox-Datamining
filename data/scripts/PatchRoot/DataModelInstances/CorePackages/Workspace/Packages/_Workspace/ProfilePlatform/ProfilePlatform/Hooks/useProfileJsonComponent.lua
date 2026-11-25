-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local _Enums = require(ProfilePlatform.Common.Enums)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local useProfileJson = require(ProfilePlatform.Hooks.useProfileJson)

return function(arg1)
    local var1 = useProfileJson()
    return getDeepValue(var1, `components.{arg1}`) or {}
end
