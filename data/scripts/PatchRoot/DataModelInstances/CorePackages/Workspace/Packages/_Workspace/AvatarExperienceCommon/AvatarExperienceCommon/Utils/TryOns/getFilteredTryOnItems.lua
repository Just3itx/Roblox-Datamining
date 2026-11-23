-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local _AvatarExperienceModel = require(AvatarExperienceCommon.Parent.AvatarExperienceModel)

local getTryOnItemComparisonData = require(script.Parent.getTryOnItemComparisonData)
local getShouldReplaceTryOn = require(script.Parent.getShouldReplaceTryOn)

function getFilteredTryOnItems(tbl1, tbl2)
    local tbl3 = ({})
    local tbl4 = ({})

    local tryOnItemComparisonData = getTryOnItemComparisonData(tbl2)

    for value, value2 in tbl1 do
        local tryOnItemComparisonData2 = getTryOnItemComparisonData(value2)
        if getShouldReplaceTryOn(tryOnItemComparisonData, tryOnItemComparisonData2) then
            tbl4[value] = value2
        else
            tbl3[value] = value2
        end
    end

    return tbl3, tbl4
end

return getFilteredTryOnItems
