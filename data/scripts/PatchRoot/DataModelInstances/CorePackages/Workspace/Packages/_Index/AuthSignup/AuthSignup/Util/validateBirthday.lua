-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent

local Birthday = require(AuthSignupParent.AuthCommon).Models.Birthday
local DateHelper = require(AuthSignupParent.Time).DateHelper

return function(month, day, year, arg1)
    local var1, _ = DateHelper:isValidDate(month, day, year)
    if Birthday.new({ Month = month, Day = day, Year = year }):GetAgeInYears() < arg1 then
        var1 = false
    end

    return var1
end
