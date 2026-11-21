-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local var1 = require(AuthCommonParent.Lumberyak).Logger.new(nil, "Authentication")

var1:addSink({
    maxLevel = var1.Levels.Warning,
    log = function(_, arg1, _)
        print(arg1)
    end
})

return var1
