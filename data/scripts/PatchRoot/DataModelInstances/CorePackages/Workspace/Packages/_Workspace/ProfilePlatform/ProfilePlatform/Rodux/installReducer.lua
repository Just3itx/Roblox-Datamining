-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Rodux = require(ProfilePlatformParent.Rodux)
local Games = require(ProfilePlatform.Rodux.Games)
local ItemDetails = require(ProfilePlatform.Rodux.ItemDetails)
local BundleDetails = require(ProfilePlatform.Rodux.BundleDetails)
local AssetDetails = require(ProfilePlatform.Rodux.AssetDetails)
local myRoduxNetworking = require(ProfilePlatform.Networking.myRoduxNetworking)
local Presence = require(ProfilePlatform.Rodux.Presence)
local bool1 = game:DefineFastFlag("ProfilePlatformFixPresenceReducer", false)
local PresenceReducer = if bool1 then require(ProfilePlatform.Rodux.PresenceReducer) else nil
local Profiles = require(ProfilePlatform.Rodux.Profiles)

local FFlagProfilePlatformPresenceStoreMigration = require(ProfilePlatform.Flags.FFlagProfilePlatformPresenceStoreMigration)

return function()
    return Rodux.combineReducers({
        Games = Games.installReducer(),
        ItemAssets = ItemDetails,
        BundleDetails = BundleDetails,
        AssetDetails = AssetDetails,
        NetworkStatus = myRoduxNetworking.installReducer(),
        Presence = if FFlagProfilePlatformPresenceStoreMigration then nil elseif bool1 then PresenceReducer else Presence.installReducer(),
        Profiles = Profiles
    })
end
