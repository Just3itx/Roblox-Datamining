-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local tbl1 = { _initialized = false, _isKeyboardJustOff = false }

function tbl1:getInstance()
    if not self._initialized then
        self:initialize()
        self._initialized = true
    end
    return self
end

function tbl1.initialize(arg1)
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
end

function tbl1.isKeyboardJustOff(arg1)
    return arg1._isKeyboardJustOff
end

return {
    getInstance = function()
        return tbl1:getInstance()
    end
}
