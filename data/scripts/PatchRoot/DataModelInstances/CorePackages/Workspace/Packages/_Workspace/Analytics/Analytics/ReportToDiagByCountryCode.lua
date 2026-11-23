-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

math.randomseed(tick())

return function(featureName: string, measureName: string, seconds: number, arg1)
    if arg1 < 100 * math.random() then
        return
    end
    RbxAnalyticsService:ReportToDiagByCountryCode(featureName, measureName, seconds)
end
