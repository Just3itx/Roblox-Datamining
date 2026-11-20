-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local var1 = require(scriptParentParent.flags.getFIntUGCValidationMaxMsPerFrame)() / 1000

return function(arg1)
    if arg1.shouldYield and tick() - arg1.lastTickSeconds >= var1 then
        task.wait()
        arg1.lastTickSeconds = tick()
    end
end
