-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DsaIllegalContentReporting = script:FindFirstAncestor("DsaIllegalContentReporting")
local Constants = require(DsaIllegalContentReporting.Utility.Constants)

local function isSelectedDataDSAIllegalContent(tbl1): boolean
    if tbl1 == nil then
        return false
    end
    local var1 = tbl1[#tbl1]
    return not (var1 == nil) and var1.tagValues[1] == Constants.DSA_TAG_VALUE
end

return isSelectedDataDSAIllegalContent
