-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Rodux = require(ProfilePlatformParent.Rodux)
local Cryo = require(ProfilePlatformParent.Cryo)
local NetworkingCurrentlyWearing = require(ProfilePlatform.Networking.NetworkingCurrentlyWearing)
local AssetInfo = require(ProfilePlatform.Common.AssetInfo)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[NetworkingCurrentlyWearing.GetItemDetails.Succeeded.name] = function(arg1, arg2)
    local tbl2 = {}
    for _, value in arg2.responseBody.data do
        local asset = AssetInfo.fromAsset(value)
        tbl2[asset.id] = asset
    end
    return Cryo.Dictionary.join(arg1, tbl2)
end

return createReducer({}, tbl1)
