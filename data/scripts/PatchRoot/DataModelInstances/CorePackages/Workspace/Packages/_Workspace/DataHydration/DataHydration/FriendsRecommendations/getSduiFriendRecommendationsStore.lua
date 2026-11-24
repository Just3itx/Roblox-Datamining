-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createSduiFriendRecommendationsStore = require(script.Parent.createSduiFriendRecommendationsStore)

local FFlagPymkCarouselExtendProps = require(DataHydrationParent.SharedFlags).FFlagPymkCarouselExtendProps

local computed = Signals.createComputed(createSduiFriendRecommendationsStore)

return if FFlagPymkCarouselExtendProps then nil else function()
    return computed(false)
end
