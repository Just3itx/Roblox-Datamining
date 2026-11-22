-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)
local Context = dependencies.SocialLibraries.Context

local PYMKCarouselAnalyticsContext = require(script.PYMKCarouselAnalyticsContext)
local setupFireEvent = require(script.setupFireEvent)
local useAnalytics = require(script.useAnalytics)
local useUserSeenEvent = require(script.useUserSeenEvent)
local useUserSeenCollectionEvent = require(script.useUserSeenCollectionEvent)

local getFFlagPYMKAddFriendsEntry = dependencies.getFFlagPYMKAddFriendsEntry

return {
    setupFireEvent = setupFireEvent,
    Context = PYMKCarouselAnalyticsContext,
    connect = Context.getConnect(PYMKCarouselAnalyticsContext),
    with = Context.getWith(PYMKCarouselAnalyticsContext),
    EventNames = require(script.EventNames),
    BtnValues = if getFFlagPYMKAddFriendsEntry() then require(script.BtnValues) else nil,
    useAnalytics = useAnalytics,
    useUserSeenEvent = useUserSeenEvent,
    useUserSeenCollectionEvent = useUserSeenCollectionEvent
}
