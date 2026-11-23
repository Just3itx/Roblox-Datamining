-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)

local function useInputConnections(tbl1)
    local var1 = React.useRef(false)
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)

    local disconnectInputConnection = React.useCallback(function()
        if var2.current then
            var2.current:Disconnect()
            var2.current = nil
        end
        if var3.current then
            var3.current:Disconnect()
            var3.current = nil
        end
        var1.current = false
    end, {})

    local focusChanged = React.useCallback(function(arg1)
        if arg1 and not var1.current then
            var2.current = tbl1.userInputService.InputBegan:Connect(tbl1.onInputBegan)
            var3.current = tbl1.userInputService.InputEnded:Connect(tbl1.onInputEnded)
            var1.current = true
        elseif not arg1 and var1.current then
            disconnectInputConnection()
            if tbl1.onFocusLost then
                tbl1.onFocusLost()
            end
        end
    end, {
        tbl1.onInputBegan,
        tbl1.onInputEnded,
        disconnectInputConnection,
        tbl1.onFocusLost
    })

    React.useEffect(function()
        return function()
            if var1.current then
                disconnectInputConnection()
            end
        end
    end, { disconnectInputConnection })

    return { focusChanged = focusChanged, disconnectInputConnection = disconnectInputConnection }
end

return useInputConnections
