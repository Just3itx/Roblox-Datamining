-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HomeParent = script:FindFirstAncestor("Home").Parent

local FFlagLuaAppSduiHomePageSupport = require(HomeParent.SharedFlags).FFlagLuaAppSduiHomePageSupport

local str1 = game:DefineFastString("SduiHomeSortDetailExcludedTopicIds", "100000000, 300000000, 600000000, 100000010")

local str2 = game:DefineFastString("SduiHomeSortDetailSupportedInputDataTypes", "experience_carousel")

local tbl1 = ({})
local tbl2 = ({})
if FFlagLuaAppSduiHomePageSupport then
    for value in str1:gmatch("([^,%s]+)") do
        tbl1[value] = true
    end
    for value in str2:gmatch("([^,%s]+)") do
        tbl2[value] = true
    end
end

local function isHomeSortDetailSortIncluded(arg1, arg2): boolean
    return not (arg1 == nil or arg2 == nil or tbl1[tostring(arg1)] == true) and tbl2[tostring(arg2)] == true
end

return isHomeSortDetailSortIncluded
