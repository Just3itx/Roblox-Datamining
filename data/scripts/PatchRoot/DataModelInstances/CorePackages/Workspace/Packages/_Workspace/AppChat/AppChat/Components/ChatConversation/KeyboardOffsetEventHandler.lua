-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local UserInputService = game:GetService("UserInputService")

local usePositionOffsetForVirtualKeyboard = require(AppChat.Hooks.usePositionOffsetForVirtualKeyboard)

local React = require(AppChatParent.React)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

return function(tbl1)
    local var1 = useSelector(function(arg1)
        return if arg1.GlobalGuiInset then arg1.GlobalGuiInset.top else 0
    end)

    local current = if tbl1.parentViewRef then tbl1.parentViewRef.current else nil
    local var2 = usePositionOffsetForVirtualKeyboard({ isNearBottomOfScreen = true })
    local var3 = React.useCallback(function()
        local num1 = 0
        if UserInputService.OnScreenKeyboardVisible then
            if var2 ~= nil then
                num1 = var2
            elseif current then
                num1 = current.AbsolutePosition.Y + current.AbsoluteSize.Y - (UserInputService.OnScreenKeyboardPosition.Y - var1)
            end
        end

        if tbl1.onKeyboardOffsetChanged then
            tbl1.onKeyboardOffsetChanged(num1)
        end
    end, {
        var2,
        var1,
        tbl1.onKeyboardOffsetChanged,
        current
    })
    React.useEffect(function()
        var3()
        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(var3)
        local connection2 = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardPosition"):Connect(var3)

        local connection3 = if current then current:GetPropertyChangedSignal("AbsoluteSize"):Connect(var3) else nil

        return function()
            if connection then
                connection:Disconnect()
            end

            if connection2 then
                connection2:Disconnect()
            end

            if connection3 then
                connection3:Disconnect()
            end
        end
    end, { var3, current })

    return nil
end
