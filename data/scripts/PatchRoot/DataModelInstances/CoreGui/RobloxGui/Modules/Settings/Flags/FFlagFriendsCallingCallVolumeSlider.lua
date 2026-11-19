-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local FFlagFriendsCallingClientGate_DEV = require(CorePackages.Workspace.Packages.SharedFlags).FFlagFriendsCallingClientGate_DEV

return game:DefineFastFlag("FriendsCallingCallVolumeSlider", false) and FFlagFriendsCallingClientGate_DEV
