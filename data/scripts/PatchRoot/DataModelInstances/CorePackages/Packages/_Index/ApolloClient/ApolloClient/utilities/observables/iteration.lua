-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:50:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local module = {}

local _Observable = require(script.Parent.Observable)

function module.iterateObserversSafely(arg1, str1: string, arg2)
    local tbl1 = {}

    arg1:forEach(function(arg3)
        if arg3[str1] ~= nil then
            table.insert(tbl1, arg3)
        end
    end)

    Array.forEach(tbl1, function(arg3)
        arg3[str1](arg3, arg2)
    end)
end

return module
