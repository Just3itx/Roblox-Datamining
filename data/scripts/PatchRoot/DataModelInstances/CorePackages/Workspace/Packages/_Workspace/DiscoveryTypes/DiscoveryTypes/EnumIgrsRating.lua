-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local DiscoveryTypesParent = script:FindFirstAncestor("DiscoveryTypes").Parent

local FFlagLuaAppAddIgrsImages = require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppAddIgrsImages

return {
    IgrsThreePlus = if FFlagLuaAppAddIgrsImages then "IGRS_RATING_THREE_PLUS" else nil,
    IgrsSevenPlus = if FFlagLuaAppAddIgrsImages then "IGRS_RATING_SEVEN_PLUS" else nil,
    IgrsThirteenPlus = "IGRS_RATING_THIRTEEN_PLUS",
    IgrsFifteenPlus = "IGRS_RATING_FIFTEEN_PLUS",
    IgrsEighteenPlus = "IGRS_RATING_EIGHTEEN_PLUS",
    IgrsUnrated = "IGRS_RATING_UNRATED"
}
