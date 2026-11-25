-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local RoactNavigation = require(scriptParentParent.RoactNavigation)
local getNavigation = RoactNavigation.getNavigation
local Actions = RoactNavigation.Actions
local Events = RoactNavigation.Events
local Signals = require(scriptParentParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local SignalsExperimental = require(scriptParentParent.SignalsExperimental)

local FFlagSignalsNavP2NavigationPrimitives = require(scriptParentParent.SharedFlags).FFlagSignalsNavP2NavigationPrimitives

local var1 = _G.__DEV__ or _G.__TESTEZ_RUNNING_TEST__

local _types = require(script.Parent.types)

local function makeEvent(action, state, lastState) -- Luacid: Inlined by compiler; 2 call sites recovered
    return table.freeze({ type = Events.Action, action = action, state = state, lastState = lastState })
end

local function createSignalsNavigationObject(arg1)
    local tbl1 = {}
    local tbl2 = {}
    local getIsNavigating, var3 = createSignal(false)

    local function notifySubscribers(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        for value in tbl1 do
            task.spawn(value, arg2)
        end
    end

    local function notifyEvents()
        if FFlagSignalsNavP2NavigationPrimitives then
            var3(false)
        end
        local tbl3 = tbl2
        tbl2 = {}
        for _, value in tbl3 do
            notifySubscribers(value)
        end
    end

    local getState, var5 = createSignal(function()
        local var4 = Actions.init()
        local stateForAction = arg1.getStateForAction(var4)
        table.insert(tbl2, (makeEvent(var4, stateForAction, nil)))
        return stateForAction
    end)

    local function dispatch(action): boolean
        if var1 and action.type == "RESET_NAVIGATION_FOR_TESTING_ONLY__DO_NOT_USE_IN_PRODUCTION" then
            if FFlagSignalsNavP2NavigationPrimitives then
                var3(false)
            end
            var5((arg1.getStateForAction(Actions.init())))
            return true
        end

        local var6 = getState(false)
        local stateForAction = arg1.getStateForAction(action, var6)
        local var7 = stateForAction or var6
        local event = makeEvent(action, var7, var6)

        if stateForAction == nil or var7 == var6 then
            notifySubscribers(event)
            return stateForAction == nil
        end

        table.insert(tbl2, event)
        if FFlagSignalsNavP2NavigationPrimitives then
            SignalsExperimental.batch(function()
                var3(true)
                var5(var7)
            end)
        else
            var5(var7)
        end
        return true
    end

    local function func1()
        return nil
    end

    local computed = createComputed(function(arg2)
        local var6 = getState(arg2)
        return getNavigation(arg1, var6, dispatch, tbl1, function<T>(_, arg3: T): T
            return arg3
        end, function()
            return func1()
        end)
    end)

    func1 = computed

    return {
        dispatch = dispatch,
        notifyEvents = notifyEvents,
        getState = getState,
        getNavigation = computed,
        getIsNavigating = getIsNavigating
    }
end

return createSignalsNavigationObject
