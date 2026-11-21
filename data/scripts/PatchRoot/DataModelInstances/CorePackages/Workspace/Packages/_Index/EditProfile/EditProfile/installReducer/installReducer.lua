-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local Rodux = require(EditProfileParent.Rodux)
local ProfileRoduxNetworking = require(EditProfile.Networking.ProfileRoduxNetworking)

return function()
    return Rodux.combineReducers({ NetworkStatus = ProfileRoduxNetworking.installReducer() })
end
