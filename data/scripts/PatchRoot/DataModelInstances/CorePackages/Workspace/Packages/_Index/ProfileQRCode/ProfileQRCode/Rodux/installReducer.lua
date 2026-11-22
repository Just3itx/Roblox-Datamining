-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local Rodux = require(ProfileQRCodeParent.Rodux)
local configuredUsers = require(script.Parent.configuredUsers)
local configuredRoduxNetworking = require(ProfileQRCode.Networking.configuredRoduxNetworking)
local ShareUrlReducer = require(script.Parent.ShareUrlReducer)

local FFlagProfileQrCodeDeprecateUserRedux = require(ProfileQRCode.Flags.FFlagProfileQrCodeDeprecateUserRedux)

return function()
    return Rodux.combineReducers({
        Users = if FFlagProfileQrCodeDeprecateUserRedux then nil else configuredUsers(),
        NetworkStatus = configuredRoduxNetworking.installReducer(),
        ShareUrl = ShareUrlReducer
    })
end
