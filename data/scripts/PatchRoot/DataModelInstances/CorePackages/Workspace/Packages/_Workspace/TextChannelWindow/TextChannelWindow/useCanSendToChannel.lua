-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local useEventConnection = require(scriptParentParent.ReactUtils).useEventConnection

local findLocalTextSource = require(script.Parent.findLocalTextSource)

return {
    useCanSendToChannel = function(str1: string?, str2: string?)
        local var1, var2 = React.useState(function()
            return findLocalTextSource(str1, str2)
        end)

        local var3 = React.useCallback(function()
            var2(findLocalTextSource(str1, str2))
        end, { str1, str2 })

        React.useEffect(var3, { var3 })

        useEventConnection(if str1 then str1.ChildAdded else nil, var3, { var3 })
        useEventConnection(if str1 then str1.ChildRemoved else nil, var3, { var3 })

        local function evaluateCanSend(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            if str1 == nil or str2 == nil then
                return true
            end
            return not (var1 == nil) and var1.CanSend
        end

        local var4, var5 = React.useState(evaluateCanSend)

        React.useEffect(function()
            var5((evaluateCanSend()))
        end, { str1, str2, var1 })

        local var6 = useEventConnection
        local canSendChanged = if var1 then var1:GetPropertyChangedSignal("CanSend") else nil

        var6(canSendChanged, function()
            var5((evaluateCanSend()))
        end, { str1, str2, var1 })

        return var4
    end
}
