-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local ArgCheck = require(AuthCommonParent.ArgCheck)
local DateTime = require(AuthCommonParent.Time).DateTime

local module = {}
local tbl1 = {}
module[tbl1] = true

function module.new(arg1)
    local tbl2 = { Month = 1, Day = 1, Year = 1970 }

    if arg1 then
        tbl2.Month = arg1.Month or tbl2.Month
        tbl2.Day = arg1.Day or tbl2.Day
        tbl2.Year = arg1.Year or tbl2.Year

        ArgCheck.isNonNegativeNumber(tbl2.Month, "month in Birthday constructor")
        ArgCheck.isNonNegativeNumber(tbl2.Day, "day in Birthday constructor")
        ArgCheck.isNonNegativeNumber(tbl2.Year, "year in Birthday constructor")
    end

    setmetatable(tbl2, module)
    return tbl2
end

function module:IsUnder13(): boolean
    local module2 = module.new(DateTime.now():GetValues())
    if module2.Year - 13 < self.Year then
        return true
    end

    if module2.Year - 13 > self.Year then
        return false
    end
    return module2.Month < self.Month or module2.Month == self.Month and module2.Day < self.Day
end

function module:GetAgeInYears(arg1)
    local var1 = arg1 or DateTime.now():GetValues()
    local module2 = module.new(var1)

    if module2.Month < self.Month or module2.Month == self.Month and module2.Day < self.Day then
        return module2.Year - self.Year - 1
    end

    return module2.Year - self.Year
end

function module:FormatForEndpoint()
    return self.Year .. "-" .. self.Month .. "-" .. self.Day .. "T12:00:00.000Z"
end

function module:ToString(arg1)
    arg1 = arg1 or " "

    return self.Month .. arg1 .. self.Day .. arg1 .. self.Year
end

function module.is(arg1): boolean
    return type(arg1) == "table" and arg1[tbl1] == true
end

module.__index = module

return module
