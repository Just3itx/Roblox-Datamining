-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquadsParent = script:FindFirstAncestor("RoduxSquads").Parent

local Lumberyak = require(RoduxSquadsParent.Lumberyak)

local FFlagDebugSquadLogsEnabled = require(RoduxSquadsParent.SharedFlags).FFlagDebugSquadLogsEnabled

local logger = Lumberyak.Logger.new(nil, "RoduxSquads")

logger:setContext({ prefix = "[RoduxSquads] - " })
local tbl1 = {
    maxLevel = if FFlagDebugSquadLogsEnabled then logger.Levels.Debug else logger.Levels.Warning,
    log = 0
}

function tbl1.log(_, arg1, _)
    print(arg1)
end

logger:addSink(tbl1)

return logger
