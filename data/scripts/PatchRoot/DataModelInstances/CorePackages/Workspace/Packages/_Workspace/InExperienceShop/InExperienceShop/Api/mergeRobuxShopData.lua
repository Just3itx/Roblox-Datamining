-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)

local ROBUX_CATEGORY_NAME = Constants.ROBUX_CATEGORY_NAME

local function isRobuxNamed(tbl1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return tbl1.name == ROBUX_CATEGORY_NAME
end

local function findRobux(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in ipairs(tbl1) do
        if isRobuxNamed(value) then
            return value
        end
    end
    return nil
end

local function replaceOrRemoveRobux(tbl1, arg1)
    local var1 = table.create(#tbl1)
    local bool1 = false
    for _, value in ipairs(tbl1) do
        if isRobuxNamed(value) then
            if arg1 ~= nil then
                table.insert(var1, arg1)
            end

            bool1 = true
        else
            table.insert(var1, value)
        end
    end
    if not bool1 and arg1 ~= nil then
        table.insert(var1, arg1)
    end
    return var1
end

local function mergeRobuxShopData(tbl1, tbl2, arg1)
    local robux = findRobux(arg1.sections)
    local robux2 = if robux == nil then nil else findRobux(arg1.categories)
    return replaceOrRemoveRobux(tbl1, robux2), (replaceOrRemoveRobux(tbl2, robux))
end

return mergeRobuxShopData
