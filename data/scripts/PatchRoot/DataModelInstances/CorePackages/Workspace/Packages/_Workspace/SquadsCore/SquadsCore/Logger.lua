-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local FFlagDebugSquadLogsEnabled = require(SquadsCoreParent.SharedFlags).FFlagDebugSquadLogsEnabled
local var1 = require(SquadsCoreParent.Lumberyak).Logger.new(nil, "SquadsCore")

var1:setContext({ prefix = "[SquadsCore] - " })
local tbl1 = {
    maxLevel = if FFlagDebugSquadLogsEnabled then var1.Levels.Debug else var1.Levels.Warning,
    log = 0
}

function tbl1.log(_, arg1, _)
    print(arg1)
end

var1:addSink(tbl1)

return var1
