-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function findLocalTextSource(arg1, str1: string?)
    if arg1 == nil or str1 == nil then
        return nil
    end
    for _, child in arg1:GetChildren() do
        if child:IsA("TextSource") and tostring(child.UserId) == str1 then
            return child
        end
    end
    return nil
end

return findLocalTextSource
