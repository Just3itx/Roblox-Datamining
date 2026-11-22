-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local LuaSocialLibrariesDeps = require(ProfileQRCodeParent.LuaSocialLibrariesDeps)
local RODUX_KEY = require(ProfileQRCode.Common.Constants).RODUX_KEY

return LuaSocialLibrariesDeps.RoduxUsers.config({ keyPath = RODUX_KEY .. ".Users" })
