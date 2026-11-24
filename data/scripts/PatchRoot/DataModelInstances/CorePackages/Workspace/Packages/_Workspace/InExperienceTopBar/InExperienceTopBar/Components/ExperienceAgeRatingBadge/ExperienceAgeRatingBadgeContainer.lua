-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceTopBarParent = script:FindFirstAncestor("InExperienceTopBar").Parent

local React = require(InExperienceTopBarParent.React)
local ExperienceAgeRatingBadgeView = require(script.Parent.ExperienceAgeRatingBadgeView)
local useExperienceAgeRatingBadgeViewModel = require(script.Parent.useExperienceAgeRatingBadgeViewModel)

local function ExperienceAgeRatingBadgeContainer(arg1)
    local var1 = useExperienceAgeRatingBadgeViewModel(arg1)
    if var1 then
        return (React.createElement(ExperienceAgeRatingBadgeView, var1))
    end

    return nil
end

return ExperienceAgeRatingBadgeContainer
