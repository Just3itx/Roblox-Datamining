-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local FoundationParent = game:GetService("CorePackages").Packages._Index.Foundation.Foundation.Parent

local React = require(FoundationParent.React)

local function isReturnKey(keyCode): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return keyCode == Enum.KeyCode.Return or keyCode == Enum.KeyCode.KeypadEnter
end

local function useComposerKeyboardConnections(tbl1)
    local var1 = React.useRef(false)
    local var2 = React.useRef(nil)

    local disconnect = React.useCallback(function()
        if var2.current then
            var2.current:Disconnect()
            var2.current = nil
        end
        var1.current = false
    end, {})

    local connect = React.useCallback(function()
        if not tbl1.enabled or var1.current then
            return
        end

        var2.current = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
            if isReturnKey(input.KeyCode) then
                tbl1.onReturnPressed(
                    gameProcessedEvent,
                    UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
                )
            end
        end)

        var1.current = true
    end, { tbl1.enabled, tbl1.onReturnPressed })

    React.useEffect(function()
        return function()
            disconnect()
        end
    end, { disconnect })

    return { connect = connect, disconnect = disconnect }
end

return useComposerKeyboardConnections
