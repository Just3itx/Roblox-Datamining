-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local configuredRoduxNetworking = require(script.Parent.configuredRoduxNetworking)

return require(ProfileQRCodeParent.FriendsNetworking).config({ roduxNetworking = configuredRoduxNetworking })
