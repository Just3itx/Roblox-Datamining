-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local AppendRecentDumpPath = require(script.Parent.Parent.Actions.AppendRecentDumpPath)
local SetRCCProfilerState = require(script.Parent.Parent.Actions.SetRCCProfilerState)

return function(tbl1, tbl2)
    local var1 = tbl1 or {
        waitingForRecording = false,
        lastFileOutputLocation = "",
        recentDumpPaths = {}
    }

    if tbl2.type == SetRCCProfilerState.name then
        local tbl3 = {
            waitingForRecording = tbl2.waitingForRecording,
            lastFileOutputLocation = tbl2.lastFileOutputLocation,
            recentDumpPaths = var1.recentDumpPaths
        }
        return (Immutable.JoinDictionaries(var1, tbl3))
    end

    if tbl2.type ~= AppendRecentDumpPath.name then
        return var1
    end

    local tbl3 = {
        waitingForRecording = var1.waitingForRecording,
        lastFileOutputLocation = var1.lastFileOutputLocation,
        recentDumpPaths = Immutable.Append(var1.recentDumpPaths, tbl2.dumpPath)
    }
    return (Immutable.JoinDictionaries(var1, tbl3))
end
