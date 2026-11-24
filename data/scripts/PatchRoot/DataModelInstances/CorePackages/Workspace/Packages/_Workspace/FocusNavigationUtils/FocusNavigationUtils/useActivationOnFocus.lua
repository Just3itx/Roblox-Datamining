-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent

local React = require(FocusNavigationUtilsParent.React)
local ReactFocusNavigation = require(FocusNavigationUtilsParent.ReactFocusNavigation)

local PendingActivationOnFocus = require(script.Parent.PendingActivationOnFocus)

local var1 = nil
local var2 = nil

local function useActivationOnFocus(bool1: boolean, tbl1, current: ((...any) -> (...any))?, current2: ((...any) -> (...any))?, current3: ((...any) -> (...any))?, bool2: boolean?, num1: number?)
    local bool3 = current ~= nil
    local bool4 = bool2 == true
    if num1 == nil or not (num1 > 0) then
        num1 = nil
    end

    local var3 = React.useRef(current)
    local var4 = React.useRef(current2)
    local var5 = React.useRef(current3)
    var3.current = current
    var4.current = current2
    var5.current = current3

    local var6 = React.useContext(ReactFocusNavigation.FocusNavigationContext)

    React.useEffect(function()
        if not (bool1 and bool3 and var6) then
            return function() end
        end

        local owner = {}

        local function getIdentity() -- Luacid: Inlined by compiler; 3 call sites recovered
            local current4 = var5.current
            if current4 then
                return (current4())
            end

            return nil
        end

        local function isAlreadyActivated(arg1, arg2): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
            local bool5 = not bool4
            return bool5 and var1 == arg1 and var2 == arg2
        end

        local function isOwnPendingActivation(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            local var7 = PendingActivationOnFocus.get()
            return not (var7 == nil) and var7.owner == owner
        end

        local function commitActivation(arg1, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
            if not bool4 then
                var1 = arg1
                var2 = arg2
            end
            local current4 = var3.current
            if current4 then
                current4()
            end
        end

        local var7 = var6.focusedGuiObject:subscribe(function(arg1)
            local current4 = tbl1.current
            local current5 = var4.current
            if current5 then
                current4 = current5(current4)
            end

            if current4 == nil or arg1 ~= current4 then
                if isOwnPendingActivation() then
                    if arg1 == nil then
                        PendingActivationOnFocus.cancel()
                        return
                    end

                    local var7 = PendingActivationOnFocus.get()
                    task.defer(function()
                        if PendingActivationOnFocus.get() == var7 then
                            PendingActivationOnFocus.flush()
                        end
                    end)
                end
                return
            end

            PendingActivationOnFocus.cancel()
            local identity = if bool4 then nil else getIdentity()

            if isAlreadyActivated(current4, identity) then
                return
            end

            if num1 == nil then
                commitActivation(current4, identity)
                return
            end

            local function activate()
                local identity2 = getIdentity()

                if isAlreadyActivated(current4, identity2) then
                    return nil
                end
                commitActivation(current4, identity2)
                return identity2
            end
            PendingActivationOnFocus.set({
                owner = owner,
                thread = task.delay(num1, function()
                    PendingActivationOnFocus.set(nil)
                    local identity2 = getIdentity()

                    if isAlreadyActivated(current4, identity2) then
                        return
                    end
                    commitActivation(current4, identity2)
                end),
                activate = activate
            })
        end)

        return function()
            var7:unsubscribe()

            if isOwnPendingActivation() then
                PendingActivationOnFocus.cancel()
            end
        end
    end, {
        bool1,
        bool3,
        bool4,
        num1,
        var6,
        tbl1
    })
end

return useActivationOnFocus
