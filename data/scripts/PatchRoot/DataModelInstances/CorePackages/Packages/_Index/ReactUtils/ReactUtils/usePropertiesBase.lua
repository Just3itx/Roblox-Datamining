-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)
local Array = require(ReactUtilsParent.LuauPolyfill).Array

local useForwardRef = require(script.Parent.useForwardRef)

local function usePropertiesBase(arg1, func1: (...any) -> (...any), bool1: boolean, ...)
    local var1 = Array.concat({}, ...)
    local var2 = React.useCallback(function(arg2)
        local function onPropChange() -- Luacid: Inlined by compiler; 2 call sites recovered
            local func2 = func1
            local map = Array.map

            func2(table.unpack(map(var1, function(arg3)
                return arg2[arg3]
            end)))
        end
        local var2 = nil
        local function func2()
            var2 = var2 or task.defer(function()
                var2 = nil
                onPropChange()
            end)
        end

        local var3 = Array.map(var1, function(arg3)
            local var3 = arg2:GetPropertyChangedSignal(arg3)
            local func3 = if bool1 then func2 else onPropChange
            return var3:Connect(func3)
        end)

        onPropChange()

        return function()
            for _, value in var3 do
                value:Disconnect()
            end
            if var2 then
                task.cancel(var2)
            end
        end
    end, { func1, table.concat(var1, ",") })
    return useForwardRef(arg1, var2)
end

return usePropertiesBase
