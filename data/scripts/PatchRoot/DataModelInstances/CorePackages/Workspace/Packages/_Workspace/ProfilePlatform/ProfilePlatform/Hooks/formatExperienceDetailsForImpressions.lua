-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Cryo = require(ProfilePlatformParent.Cryo)

local _Types = require(ProfilePlatform.Common.Types)

return function(tbl1)
    if not tbl1 then
        return {}
    end

    return Cryo.Dictionary.map(tbl1, function(arg1)
        return {
            id = arg1.experienceId,
            universeId = tonumber(arg1.experienceId),
            placeId = tonumber(arg1.rootPlaceId)
        }
    end)
end
