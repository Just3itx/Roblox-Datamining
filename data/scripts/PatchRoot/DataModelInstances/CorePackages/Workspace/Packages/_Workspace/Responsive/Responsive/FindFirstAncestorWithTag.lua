-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
function FindFirstAncestorWithTag(arg1, str1: string)
    if arg1 == nil then
        return nil
    elseif arg1:HasTag(str1) then
        return arg1
    end
    return FindFirstAncestorWithTag(arg1.Parent, str1)
end

return FindFirstAncestorWithTag
