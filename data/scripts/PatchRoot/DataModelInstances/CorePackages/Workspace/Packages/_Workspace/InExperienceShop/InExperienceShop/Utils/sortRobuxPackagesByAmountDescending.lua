-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)

local function sortRobuxPackagesByAmountDescending(tbl1)
    if #tbl1 <= 1 then
        return tbl1
    end

    local var1 = table.clone(tbl1)
    table.sort(var1, function(arg1, arg2): boolean
        if arg1.robuxAmount == arg2.robuxAmount then
            return arg1.id < arg2.id
        end

        return arg1.robuxAmount > arg2.robuxAmount
    end)

    return var1
end

return sortRobuxPackagesByAmountDescending
