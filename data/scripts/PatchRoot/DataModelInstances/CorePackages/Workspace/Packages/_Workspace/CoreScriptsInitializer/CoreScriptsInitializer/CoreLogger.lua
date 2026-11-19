-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local var1 = require(scriptParentParent.Lumberyak).Logger.new(nil, "CoreLogger")

local str1 = game:DefineFastString("DebugLuaLogLevel", "")
local maxLevel = var1.Levels.fromString(str1)
local str2 = game:DefineFastString("DebugLuaLogPattern", "")

var1:setContext({ prefix = "[{loggerName}] - " })
var1:addSink({
    maxLevel = maxLevel,
    log = function(_, arg1, _)
        if string.match(arg1, str2) then
            print(arg1)
        end
    end
})

return var1
