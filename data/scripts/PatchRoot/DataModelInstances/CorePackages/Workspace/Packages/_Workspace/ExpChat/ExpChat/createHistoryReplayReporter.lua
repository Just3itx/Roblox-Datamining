-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local function createHistoryReplayReporter(tbl1): (number) -> ()
    local getHistoricalCount = tbl1 and tbl1.getHistoricalCount
    local clock = tbl1 and tbl1.clock or os.clock
    local var1 = tbl1 and tbl1.report or ExpChatShared.Analytics.reportHistoryReplayed
    local var2 = clock()
    local num1 = 0

    return function(num2: number)
        num1 += num2
        var1(num1, if getHistoricalCount then getHistoricalCount() else 0, math.round((clock() - var2) * 1000))
    end
end

return createHistoryReplayReporter
