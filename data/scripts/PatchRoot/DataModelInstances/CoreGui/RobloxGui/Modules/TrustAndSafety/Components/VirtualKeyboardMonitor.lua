-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local tbl1 = {
    getInstance = function(arg1)
        if not arg1._initialized then
            arg1:initialize()
            arg1._initialized = true
        end
        return arg1
    end,
    initialize = function(arg1)
        arg1._isKeyboardJustOff = false
        UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(function()
            if not UserInputService.OnScreenKeyboardVisible then
                arg1._isKeyboardJustOff = true
            end
        end)
        UserInputService.InputEnded:Connect(function(_inputObject: InputObject)
            if arg1._isKeyboardJustOff then
                arg1._isKeyboardJustOff = false
            end
        end)
    end,
    isKeyboardJustOff = function(arg1)
        return arg1._isKeyboardJustOff
    end
}
return {
    getInstance = function()
        return tbl1:getInstance()
    end
}
