-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)
local _GoodSignal = require(ReactUtilsParent.GoodSignal)

local function useEventConnection(rbxScriptSignal, func1: (...any) -> (...any), tbl1)
    local var1 = React.useMemo(function()
        return func1
    end, tbl1)

    React.useEffect(function()
        if rbxScriptSignal == nil then
            return nil
        elseif typeof(rbxScriptSignal) == "RBXScriptSignal" then
            local connection = rbxScriptSignal:Connect(var1)

            return function()
                connection:Disconnect()
            end
        else
            local connection = rbxScriptSignal:Connect(var1)

            return function()
                connection:Disconnect()
            end
        end
    end, { rbxScriptSignal, var1 })
end

return useEventConnection
