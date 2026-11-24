-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.Types)

local var1 = nil

return {
    set = function(arg1)
        var1 = arg1
    end,
    consume = function()
        local var2 = var1
        var1 = nil
        return var2
    end
}
