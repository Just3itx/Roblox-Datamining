-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiUsageRecorder = require(SduiCoreSystem.Analytics.SduiUsageRecorder)
local recordV1ComponentUsage = require(SduiCoreSystem.Analytics.recordV1ComponentUsage)

local function recordV1RegisteredTemplates(str1: string, tbl1)
    if not tbl1 or not SduiUsageRecorder.isTypeSamplingEnabled() and not SduiUsageRecorder.isParamSamplingEnabled() then
        return
    end

    for _, value in tbl1 do
        pcall(recordV1ComponentUsage, str1, value)
    end
end

return recordV1RegisteredTemplates
