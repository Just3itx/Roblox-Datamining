-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagUFRAppealsAndModNoteFix = require(script.Parent.Parent.Flags.FFlagUFRAppealsAndModNoteFix)

local function determineAppealsState(tbl1)
    local isoDate = if tbl1.beginDate and tbl1.beginDate ~= "" then DateTime.fromIsoDate(tbl1.beginDate) else nil
    local isoDate2 = if tbl1.endDate and tbl1.endDate ~= "" then DateTime.fromIsoDate(tbl1.endDate) else nil

    if not (isoDate and isoDate2) then
        return {
            isAppealable = tbl1.onAppeal ~= nil or tbl1.acknowledgeable,
            shouldOpenAppealsPortal = tbl1.acknowledgeable
        }
    end

    local var1 = isoDate2.UnixTimestamp - isoDate.UnixTimestamp > 1800 or FFlagUFRAppealsAndModNoteFix and tbl1.acknowledgeable
    return {
        isAppealable = var1 or tbl1.onAppeal ~= nil,
        shouldOpenAppealsPortal = var1
    }
end

return determineAppealsState
