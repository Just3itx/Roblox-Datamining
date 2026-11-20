-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local createComputed = require(scriptParentParent.Signals).createComputed

local function createReducer(func1: (...any) -> (...any), arg1)
    local bool1 = false
    local var1 = nil

    local function ensureInitialized() -- Luacid: Inlined by compiler; 1 call site recovered
        if not bool1 then
            bool1 = true
            var1 = if typeof(arg1) == "function" then arg1() else arg1
        end
    end

    return createComputed(function(arg2)
        ensureInitialized()
        var1 = func1(arg2, var1)
        return var1
    end)
end

return createReducer
