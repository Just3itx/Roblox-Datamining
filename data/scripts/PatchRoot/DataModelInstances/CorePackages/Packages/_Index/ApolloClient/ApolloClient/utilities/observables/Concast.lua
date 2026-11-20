-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Set = LuauPolyfill.Set
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error

local Promise = require(scriptParentParentParentParent.Promise)

local sub = {}

local Observable = require(script.Parent.Observable).Observable

local iterateObserversSafely = require(script.Parent.iteration).iterateObserversSafely
local fixObservableSubclass = require(script.Parent.subclassing).fixObservableSubclass

local function isPromiseLike(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return Boolean.toJSBoolean(arg1) and typeof(arg1.andThen) == "function"
end

local Concast = setmetatable({}, { __index = Observable })
Concast.__index = Concast

function Concast.new(arg1)
    local var2 = nil
    var2 = setmetatable(Observable.new(function(arg2)
        var2:addObserver(arg2)
        return function()
            return var2:removeObserver(arg2)
        end
    end), Concast)

    local set = Set.new()
    var2.observers = set

    var2.sub = sub

    var2.source = {}

    var2.latest = nil

    var2.addCount = 0

    local promise = Promise.new(function(callback, callback2)
        function var2.resolve(_, ...)
            callback(...)
        end
        function var2.reject(_, ...)
            callback2(...)
        end
    end)

    var2.promise = promise

    var2.handlers = {
        next = function(_, arg2)
            if var2.sub == nil then
                return
            end

            var2.latest = { "next", arg2 }
            iterateObserversSafely(var2.observers, "next", arg2)
        end,
        error = function(_, arg2)
            local sub = var2.sub
            if sub == nil then
                return
            end

            if Boolean.toJSBoolean(sub) then
                Promise.delay(0):andThen(function()
                    return sub:unsubscribe()
                end)
            end
            var2.sub = nil
            var2.latest = { "error", arg2 }
            var2:reject(arg2)
            iterateObserversSafely(var2.observers, "error", arg2)
        end,
        complete = function(_)
            if var2.sub == nil then
                return
            end

            local var3 = table.remove(var2.sources, 1)
            if not Boolean.toJSBoolean(var3) then
                var2.sub = nil
                if var2.latest ~= nil and var2.latest[1] == "next" then
                    var2:resolve(var2.latest[2])
                else
                    var2:resolve()
                end

                iterateObserversSafely(var2.observers, "complete")
                return
            end

            if isPromiseLike(var3) then
                var3:andThen(function(arg2)
                    var2.sub = arg2:subscribe(var2.handlers)
                end)

                return
            end

            var2.sub = var3:subscribe(var2.handlers)
        end
    }

    function var2.cancel(_, arg2)
        var2:reject(arg2)
        var2.sources = {}
        var2.handlers:complete()
    end

    var2.promise:catch(function() end)

    arg1 = typeof(arg1) == "function" and { Observable.new(arg1) } or arg1

    if isPromiseLike(arg1) then
        arg1:andThen(function(arg2)
            var2:start(arg2)
        end, function(...)
            var2.handlers:error(...)
        end)
    else
        var2:start(arg1)
    end

    return var2
end

function Concast:start(arg1)
    if self.sub ~= sub then
        return
    end

    self.sources = Array.from(arg1)

    self.handlers:complete()
end

function Concast:deliverLastMessage(arg1)
    if not Boolean.toJSBoolean(self.latest) then
        return
    end

    local var2 = self.latest[1]
    local var3 = arg1[var2]
    if Boolean.toJSBoolean(var3) then
        var3(arg1, self.latest[2])
    end

    if self.sub == nil and var2 == "next" and arg1.complete ~= nil then
        arg1.complete(arg1)
    end
end

function Concast:addObserver(arg1)
    if not self.observers:has(arg1) then
        self:deliverLastMessage(arg1)
        self.observers:add(arg1)
        self.addCount += 1
    end
end

function Concast:removeObserver(arg1, bool1: boolean?)
    if not self.observers:delete(arg1) then
        return
    end
    self.addCount -= 1
    if self.addCount < 1 and not bool1 then
        self.handlers:error(Error.new("Observable cancelled prematurely"))
    end
end

function Concast:cleanup(callback: (...any) -> (...any))
    local bool1 = false
    local var2 = nil
    local function once()
        if not bool1 then
            bool1 = true

            self.observers:delete(var2)
            callback()
        end
    end
    var2 = { next = once, error = once, complete = once }
    local addCount = self.addCount
    self:addObserver(var2)

    self.addCount = addCount
end

function Concast.of(...)
    return Observable.of(Concast, ...)
end

function Concast.from(...)
    return Observable.from(Concast, ...)
end

tbl1.Concast = Concast

fixObservableSubclass(Concast)

return tbl1
