-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local Rodux = require(ProfileQRCodeParent.Rodux)
local createOrGetProfileShareUrl = require(ProfileQRCode.Networking.createOrGetProfileShareUrl)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[createOrGetProfileShareUrl.Succeeded.name] = function(_, tbl2)
    return tbl2.responseBody
end

return createReducer({}, tbl1)
