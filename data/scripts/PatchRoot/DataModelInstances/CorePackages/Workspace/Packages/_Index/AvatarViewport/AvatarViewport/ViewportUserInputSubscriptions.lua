-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local module = {}

function module.connectInputChanged(func1: (...any) -> (...any)): RBXScriptConnection
    return UserInputService.InputChanged:Connect(func1)
end

function module.connectInputEnded(func1: (...any) -> (...any)): RBXScriptConnection
    return UserInputService.InputEnded:Connect(func1)
end

return module
