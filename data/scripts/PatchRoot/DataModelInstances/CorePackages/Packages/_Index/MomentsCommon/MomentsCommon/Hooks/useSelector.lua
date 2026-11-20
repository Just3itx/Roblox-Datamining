-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local React = require(MomentsCommonParent.React)

local useStore = require(script.Parent.useStore)

local function func1(arg1, arg2): boolean
    return arg1 == arg2
end

function useSelectorWithStore(current: (...any) -> (...any), func2: (...any) -> (...any), arg1)
    local _, var1 = React.useReducer(function(num1: number): number
        return num1 + 1
    end, 0)

    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(nil)

    local state = arg1:getState()
    local var6 = nil

    local success, result = pcall(function()
        if current == var3.current and state == var4.current and not var2.current then
            var6 = var5.current

            return
        end

        local var7 = current(state)

        if var5.current == nil or not func2(var7, var5.current) then
            var6 = var7
            return
        end
        var6 = var5.current
    end)
    if not success then
        if var2.current then
            result = string.format(
                "%s\nThe error may be correlated with this previous error:\n%s\n\n",
                tostring(result),
                tostring(var2.current)
            )
        end

        error(result)
    end

    React.useLayoutEffect(function()
        var3.current = current
        var4.current = state
        var5.current = var6
        var2.current = nil
    end)

    React.useLayoutEffect(function()
        local function checkForUpdates(current2) -- Luacid: Inlined by compiler; 1 call site recovered
            local success2, result2 = pcall(function(): boolean
                if current2 == var4.current then
                    return false
                end

                assert(var3.current, "latestSelector")
                local var7 = var3.current(current2)

                if func2(var7, var5.current) then
                    return false
                end

                var5.current = var7
                var4.current = current2
                return true
            end)
            if not success2 then
                result2 = result2 or "Error"

                var2.current = result2
            end

            if result2 then
                var1(nil)
            end
        end
        local connection = arg1.changed:connect(checkForUpdates)

        checkForUpdates((arg1:getState()))

        return function()
            connection.disconnect()
        end
    end, { arg1 })

    return var6
end

function useSelector(func2: (...any) -> (...any), func3: ((...any) -> (...any))?)
    local var1 = func3 or func1

    local var2 = useStore()

    return (useSelectorWithStore(func2, var1, var2))
end

return useSelector
