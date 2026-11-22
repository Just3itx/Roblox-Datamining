-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    if arg1.Parent == nil then
        return false
    end

    while arg1 ~= nil do
        if arg1:IsA("GuiObject") and not arg1.Visible then
            return false
        end
        arg1 = arg1.Parent
    end
    return true
end
