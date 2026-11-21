-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)

local function useLatestUsername<T>(arg1: T, arg2: T, current: ((...any) -> (...any))?)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(false)

    local var3 = React.useRef(current)
    var3.current = current

    React.useEffect(function()
        if arg2 == nil then
            return nil
        end
        local effect = Signals.createEffect(function(arg3) -- name: onLatestIdChanged
            local var4 = arg1(arg3)
            local bool1 = not (var4 == nil) and var4 == arg2(arg3)
            local current = var2.current
            var2.current = bool1

            local current2 = var3.current
            if current2 == nil then
                return
            end
            if bool1 and not current then
                current2(var1.current)
            end
        end)

        return function()
            effect()
            if not var2.current then
                return
            end

            var2.current = false
            local current = var3.current
            if current ~= nil then
                current(nil)
            end
        end
    end, { arg1, arg2 })

    local var4 = React.useRef(current)
    React.useEffect(function()
        local current2 = var4.current
        var4.current = current
        if current2 == current or not var2.current then
            return
        end
        if current2 ~= nil then
            current2(nil)
        end
        if current ~= nil then
            current(var1.current)
        end
    end, { current })

    return (React.useCallback(function(current3)
        var1.current = current3
        local current2 = var3.current
        if var2.current and current2 ~= nil then
            current2(current3)
        end
    end, {}))
end

return useLatestUsername
