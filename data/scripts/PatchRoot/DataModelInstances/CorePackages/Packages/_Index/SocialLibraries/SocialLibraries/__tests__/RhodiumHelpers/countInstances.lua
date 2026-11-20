-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2): number
    local num1 = 0

    for _, child in pairs(arg1:GetChildren()) do
        if not arg2 or child:IsA(arg2) then
            num1 += 1
        end
    end

    return num1
end
