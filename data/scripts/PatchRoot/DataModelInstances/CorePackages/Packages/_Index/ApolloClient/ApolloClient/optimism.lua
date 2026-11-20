-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Set = LuauPolyfill.Set
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}

local Trie = require(scriptParent.wry.trie).Trie

local Cache = require(script.cache).Cache
local Entry = require(script.entry).Entry

local parentEntrySlot = require(script.context).parentEntrySlot

local context = require(script.context)
module.bindContext = context.bindContext
module.noContext = context.noContext
module.setTimeout = context.setTimeout

module.dep = require(script.dep).dep

local function makeDefaultMakeCacheKeyFunction() -- Luacid: Inlined by compiler; 2 call sites recovered
    local trie = Trie.new(true)
    return function(_, ...)
        return trie:lookupArray({ ... })
    end
end

module.defaultMakeCacheKey = makeDefaultMakeCacheKeyFunction()

module.KeyTrie = Trie

local _initTypes = require(script.initTypes)

local set = Set.new()

function module.wrap(func1: (...any) -> (...any), arg1, arg2)
    local var1 = arg1
    var1 = var1 == nil and {} or var1

    local cache = Cache.new(Boolean.toJSBoolean(var1.max) and var1.max or 65536, function(arg3)
        return arg3:dispose()
    end)

    local keyArgs = var1.keyArgs
    local var2 = Boolean.toJSBoolean(var1.makeCacheKey) and var1.makeCacheKey or makeDefaultMakeCacheKeyFunction()

    if arg2 ~= nil then
        local func2 = func1
        func1 = function(...)
            return func2(arg2, ...)
        end
    end

    local var3 = (setmetatable({}, {
        __call = function(_, arg3, ...)
            local tbl1 = arg2 == nil and { arg3, ... } or { ... }

            local var3 = var2(nil, table.unpack((function()
                if keyArgs then
                    return keyArgs(nil, table.unpack(tbl1))
                end
                return tbl1
            end)()))

            if var3 == nil then
                return func1(table.unpack(tbl1))
            end

            local var4 = cache:get(var3)
            if var4 == nil then
                var4 = Entry.new(func1)
                cache:set(var3, var4)
                var4.subscribe = var1.subscribe

                function var4.forget()
                    return cache:delete(var3)
                end
            end

            local var5 = var4:recompute((Array.slice(tbl1)))

            cache:set(var3, var4)

            set:add(cache)

            if not parentEntrySlot:hasValue() then
                set:forEach(function(arg4)
                    return arg4:clean()
                end)
                set:clear()
            end

            return var5
        end,
        __index = function(arg3, arg4)
            if arg4 == "size" then
                return cache.map.size
            end
            return rawget(arg3, arg4)
        end,
        __newindex = function(arg3, arg4, arg5)
            if arg4 == "size" then
                error("attempt to update a read-only table", 2)
            end
            rawset(arg3, arg4, arg5)
        end
    }))

    local function asMethod(func2: (...any) -> (...any)) -- Luacid: Inlined by compiler; 7 call sites recovered
        return function(_, ...)
            return func2(...)
        end
    end

    local function dirtyKey(arg3) -- Luacid: Inlined by compiler; 1 call site recovered
        local var4 = cache:get(arg3)
        if Boolean.toJSBoolean(var4) then
            var4:setDirty()
        end
    end

    var3.dirtyKey = asMethod(dirtyKey)

    var3.dirty = asMethod(function(...)
        dirtyKey((var2(nil, ...)))
    end)

    local function peekKey(arg3)
        local var4 = cache:get(arg3)
        if Boolean.toJSBoolean(var4) then
            return var4:peek()
        end
    end

    var3.peekKey = asMethod(peekKey)

    var3.peek = asMethod(function(...)
        return peekKey(var2(nil, ...))
    end)

    local function forgetKey(arg3)
        return cache:delete(arg3)
    end

    var3.forgetKey = asMethod(forgetKey)

    var3.forget = asMethod(function(...)
        return forgetKey(var2(nil, ...))
    end)

    var3.makeCacheKey = var2
    if Boolean.toJSBoolean(keyArgs) then
        var3.getKey = asMethod(function(...)
            return var2(nil, table.unpack(keyArgs(...)))
        end)
    else
        var3.getKey = var2
    end

    return Object.freeze(var3)
end

return module
