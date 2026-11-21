-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:30:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent

local Birthday = require(AuthSignupParent.AuthCommon).Models.Birthday
local validateBirthday = require(script.Parent.validateBirthday)

local function buildValidatedBirthday(month: number?, day: number?, year: number?, num1: number)
    if month == nil or day == nil or year == nil or not validateBirthday(month, day, year, num1) then
        return nil
    end

    return Birthday.new({ Month = month, Day = day, Year = year })
end

return buildValidatedBirthday
