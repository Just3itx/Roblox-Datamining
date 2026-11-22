-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Signals = require(SplitPaneParent.Signals)
local Navigation = require(SplitPaneParent.Navigation)

local OnScreenStore = require(script.Parent.Parent.Stores.OnScreenStore)
local routeIdentity = require(script.Parent.routeIdentity)

local getRouteKeyIsInNavigationState = Navigation.getRouteKeyIsInNavigationState

local function createNavigationHandle(arg1, arg2, callback: ((...any) -> (...any))?)
    local key = if type(arg2) == "string" then arg2 else nil
    local var2, var3 = Signals.createSignal(key)
    if type(arg2) ~= "function" then
        arg2 = nil
    end
    local computed = Signals.createComputed(function(arg3)
        local var4 = var2(arg3)
        local var5 = arg1(arg3)
        return not (var4 == nil or var5 == nil) and getRouteKeyIsInNavigationState(var4, var5)
    end)

    local computed2 = Signals.createComputed(function(arg3): boolean
        local var4 = var2(arg3)
        local var5 = arg1(arg3)
        if var4 == nil or var5 == nil then
            return false
        end

        local routeOnScreen = OnScreenStore.getRouteOnScreen(arg3, var4)

        if routeOnScreen == nil then
            return routeIdentity.findOnFocusedPath(var5, function(arg4): boolean
                return arg4.key == var4
            end) ~= nil
        end

        return routeOnScreen.isOnScreen == true
    end)

    local var4, var5 = Signals.createSignal(false)
    local computed3 = Signals.createComputed(function(arg3)
        return var4(arg3) and not computed(arg3)
    end)

    local tbl1 = {}
    local bool1 = false
    local function destroy()
        if bool1 then
            return
        end
        bool1 = true
        for _, value in tbl1 do
            value()
        end
        if callback ~= nil then
            callback()
        end
    end

    local tbl2 = {
        key = key,
        isOpen = function(arg3)
            return not bool1 and computed(arg3)
        end,
        isFocused = function(arg3)
            return not bool1 and computed2(arg3)
        end,
        onClosed = function(callback2: (...any) -> (...any))
            if computed3(false) then
                callback2()
                return function() end
            end
            if bool1 then
                return function() end
            end
            local effect = nil
            effect = Signals.createEffect(function(arg3)
                if computed3(arg3) then
                    callback2()
                    task.defer(function()
                        effect()
                    end)
                end
            end)
            table.insert(tbl1, effect)
            return effect
        end,
        onFocusChanged = function(callback2: (...any) -> (...any))
            if bool1 then
                return function() end
            end
            local var6 = computed2(false)
            local effect = Signals.createEffect(function(arg3)
                local var7 = computed2(arg3)
                if var7 ~= var6 then
                    var6 = var7
                    callback2(var7)
                end
            end)
            table.insert(tbl1, effect)
            return effect
        end,
        destroy = destroy
    }

    if arg2 ~= nil then
        local effect = nil
        effect = Signals.createEffect(function(arg3)
            if var2(false) ~= nil then
                return
            end
            local onFocusedPath = routeIdentity.findOnFocusedPath(arg1(arg3), arg2)
            if onFocusedPath == nil then
                return
            end

            var3(onFocusedPath.key)
            tbl2.key = onFocusedPath.key
            task.defer(function()
                effect()
            end)
        end)

        table.insert(tbl1, effect)
    end

    table.insert(tbl1, Signals.createEffect(function(arg3)
        if computed(arg3) then
            var5(true)
        end
    end))

    table.insert(tbl1, Signals.createEffect(function(arg3)
        if computed3(arg3) then
            task.defer(destroy)
        end
    end))

    return tbl2
end

return {
    new = createNavigationHandle,
    fromRoduxStore = function(arg1, arg2)
        local function read() -- Luacid: Inlined by compiler; 2 call sites recovered
            local navigation = arg1:getState().Navigation
            return if navigation then navigation.roactNavigationState else nil
        end
        local var1, var2 = Signals.createSignal((read()))

        local connection = if arg1.changed == nil then nil else arg1.changed:connect(function()
            var2((read()))
        end)

        return (createNavigationHandle(var1, arg2, function()
            if connection ~= nil then
                connection:disconnect()
            end
        end))
    end
}
