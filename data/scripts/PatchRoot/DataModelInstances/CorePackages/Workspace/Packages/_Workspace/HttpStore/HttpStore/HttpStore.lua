-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local Signals = require(scriptParentParent.Signals)
local _InternalHttpStore = require(scriptParentParent.InternalHttpStore)
local createHttpStore = require(script.Parent.createHttpStore)

local var1 = nil

local var2, var3 = Signals.createSignal(nil)
local var4 = var2
local var5 = var3

return {
    _create = function(arg1)
        var1 = createHttpStore(arg1)
        var5(var1)
        return var1
    end,
    _dispose = function()
        local var6 = var4()
        if var6 ~= nil then
            var6.cancelAll()
        end
        var5(nil)
    end,
    get = function(arg1)
        return var4(arg1)
    end
}
