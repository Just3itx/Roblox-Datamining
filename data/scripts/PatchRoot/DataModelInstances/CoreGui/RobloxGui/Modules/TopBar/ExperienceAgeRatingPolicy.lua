-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local FFlagExperienceAgeRatingBadge = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagExperienceAgeRatingBadge
local FFlagShowGameAgeRating = require(CorePackages.Workspace.Packages.SharedFlags).FFlagShowGameAgeRating

return {
    isEligible = function(bool1: boolean?, bool2: boolean, bool3: boolean, bool4: boolean)
        local var1 = FFlagExperienceAgeRatingBadge and FFlagShowGameAgeRating
        return var1 and bool1 == true and bool2 and bool3 and not bool4
    end,
    keepOutAreaId = "experience-age-rating"
}
