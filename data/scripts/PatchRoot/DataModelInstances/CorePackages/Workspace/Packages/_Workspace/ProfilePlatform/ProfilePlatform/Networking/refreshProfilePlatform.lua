-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Cryo = require(ProfilePlatformParent.Cryo)

local Enums = require(ProfilePlatform.Common.Enums)
local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)

function refreshProfilePlatform(tbl1)
    local components = Cryo.List.map(tbl1.components, function(component)
        local tbl2 = { component = component }
        if component == Enums.Components.Actions then
            tbl2.isActionsV2Supported = true
        end
        return tbl2
    end)

    return getProfilePlatform.API({
        profileType = tbl1.profileType,
        profileId = tbl1.profileId,
        components = components,
        includeComponentOrdering = false
    })
end

return refreshProfilePlatform
