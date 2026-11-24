-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local var1 = require(GameDetailRoduxParent.Lumberyak).Logger.new(nil, "GameDetailRodux")

var1:addSink({
    maxLevel = var1.Levels.Warning,
    log = function(_, arg1, _)
        print(arg1)
    end
})

return var1
