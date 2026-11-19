-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:50:47Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local _LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local Observable = require(script.Parent.Observable).Observable

function module.fixObservableSubclass(arg1)
    local function set(str1: string)
        arg1[str1] = Observable
    end

    set("@@species")

    return arg1
end
return module
