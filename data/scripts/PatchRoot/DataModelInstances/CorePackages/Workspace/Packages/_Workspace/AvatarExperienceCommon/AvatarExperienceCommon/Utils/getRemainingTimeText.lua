-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local _AvatarExperienceUIKit = require(AvatarExperienceCommonParent.AvatarExperienceUIKit)

local function getRemainingTimeText(arg1, tbl1)
    local unit = arg1.unit
    local bool1 = arg1.value == 1

    if unit == "days" then
        return if bool1 then tbl1.daySingular else tbl1.dayPlural
    elseif unit == "hours" then
        return if bool1 then tbl1.hourSingular else tbl1.hourPlural
    elseif unit == "minutes" then
        return if bool1 then tbl1.minuteSingular else tbl1.minutePlural
    elseif unit == "seconds" then
        return if bool1 then tbl1.secondSingular else tbl1.secondPlural
    end

    warn(`getRemainingTimeText: unexpected TimeUnit "{unit}"`)
    return nil
end

return getRemainingTimeText
