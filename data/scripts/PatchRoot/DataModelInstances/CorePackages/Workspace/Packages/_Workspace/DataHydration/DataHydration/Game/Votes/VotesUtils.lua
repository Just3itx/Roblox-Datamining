-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent
local FFlagSduiSupportRatingNoPercent = require(DataHydrationParent.SharedFlags).FFlagSduiSupportRatingNoPercent

local _VotesStoreTypes = require(script.Parent.VotesStoreTypes)

return {
    calculateRating = function(num1: number, num2: number): number
        local num3 = num1 + num2
        if num3 == 0 then
            return 0
        end

        return math.floor(num1 / num3 * 100)
    end,
    getRatingDisplayText = function(arg1, bool1: boolean?): string
        if not arg1 or (arg1.upVotes or 0) + (arg1.downVotes or 0) <= 0 or not arg1.rating then
            return "--"
        elseif FFlagSduiSupportRatingNoPercent and bool1 then
            return tostring(arg1.rating)
        end

        return tostring(arg1.rating) .. "%"
    end
}
