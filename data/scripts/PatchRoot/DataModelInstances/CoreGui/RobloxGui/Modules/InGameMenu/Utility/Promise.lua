-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function pack(...)
    local select = select
    return select("#", ...), { ... }
end

local function wpcallPacked(arg1, ...)
    local var1, tbl1 = pack(...)

    local func1 = pack
    local traceback = debug.traceback

    local var2, tbl2 = func1(xpcall(function()
        return arg1(unpack(tbl1, 1, var1))
    end, traceback))

    return var2, tbl2
end

local function createAdvancer(arg1, callback, callback2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(...)
        local var1, tbl1 = wpcallPacked(arg1, ...)
        if tbl1[1] then
            callback(unpack(tbl1, 2, var1))
            return
        end
        callback2(unpack(tbl1, 2, var1))
    end
end

local function isEmpty(_queuedReject): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return next(_queuedReject) == nil
end

local function createSymbol(str1: string) -- Luacid: unused: defined but never referenced
    assert(type(str1) == "string", "createSymbol requires `name` to be a string.")

    local var1 = newproxy(true)

    getmetatable(var1).__tostring = function(): string
        return ("Symbol(%s)"):format(str1)
    end

    return var1
end

assert(true, "createSymbol requires `name` to be a string.")

local var1 = newproxy(true)

local str1 = "PromiseMarker"

getmetatable(var1).__tostring = function(): string
    return ("Symbol(%s)"):format(str1)
end

local module = {
    prototype = {}
}
module.__index = module.prototype

local Status = { Started = 0, Resolved = 0, Rejected = 0 }
assert(true, "createSymbol requires `name` to be a string.")

local Started = newproxy(true)

local str2 = "Started"

getmetatable(Started).__tostring = function(): string
    return ("Symbol(%s)"):format(str2)
end

Status.Started = Started
assert(true, "createSymbol requires `name` to be a string.")

local Resolved = newproxy(true)

local str3 = "Resolved"

getmetatable(Resolved).__tostring = function(): string
    return ("Symbol(%s)"):format(str3)
end

Status.Resolved = Resolved
assert(true, "createSymbol requires `name` to be a string.")

local Rejected = newproxy(true)

local str4 = "Rejected"

getmetatable(Rejected).__tostring = function(): string
    return ("Symbol(%s)"):format(str4)
end

Status.Rejected = Rejected
module.Status = Status

function module.new(arg1)
    local tbl2 = {
        _source = debug.traceback(),
        [var1] = true,
        _status = module.Status.Started,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = false,
        _queuedResolve = {},
        _queuedReject = {}
    }

    setmetatable(tbl2, module)

    local function reject(...)
        tbl2:_reject(...)
    end

    local _, tbl3 = wpcallPacked(arg1, function(...) -- name: resolve
        tbl2:_resolve(...)
    end, reject)
    local var5 = tbl3[1]
    local var6 = tbl3[2]

    if not var5 and tbl2._status == module.Status.Started then
        reject(var6)
    end

    return tbl2
end

function module.resolve(arg1)
    return module.new(function(callback)
        callback(arg1)
    end)
end

function module.reject(arg1)
    return module.new(function(_, callback)
        callback(arg1)
    end)
end

function module.all(arg1)
    if type(arg1) ~= "table" then
        error("Please pass a list of promises to Promise.all", 2)
    end

    if #arg1 == 0 then
        return module.resolve({})
    end

    for i = 1, #arg1 do
        if not module.is(arg1[i]) then
            error(("Non-promise value passed into Promise.all at index #%d"):format(i), 2)
        end
    end

    return module.new(function(callback, callback2)
        local tbl2 = ({})

        local num1 = 0

        local function resolveOne(arg2, ...)
            tbl2[arg2] = ...
            num1 += 1

            if num1 == #arg1 then
                callback(tbl2)
            end
        end

        for i = 1, #arg1 do
            arg1[i]:andThen(function(...)
                resolveOne(i, ...)
            end, function(...)
                callback2(...)
            end)
        end
    end)
end

function module.is(arg1): boolean
    return type(arg1) == "table" and arg1[var1] == true
end

function module.prototype:getStatus()
    return self._status
end

function module.prototype:andThen(arg1, arg2)
    self._unhandledRejection = false

    return module.new(function(callback, arg3)
        local var5 = if arg1 then createAdvancer(arg1, callback, arg3) else callback

        if arg2 then
            arg3 = createAdvancer(arg2, callback, arg3)
        end

        if self._status == module.Status.Started then
            table.insert(self._queuedResolve, var5)
            table.insert(self._queuedReject, arg3)
        elseif self._status == module.Status.Resolved then
            var5(unpack(self._values, 1, self._valuesLength))
        elseif self._status == module.Status.Rejected then
            arg3(unpack(self._values, 1, self._valuesLength))
        end
    end)
end

function module.prototype.catch(arg1, arg2)
    return arg1:andThen(nil, arg2)
end

function module.prototype:await()
    self._unhandledRejection = false

    if self._status ~= module.Status.Started then
        if self._status == module.Status.Resolved then
            return true, unpack(self._values, 1, self._valuesLength)
        end

        if self._status == module.Status.Rejected then
            return false, unpack(self._values, 1, self._valuesLength)
        end
        error("Promise had an invalid status.")
        return
    end

    local var5 = nil
    local var6 = nil
    local bindableEvent = Instance.new("BindableEvent")

    self:andThen(function(...)
        var6, var5 = pack(...)
        bindableEvent:Fire(true)
    end, function(...)
        var6, var5 = pack(...)
        bindableEvent:Fire(false)
    end)

    local var7 = bindableEvent.Event:Wait()
    bindableEvent:Destroy()

    return var7, unpack(var5, 1, var6)
end

function module.prototype:_unwrap()
    if self._status == module.Status.Started then
        error("Promise has not resolved or rejected.", 2)
    end

    return self._status == module.Status.Resolved, unpack(self._values, 1, self._valuesLength)
end

function module.prototype:_resolve(...)
    if self._status ~= module.Status.Started then
        return
    end

    if module.is((...)) then
        local select = select

        if select("#", ...) > 1 then
            local str5 = ("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s"):format(self._source)

            warn(str5)
        end

        (...):andThen(function(...)
            self:_resolve(...)
        end, function(...)
            self:_reject(...)
        end)
    else
        self._status = module.Status.Resolved
        local _valuesLength, _values = pack(...)
        self._valuesLength = _valuesLength
        self._values = _values

        for _, value in ipairs(self._queuedResolve) do
            value(...)
        end
    end
end

function module.prototype:_reject(...)
    if self._status ~= module.Status.Started then
        return
    end

    self._status = module.Status.Rejected
    local _valuesLength, _values = pack(...)
    self._valuesLength = _valuesLength
    self._values = _values

    if not isEmpty(self._queuedReject) then
        for _, value in ipairs(self._queuedReject) do
            value(...)
        end

        return
    end

    self._unhandledRejection = true
    local str5 = tostring((...))

    spawn(function()
        if not self._unhandledRejection then
            return
        end

        local str6 = ("Unhandled promise rejection:\n\n%s\n\n%s"):format(str5, self._source)

        warn(str6)
    end)
end

return module
