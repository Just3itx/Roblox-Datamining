-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")

local QRCodeFriendRequestNotification = require(script.QRCodeFriendRequestNotification)
local QRCodeFriendRequestNotificationV2 = require(script.QRCodeFriendRequestNotificationV2)

return if require(ProfileQRCode.Flags.FFlagQRCodeFriendRequestNotificationV2) then QRCodeFriendRequestNotificationV2 else QRCodeFriendRequestNotification
