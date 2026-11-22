-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsParent = script:FindFirstAncestor("Squads").Parent
local FFlagDebugSquadLogsEnabled = require(SquadsParent.SharedFlags).FFlagDebugSquadLogsEnabled
local var1 = require(SquadsParent.Lumberyak).Logger.new(nil, "Squads")

var1:setContext({ prefix = "[Squads] - " })
local tbl1 = {
    maxLevel = if FFlagDebugSquadLogsEnabled then var1.Levels.Debug else var1.Levels.Warning,
    log = 0
}

function tbl1.log(_, arg1, _)
    print(arg1)
end

var1:addSink(tbl1)

return var1
