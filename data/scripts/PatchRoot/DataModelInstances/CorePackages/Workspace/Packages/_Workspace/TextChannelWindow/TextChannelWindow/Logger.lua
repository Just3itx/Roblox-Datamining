-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local var1 = require(scriptParentParent.Lumberyak).Logger.new(nil, "TextChannelWindow")

var1:addSink({
    maxLevel = var1.Levels.Warning,
    log = function(_, arg1, _)
        print(arg1)
    end
})

return var1
