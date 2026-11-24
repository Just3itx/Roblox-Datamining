-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Signals = require(scriptParentParent.Signals)

local function defaultFilter(...)
    return select(1, ...)
end

local function createRBXEventSignal(rbxScriptSignal, arg1, func1: ((...any) -> (...any))?)
    local var1, var2 = Signals.createSignal(arg1)

    if func1 == nil then
        func1 = defaultFilter
    end
    return var1, (rbxScriptSignal:Connect(function(...)
        var2(func1(...))
    end))
end
return createRBXEventSignal
