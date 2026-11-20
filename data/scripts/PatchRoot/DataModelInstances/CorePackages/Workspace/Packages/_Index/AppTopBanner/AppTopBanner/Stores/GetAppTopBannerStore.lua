-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppTopBannerParent = script:FindFirstAncestor("AppTopBanner").Parent

local Signals = require(AppTopBannerParent.Signals)

local createAppTopBannerStore = require(script.createAppTopBannerStore)

return Signals.createComputed(createAppTopBannerStore)
