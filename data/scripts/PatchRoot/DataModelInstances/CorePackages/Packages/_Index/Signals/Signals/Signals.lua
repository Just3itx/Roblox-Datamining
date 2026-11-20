-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local SignalsScheduler = require(scriptParentParent.SignalsScheduler)
local flush = SignalsScheduler.flush
local schedule = SignalsScheduler.schedule

local callUserSpace = require(script.Parent.callUserSpace)

local var1 = table.freeze({ __mode = "k" })
local function createWeakSet(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (setmetatable(tbl1, var1))
end

local function defaultEquals(arg1, arg2): boolean
    return arg1 == arg2
end

local function handleError(bool1: boolean, ...)
    if not bool1 then
        error((...))
    end
end

local function handleScopeValidation(callback: (...any) -> (...any), bool1: boolean, ...)
    callback()
    handleError(bool1, ...)
    return ...
end

local var2 = (_G.__SIGNALS_VALIDATION_ENABLED__ or _G.__DEV__) and function(func1: (...any) -> (...any), func2: (...any) -> (...any)) -- name: callUserSpaceWithScopeValidation
    local bool1 = true

    return handleScopeValidation(function() -- name: kill
        bool1 = false
    end, pcall(callUserSpace, func1, function(func3: (...any) -> (...any)) -- name: wrappedScope
        if not bool1 then
            error("attempted to use scope beyond scope's lifetime")
        end
        return func2(func3)
    end))
end or callUserSpace

return {
    createSignal = function(arg1, func1: ((...any) -> (...any))?)
        local bool1 = false
        local num1 = 0

        local var3 = nil
        local weakSet = nil

        if func1 == nil then
            func1 = defaultEquals
        end
        local function ensureInitialized()
            if bool1 then
                return
            end

            bool1 = true
            var3 = if typeof(arg1) == "function" then callUserSpace(arg1) else arg1
            num1 = os.clock()
            weakSet = createWeakSet({})
        end

        local function source(func2: ((...any) -> (...any))?, bool2: boolean?)
            if func2 == nil then
                return num1
            end

            if bool2 then
                weakSet[func2] = nil
            else
                weakSet[func2] = true
            end
            return 0
        end

        local function connectToScope(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
            if arg2 then
                local var4 = arg2(source)
                weakSet[var4] = true
            end
        end

        local function notifyObservers() -- Luacid: Inlined by compiler; 1 call site recovered
            for value in weakSet do
                value()
            end
            table.clear(weakSet)
        end

        local function getter(arg2)
            ensureInitialized()
            connectToScope(arg2)
            return var3
        end

        local function setter(arg2)
            ensureInitialized()
            if typeof(arg2) == "function" then
                arg2 = callUserSpace(arg2, var3)
            end

            if not callUserSpace(func1, var3, arg2) then
                var3 = arg2
                num1 = os.clock()
                notifyObservers()
                flush()
            end
        end

        return getter, setter
    end,
    createComputed = function(func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
        local bool1 = false
        local bool2 = false
        local num1 = 0
        local num2 = 0

        local var3 = nil
        local var4 = nil
        local weakSet = nil

        if func2 == nil then
            func2 = defaultEquals
        end
        local function notifyObservers() -- Luacid: Inlined by compiler; 1 call site recovered
            for value in weakSet do
                value()
            end
            table.clear(weakSet)
        end

        local function observer()
            if not bool2 then
                bool2 = true
                notifyObservers()
            end
        end

        local function scope(func3: (...any) -> (...any))
            var4[func3] = true
            return observer
        end

        local function ensureInitialized()
            if bool1 then
                return
            end

            bool1 = true
            weakSet = createWeakSet({})
            var4 = {}
            var3 = var2(func1, scope)
            num2 = os.clock()
            num1 = num2
        end

        local function disconnectSources() -- Luacid: Inlined by compiler; 1 call site recovered
            for value in var4 do
                value(observer, true)
            end
            table.clear(var4)
        end

        local function flushNotifications()
            if not bool2 then
                return
            end

            bool2 = false
            for value in var4 do
                if not (value() > num2) then
                    continue
                end

                disconnectSources()
                local var5 = var2(func1, scope)
                num2 = os.clock()
                if not callUserSpace(func2, var3, var5) then
                    var3 = var5
                    num1 = num2
                end
                return
            end

            for value in var4 do
                value(observer)
            end
        end

        local function source(func3: ((...any) -> (...any))?, bool3: boolean?)
            if func3 == nil then
                flushNotifications()
                return num1
            end

            if bool3 then
                weakSet[func3] = nil
            else
                weakSet[func3] = true
            end
            return 0
        end

        local function connectToScope(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
            if arg1 then
                local var5 = arg1(source)
                weakSet[var5] = true
            end
        end

        local function getter(arg1)
            ensureInitialized()
            flushNotifications()
            connectToScope(arg1)
            return var3
        end

        return getter
    end,
    createEffect = function(func1: (...any) -> (...any))
        local bool1 = false
        local bool2 = false
        local num1 = 0

        local tbl1 = ({})

        local observer = nil

        local function disconnectSources() -- Luacid: Inlined by compiler; 2 call sites recovered
            for value in tbl1 do
                value(observer, true)
            end
            table.clear(tbl1)
        end

        local function dispose()
            bool2 = true
            disconnectSources()
        end

        local function scope(func2: (...any) -> (...any))
            tbl1[func2] = true
            return observer
        end

        local function processNotification()
            if bool2 then
                return
            end

            bool1 = false
            for value in tbl1 do
                if value() > num1 then
                    disconnectSources()
                    var2(func1, scope)
                    num1 = os.clock()
                    return
                end
            end
            for value in tbl1 do
                value(observer)
            end
        end

        observer = function()
            if not (bool2 or bool1) then
                bool1 = true
                schedule(processNotification)
            end
        end

        var2(func1, scope)
        num1 = os.clock()

        return dispose
    end
}
