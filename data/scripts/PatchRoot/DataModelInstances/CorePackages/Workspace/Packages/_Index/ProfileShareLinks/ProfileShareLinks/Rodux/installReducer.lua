-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileShareLinks = script:FindFirstAncestor("ProfileShareLinks")
local ProfileShareLinksParent = ProfileShareLinks.Parent
local Rodux = require(ProfileShareLinksParent.Rodux)

local configuredRoduxNetworking = require(ProfileShareLinks.Networking.configuredRoduxNetworking)
local ProfileShareLinksReducer = require(script.Parent.ProfileShareLinksReducer)

return function()
    return Rodux.combineReducers(
        {
            ProfileShareLinks = ProfileShareLinksReducer,
            NetworkingStatus = configuredRoduxNetworking.installReducer()
        }
    )
end
