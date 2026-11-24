-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local t = require(DataHydrationParent.t)

local FFlagShowGameAgeRating = require(DataHydrationParent.SharedFlags).FFlagShowGameAgeRating

local var1 = t.interface({
    displayName = t.optional(t.string),
    displayNameWithHeaderShort = t.optional(t.string),
    igrsRating = t.optional(t.string),
    igrsRatingDisplayMessage = t.optional(t.string),
    minimumAgeDisplay = if FFlagShowGameAgeRating then t.optional(t.string) else nil
})

local interface = t.interface
local tbl1 = { ageRecommendationDetails = 0 }
local interface2 = t.interface
local tbl2 = { summary = 0 }
local interface3 = t.interface
local tbl3 = { ageRecommendation = 0 }
if FFlagShowGameAgeRating then
    var1 = t.optional(var1)
end

tbl3.ageRecommendation = var1
tbl2.summary = interface3(tbl3)
tbl1.ageRecommendationDetails = interface2(tbl2)
return {
    ageRecommendationResponseValidator = interface(tbl1)
}
