-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Rodux = require(ProfilePlatformParent.Rodux)

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Common.Types)
local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)
local mergeProfileStateAndResponse = require(ProfilePlatform.Rodux.ProfileTypes.mergeProfileStateAndResponse)
local FFlagProfilePlatformGracefulVisibility = require(ProfilePlatform.Flags.FFlagProfilePlatformGracefulVisibility)

local _Component = require(ProfilePlatform.Types.Component)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[getProfilePlatform.Succeeded.name] = function(arg1, tbl2)
    local responseBody = tbl2.responseBody
    if responseBody.profileType ~= Enums.ProfileTypes.User then
        return arg1
    end

    local var1 = nil
    if FFlagProfilePlatformGracefulVisibility and responseBody.onlyEssentialComponents ~= true then
        for _, value in not (tbl2.postBody and tbl2.postBody.components) and {} or tbl2.postBody.components do
            if value.component == Enums.Components.Friends and responseBody.components[Enums.Components.Friends] == nil then
                var1 = { Enums.Components.Friends }
                break
            end
        end
    end

    return mergeProfileStateAndResponse(arg1, responseBody, var1)
end

return createReducer({}, tbl1)
