-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:30:41Z
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

local module = {}
module.__index = module

module.Status = { Started = "Started", Resolved = "Resolved", Rejected = "Rejected" }

function module.new(arg1)
    local tbl1 = {
        _source = debug.traceback(),
        _type = "Promise",
        _status = module.Status.Started,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = false,
        _queuedResolve = {},
        _queuedReject = {}
    }

    setmetatable(tbl1, module)

    local function reject(...)
        tbl1:_reject(...)
    end

    local _, tbl2 = wpcallPacked(arg1, function(...) -- name: resolve
        tbl1:_resolve(...)
    end, reject)
    local var1 = tbl2[1]
    local var2 = tbl2[2]

    if not var1 and tbl1._status == module.Status.Started then
        reject(var2)
    end

    return tbl1
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

function module.all(...)
    local tbl1 = { ... }

    if type(tbl1[1]) == "table" and tbl1[1]._type ~= "Promise" then
        tbl1 = tbl1[1]
    end

    return module.new(function(callback, callback2)
        local bool1 = false
        local tbl2 = ({})
        local num1 = 0
        local num2 = 0

        for _ in pairs(tbl1) do
            num2 += 1
        end

        local function promiseCompleted(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool1 then
                return
            end

            tbl2[arg1] = arg2
            num1 += 1

            if num1 == num2 then
                callback(tbl2)
                bool1 = true
            end
        end

        if num2 == 0 then
            callback(tbl2)
            bool1 = true
            return
        end

        for k, value in pairs(tbl1) do
            if value._status == module.Status.Started then
                value:andThen(function(arg1)
                    promiseCompleted(k, arg1)
                end):catch(function(arg1)
                    bool1 = true
                    callback2(arg1)
                end)
            elseif value._status == module.Status.Resolved then
                local _values = value._values
                promiseCompleted(k, (unpack(_values)))
            else
                value:catch(function(_)
                    bool1 = true
                    callback2(unpack(value._values))
                end)
            end
        end
    end)
end

function module.is(arg1): boolean
    return type(arg1) == "table" and arg1._type == "Promise"
end

function module.promisify(arg1)
    return function(...)
        local tbl1 = { ... }
        local select = select
        local var1 = select("#", ...)

        return module.new(function(callback, callback2)
            spawn(function()
                local var2 = arg1
                local tbl2 = tbl1
                local var3 = var1
                local unpack = unpack
                local success, result = pcall(var2, unpack(tbl2, 1, var3))

                if success then
                    callback(result)
                    return
                end
                callback2(result)
            end)
        end)
    end
end

function module:getStatus()
    return self._status
end

function module:andThen(arg1, arg2)
    self._unhandledRejection = false

    return module.new(function(callback, arg3)
        local var1 = if arg1 then createAdvancer(arg1, callback, arg3) else callback

        if arg2 then
            arg3 = createAdvancer(arg2, callback, arg3)
        end

        if self._status == module.Status.Started then
            table.insert(self._queuedResolve, var1)
            table.insert(self._queuedReject, arg3)
        elseif self._status == module.Status.Resolved then
            var1(unpack(self._values, 1, self._valuesLength))
        elseif self._status == module.Status.Rejected then
            arg3(unpack(self._values, 1, self._valuesLength))
        end
    end)
end

function module.catch(arg1, arg2)
    return arg1:andThen(nil, arg2)
end

function module:await()
    self._unhandledRejection = false

    if self._status ~= module.Status.Started then
        if self._status == module.Status.Resolved then
            return true, unpack(self._values, 1, self._valuesLength)
        end

        if self._status == module.Status.Rejected then
            return false, unpack(self._values, 1, self._valuesLength)
        end

        return
    end

    local tbl1 = nil
    local var1 = nil
    local bindableEvent = Instance.new("BindableEvent")

    self:andThen(function(...)
        tbl1 = { ... }
        local select = select
        var1 = select("#", ...)
        bindableEvent:Fire(true)
    end, function(...)
        tbl1 = { ... }
        local select = select
        var1 = select("#", ...)
        bindableEvent:Fire(false)
    end)

    local var2 = bindableEvent.Event:Wait()
    bindableEvent:Destroy()

    return var2, unpack(tbl1, 1, var1)
end

function module:_resolve(...)
    if self._status ~= module.Status.Started then
        return
    end

    local select = select
    local _valuesLength = select("#", ...)

    if module.is((...)) then
        if _valuesLength > 1 then
            local str1 = ("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s"):format(self._source)

            warn(str1)
        end

        (...):andThen(function(...)
            self:_resolve(...)
        end, function(...)
            self:_reject(...)
        end)

        return
    end

    self._status = module.Status.Resolved
    self._values = { ... }
    self._valuesLength = _valuesLength

    for _, value in ipairs(self._queuedResolve) do
        value(...)
    end
end

function module:_reject(...)
    if self._status ~= module.Status.Started then
        return
    end

    self._status = module.Status.Rejected
    self._values = { ... }
    local select = select
    self._valuesLength = select("#", ...)

    if not isEmpty(self._queuedReject) then
        for _, value in ipairs(self._queuedReject) do
            value(...)
        end

        return
    end

    self._unhandledRejection = true
    local str1 = tostring((...))

    spawn(function()
        if not self._unhandledRejection then
            return
        end

        local str2 = ("Unhandled promise rejection:\n\n%s\n\n%s"):format(str1, self._source)
        warn(str2)
    end)
end

return module
