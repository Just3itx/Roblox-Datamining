-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

local function shouldReportMessageRender(tbl2): boolean
    if not tbl2.isHistorical then
        return true
    end

    if tbl1[tbl2.messageId] then
        return false
    end

    tbl1[tbl2.messageId] = true
    return true
end

return shouldReportMessageRender
