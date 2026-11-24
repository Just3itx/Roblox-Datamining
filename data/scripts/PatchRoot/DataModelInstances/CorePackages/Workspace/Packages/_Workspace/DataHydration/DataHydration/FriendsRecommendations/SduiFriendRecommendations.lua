-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local SduiFriendRecommendationsStoresByConfigKey = require(script.Parent.SduiFriendRecommendationsStoresByConfigKey)

local FFlagPymkCarouselExtendProps = require(DataHydrationParent.SharedFlags).FFlagPymkCarouselExtendProps

return {
    RecommendationType = require(script.Parent.SduiRecommendationType),
    createStore = if FFlagPymkCarouselExtendProps then nil else require(script.Parent.createSduiFriendRecommendationsStore),
    getStore = if FFlagPymkCarouselExtendProps then SduiFriendRecommendationsStoresByConfigKey.get else require(script.Parent.getSduiFriendRecommendationsStore),
    disposeStore = if FFlagPymkCarouselExtendProps then SduiFriendRecommendationsStoresByConfigKey.dispose else nil,
    mapFromProto = require(script.Parent.mapSduiFriendRecommendationsFromProto)
}
