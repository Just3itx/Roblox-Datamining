-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local PYMKCarouselParent = PYMKCarousel.Parent

local RODUX_KEY = require(PYMKCarousel.Common.Constants).RODUX_KEY

return (require(PYMKCarouselParent.LuaSocialLibrariesDeps).RoduxPresence.config({ keyPath = RODUX_KEY .. ".Presence" }))
