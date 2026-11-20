-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local module = {}
local dep = require(scriptParentParentParent.optimism).dep

local Slot = require(scriptParentParentParent.wry.context).Slot

local _cache = require(script.Parent.Parent.core.cache)

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Set = LuauPolyfill.Set
local WeakMap = LuauPolyfill.WeakMap

local broadcast = nil

local slot = Slot.new()
module.cacheSlot = slot

local weakMap = WeakMap.new()

local function getCacheInfo(arg1)
    local tbl1 = weakMap:get(arg1)
    if not tbl1 then
        tbl1 = {
            vars = Set.new(),
            dep = dep()
        }

        weakMap:set(arg1, tbl1)
    end
    return tbl1
end

function module.forgetCache(arg1)
    getCacheInfo(arg1).vars:forEach(function(arg2)
        return arg2:forgetCache(arg1)
    end)
end

function module.recallCache(arg1)
    getCacheInfo(arg1).vars:forEach(function(arg2)
        return arg2:attachCache(arg1)
    end)
end

function module.makeVar(arg1)
    local set = Set.new()
    local set2 = Set.new()
    local var1 = nil

    local var2 = nil

    var1 = setmetatable({}, {
        __call = function(_, ...)
            local select = select

            if select("#", ...) >= 1 then
                local var3 = ({ ... })[1]
                if arg1 ~= var3 then
                    arg1 = var3
                    set:forEach(function(arg2)
                        getCacheInfo(arg2).dep:dirty(var1)

                        broadcast(arg2)
                    end)

                    local var4 = Array.from(set2)
                    set2:clear()
                    Array.forEach(var4, function(callback)
                        callback(arg1)
                    end)
                end
            else
                local value = slot:getValue()
                if value then
                    var2(value)
                    getCacheInfo(value).dep(var1)
                end
            end

            return arg1
        end
    })

    function var1.onNextChange(_, arg2)
        set2:add(arg2)
        return function()
            set2:delete(arg2)
        end
    end

    var2 = function(arg2)
        set:add(arg2)
        getCacheInfo(arg2).vars:add(var1)
        return var1
    end
    function var1.attachCache(_, arg2)
        return var2(arg2)
    end

    function var1.forgetCache(_, arg2)
        return set:delete(arg2)
    end

    return var1
end

broadcast = function(arg1)
    if arg1.broadcastWatches ~= nil then
        arg1:broadcastWatches()
    end
end

return module
