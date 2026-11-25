-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Rodux = require(ProfilePlatformParent.Rodux)

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Common.Types)
local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)
local mergeProfileStateAndResponse = require(ProfilePlatform.Rodux.ProfileTypes.mergeProfileStateAndResponse)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[getProfilePlatform.Succeeded.name] = function(arg1, tbl2)
    local responseBody = tbl2.responseBody
    if responseBody.profileType ~= Enums.ProfileTypes.Contact then
        return arg1
    end
    return mergeProfileStateAndResponse(arg1, responseBody)
end

return createReducer({}, tbl1)
