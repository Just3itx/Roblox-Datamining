-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isWirable(arg1): boolean
    return (pcall(function()
        local var1 = arg1
        var1:GetInputPins()
        var1:GetOutputPins()
        var1:GetConnectedWires("Foo")
    end))
end
return isWirable
