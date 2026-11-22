-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local PYMKCarouselParent = script:FindFirstAncestor("PYMKCarousel").Parent

return require(PYMKCarouselParent.GenericChallenges).Middleware.ChallengeRequestWrapper(
    require(PYMKCarouselParent.DataHydration).Friends.httpRequest
)
