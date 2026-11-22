-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local NetworkingUsers = require(ProfileQRCodeParent.NetworkingUsers)
local configuredRoduxNetworking = require(script.Parent.configuredRoduxNetworking)

return NetworkingUsers.config({ roduxNetworking = configuredRoduxNetworking })
