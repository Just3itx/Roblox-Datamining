-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Promise = require(scriptParentParentParentParent.Promise)

local _LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local invariant = require(scriptParentParentParent.jsutils.invariant).invariant

local _utilities = require(script.Parent.Parent.Parent.utilities)

function module.toPromise(arg1)
    local bool1 = false
    return Promise.new(function(callback, callback2)
        arg1:subscribe({
            next = function(_, arg2)
                if bool1 then
                    invariant.warn("Promise Wrapper does not support multiple results from Observable")
                    return
                end
                bool1 = true
                callback(arg2)
            end,
            error = function(_, arg2)
                callback2(arg2)
            end
        })
    end):andThen(function(arg2)
        return Promise.delay(0):andThenReturn(arg2)
    end)
end

return module
