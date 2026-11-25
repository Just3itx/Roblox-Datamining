-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)

local function findAnalyticsFieldInAncestors(str1: string, arg1, nil1: nil)
    if not arg1 then
        return nil
    end
    assert(arg1, "analyticsContext must exist")

    if arg1.analyticsData and arg1.analyticsData[str1] ~= nil then
        return arg1.analyticsData[str1]
    end

    if arg1.ancestorAnalyticsData and arg1.ancestorAnalyticsData[str1] ~= nil then
        return arg1.ancestorAnalyticsData[str1]
    end

    if nil1 == nil then
        return nil
    end

    return nil1
end

return findAnalyticsFieldInAncestors
