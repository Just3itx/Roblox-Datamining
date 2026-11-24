-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local var1 = require(scriptParentParent.Lumberyak).Logger.new(nil, "LocalizationPackage")

var1:addSink({
    maxLevel = var1.Levels.Warning,
    log = function(_, arg1, _)
        print(arg1)
    end
})

return var1
