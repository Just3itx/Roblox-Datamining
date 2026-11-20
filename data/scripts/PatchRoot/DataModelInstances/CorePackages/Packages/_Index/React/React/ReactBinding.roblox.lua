-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols

local _Shared = require(scriptParentParent.Shared)

local Symbol = LuauPolyfill.Symbol
local createSignalRoblox = require(script.Parent["createSignal.roblox"])

local enableAllocationTrims = require(scriptParentParent.Shared).ReactFeatureFlags.enableAllocationTrims

local var1 = Symbol("BindingImpl")

local module = {}

local tbl1 = {
    __index = {
        getValue = function(tbl1)
            return module.getValue(tbl1)
        end,
        map = function(tbl1, func1: (...any) -> (...any))
            return module.map(tbl1, func1)
        end
    },
    __tostring = function(arg1): string
        return string.format("RoactBinding(%s)", tostring(arg1:getValue()))
    end
}

local tbl2 = {
    getValue = function(arg1)
        return arg1.value
    end,
    update = function(arg1, value)
        arg1.value = value
        local fire = arg1.fire
        if fire ~= nil then
            fire(value)
        end
    end,
    subscribe = function(arg1, func1: (...any) -> (...any))
        local subscribeToSignal = arg1.subscribeToSignal
        if subscribeToSignal == nil then
            local var2
            subscribeToSignal, var2 = createSignalRoblox()
            arg1.fire = var2
            arg1.subscribeToSignal = subscribeToSignal
        end
        return subscribeToSignal(func1)
    end
}
local tbl3 = { __index = tbl2 }

function module.update(arg1, arg2)
    if not enableAllocationTrims then
        return arg1[var1].update(arg2)
    end

    local var2 = arg1[var1]
    if getmetatable(var2) == tbl3 then
        return tbl2.update(var2, arg2)
    end
    return var2.update(arg2)
end

function module.subscribe(arg1, func1: (...any) -> (...any))
    if not enableAllocationTrims then
        return arg1[var1].subscribe(func1)
    end

    local var2 = arg1[var1]
    if getmetatable(var2) == tbl3 then
        return tbl2.subscribe(var2, func1)
    end
    return var2.subscribe(func1)
end

function module.getValue(arg1)
    return arg1[var1]:getValue()
end

function module.createWithoutUpdater(value, _source: string?)
    local var2 = setmetatable({ value = value }, tbl3)

    return (setmetatable({ ["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE, [var1] = var2, _source = _source }, tbl1))
end

function module.create(value)
    if enableAllocationTrims then
        local _source = if ReactGlobals.__DEV__ then debug.traceback("Binding created at:", 3) else nil
        local withoutUpdater = module.createWithoutUpdater(value, _source)
        local var2 = withoutUpdater[var1]

        return withoutUpdater, function(arg2)
            tbl2.update(var2, arg2)
        end
    end

    local subscribe, var3 = createSignalRoblox()
    local tbl4 = { value = value, subscribe = subscribe }

    function tbl4.update(arg1)
        tbl4.value = arg1
        var3(arg1)
    end

    function tbl4.getValue()
        return tbl4.value
    end

    local _source = if ReactGlobals.__DEV__ then debug.traceback("Binding created at:", 3) else nil
    return setmetatable({ ["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE, [var1] = tbl4, _source = _source }, tbl1), tbl4.update
end

function module.map(tbl4, func1: (...any) -> (...any))
    if ReactGlobals.__DEV__ then
        assert(
            typeof(tbl4) == "table" and tbl4["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE,
            "Expected `self` to be a binding"
        )

        assert(typeof(func1) == "function", "Expected arg #1 to be a function")
    end

    local tbl5 = {
        subscribe = function(callback)
            return module.subscribe(tbl4, function(arg1)
                callback(func1(arg1))
            end)
        end,
        update = function(_)
            error("Bindings created by Binding:map(fn) cannot be updated directly", 2)
        end,
        getValue = function()
            return func1(tbl4:getValue())
        end
    }

    local _source = if ReactGlobals.__DEV__ then debug.traceback("Mapped binding created at:", 3) else nil
    return (setmetatable({ ["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE, [var1] = tbl5, _source = _source }, tbl1))
end

function module.join(tbl4)
    if ReactGlobals.__DEV__ then
        assert(typeof(tbl4) == "table", "Expected arg #1 to be of type table")

        for value, value2 in tbl4 do
            if typeof(value2) ~= "table" or value2["$$typeof"] ~= ReactSymbols.REACT_BINDING_TYPE then
                local str1 = ("Expected arg #1 to contain only bindings, but key %q had a non-binding value"):format(tostring(value))

                error(str1, 2)
            end
        end
    end

    local tbl5 = {}

    local function getValue()
        local value = ({})

        for k, value2 in pairs(tbl4) do
            value[k] = value2:getValue()
        end

        return value
    end

    function tbl5.subscribe(callback)
        local tbl6 = ({})

        for value, value2 in tbl4 do
            local var2 = module.subscribe(value2, function(_)
                callback((getValue()))
            end)

            tbl6[value] = var2
        end

        return function()
            if tbl6 == nil then
                return
            end

            for _, value in tbl6 do
                value()
            end

            tbl6 = nil
        end
    end

    function tbl5.update(_)
        error("Bindings created by joinBindings(...) cannot be updated directly", 2)
    end

    function tbl5.getValue()
        return (getValue())
    end

    local _source = if ReactGlobals.__DEV__ then debug.traceback("Joined binding created at:", 2) else nil
    return (setmetatable({ ["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE, [var1] = tbl5, _source = _source }, tbl1))
end

return module
