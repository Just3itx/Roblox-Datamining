-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local useRef = require(scriptParentParentParentParentParent.React).useRef
local equal = require(scriptParentParentParentParent.jsutils.equal)

function module.useDeepMemo(func1: (...any) -> (...any), key)
    local var1 = useRef(nil)
    if not (var1.current and equal(key, var1.current.key)) then
        var1.current = {
            key = key,
            value = func1()
        }
    end
    return var1.current.value
end

return module
