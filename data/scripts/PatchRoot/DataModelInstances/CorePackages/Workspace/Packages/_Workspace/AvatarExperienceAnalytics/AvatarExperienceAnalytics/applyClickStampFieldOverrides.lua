-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)

local function applyClickStampFieldOverrides(tbl1, tbl2)
    if tbl2[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "selectedItemIndex"] ~= nil then
        tbl1.selectedItemIndex = nil
    end

    if tbl2[UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "keyword"] ~= nil then
        tbl1.keyword = nil
    end

    return tbl1
end

return applyClickStampFieldOverrides
