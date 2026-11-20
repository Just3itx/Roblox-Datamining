-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set
local Array = LuauPolyfill.Array

require(script.Parent.Parent.globals)

local isNonNullObject = require(script.Parent.objects).isNonNullObject

local function deepFreeze<T>(arg1: T): T
    local set = Set.new({ arg1 })

    for _, value in set do
        if not isNonNullObject(value) then
            continue
        end

        if not table.isfrozen(value) then
            Object.freeze(value)
        end
        Array.forEach(Object.keys(value), function(arg2)
            if isNonNullObject(value[arg2]) then
                set:add(value[arg2])
            end
        end)
    end

    return arg1
end

function module.maybeDeepFreeze<T>(arg1: T): T
    if _G.__DEV__ then
        deepFreeze(arg1)
    end
    return arg1
end
return module
