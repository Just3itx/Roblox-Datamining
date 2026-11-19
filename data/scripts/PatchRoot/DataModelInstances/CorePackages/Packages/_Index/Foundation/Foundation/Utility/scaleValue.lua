-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function scaleValue(arg1, num1: number?)
    if num1 == nil then
        return arg1
    elseif typeof(arg1) == "number" then
        return arg1 * num1
    elseif typeof(arg1) == "UDim" then
        return UDim.new(arg1.Scale, arg1.Offset * num1)
    elseif typeof(arg1) == "UDim2" then
        return UDim2.new(arg1.X.Scale, arg1.X.Offset * num1, arg1.Y.Scale, arg1.Y.Offset * num1)
    end

    return arg1
end

return scaleValue
