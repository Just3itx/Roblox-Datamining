-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsCarousel = script:FindFirstAncestor("FriendsCarousel")
local dependencies = require(FriendsCarousel.dependencies)
local _FriendsCarouselParent = FriendsCarousel.Parent

local Context = dependencies.SocialLibraries.Context

local FriendsCarouselAnalyticsContext = require(script.FriendsCarouselAnalyticsContext)
local setupFireEvent = require(script.setupFireEvent)
local useAnalytics = require(script.useAnalytics)

local AnalyticsSetup = require(script.AnalyticsSetup)

return {
    EventNames = require(script.EventNames),
    Analytics = AnalyticsSetup,
    setupFireEvent = setupFireEvent,
    Context = FriendsCarouselAnalyticsContext,
    connect = Context.getConnect(FriendsCarouselAnalyticsContext),
    with = Context.getWith(FriendsCarouselAnalyticsContext),
    useAnalytics = useAnalytics
}
