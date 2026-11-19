-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:45Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local _LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local Observable = require(script.Parent.Parent.Parent.utilities).Observable

function module.fromPromise(arg1)
    return Observable.new(function(arg2)
        arg1:andThen(function(arg3)
            arg2:next(arg3)
            arg2:complete()
        end):catch(function(arg3)
            arg2.error(arg2, arg3)
        end)
    end)
end

return module
