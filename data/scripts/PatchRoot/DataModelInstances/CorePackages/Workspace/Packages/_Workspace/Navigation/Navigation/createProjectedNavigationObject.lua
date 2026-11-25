-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local RoactNavigation = require(scriptParentParent.RoactNavigation)
local getNavigation = RoactNavigation.getNavigation
local Actions = RoactNavigation.Actions
local Signals = require(scriptParentParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed
local SignalsExperimental = require(scriptParentParent.SignalsExperimental)

local _types = require(script.Parent.types)
local SharedFlags = require(scriptParentParent.SharedFlags)
local FFlagSignalsNavPendingLock = SharedFlags.FFlagSignalsNavPendingLock

local var1 = _G.__DEV__ or _G.__TESTEZ_RUNNING_TEST__

local var2 = SharedFlags.FIntSignalsNavPendingLockFailsafeMs / 1000

local function createProjectedNavigationObject(arg1, tbl1)
    local onPendingFailsafeRelease = if tbl1 == nil then nil else tbl1.onPendingFailsafeRelease
    local tbl2 = {}
    local getIsNavigating, var4 = createSignal(false)

    local getState, var6 = createSignal(function()
        return (arg1.getStateForAction(Actions.init()))
    end)

    local currentCallback = nil
    local tbl3 = {}

    local getIsPending, var8 = createSignal(false)

    local tbl4 = ({})

    local function clearPending(arg2) -- Luacid: Inlined by compiler; 4 call sites recovered
        if arg2 == nil then
            table.clear(tbl4)
        else
            if tbl4[arg2] == nil then
                return
            end

            tbl4[arg2] = nil
        end
        var8(next(tbl4) ~= nil)
    end

    local function markPending(arg2)
        local tbl5 = {
            committed = false,
            pendingSince = os.clock()
        }
        tbl4[arg2] = tbl5
        var8(true)
        task.delay(var2, function()
            if tbl4[arg2] ~= tbl5 then
                return
            end

            clearPending(arg2)
            if onPendingFailsafeRelease ~= nil then
                onPendingFailsafeRelease(arg2, tbl5.committed, tbl5.pendingSince)
            end
        end)
    end

    local function setDispatch(callback: (...any) -> (...any))
        currentCallback = callback
        if not (#tbl3 > 0) then
            return
        end

        local tbl5 = tbl3
        tbl3 = {}
        for _, value in tbl5 do
            callback(value)
        end
    end

    local function clearDispatch()
        currentCallback = nil
        if FFlagSignalsNavPendingLock then
            clearPending(nil)
        end
    end

    local function update(arg2)
        if arg2 == nil then
            return
        end
        SignalsExperimental.batch(function()
            var6(arg2)
            var4(arg2.isTransitioning == true)
        end)
    end

    local function dispatch(arg2): boolean
        if var1 and arg2.type == "RESET_NAVIGATION_FOR_TESTING_ONLY__DO_NOT_USE_IN_PRODUCTION" then
            SignalsExperimental.batch(function()
                var6((arg1.getStateForAction(Actions.init())))
                var4(false)
                if FFlagSignalsNavPendingLock then
                    clearPending(nil)
                end
            end)

            return true
        end

        if currentCallback == nil then
            local var9 = getState(false)
            local stateForAction = arg1.getStateForAction(arg2, var9)
            if stateForAction ~= nil and stateForAction ~= var9 then
                var6(stateForAction)
            end
            table.insert(tbl3, arg2)
            return true
        end

        if not FFlagSignalsNavPendingLock then
            currentCallback(arg2)
            return true
        end

        markPending(arg2)

        local bool1 = false
        task.defer(function()
            if not bool1 then
                clearPending(arg2)
            end
        end)
        currentCallback(arg2)
        bool1 = true
        return true
    end

    local function func1()
        return nil
    end
    local computed = createComputed(function(arg2)
        local var9 = getState(arg2)
        return getNavigation(arg1, var9, dispatch, tbl2, function<T>(_, arg3: T): T
            return arg3
        end, function()
            return func1()
        end)
    end)
    func1 = computed

    return {
        dispatch = dispatch,
        notifyEvents = function() end,
        getState = getState,
        getNavigation = computed,
        getIsNavigating = getIsNavigating,
        getIsPending = getIsPending,
        update = update,
        setDispatch = setDispatch,
        clearDispatch = clearDispatch,
        clearPending = clearPending,
        markPendingCommitted = function(arg2)
            local var9 = tbl4[arg2]
            if var9 ~= nil then
                var9.committed = true
            end
        end
    }
end

return createProjectedNavigationObject
