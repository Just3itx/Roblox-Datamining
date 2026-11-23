-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    findFirstDescendant = function(arg1, str1: string, func1: ((...any) -> (...any))?)
        for _, descendant in arg1:GetDescendants() do
            if descendant:IsA(str1) and (func1 == nil or func1(descendant)) then
                return descendant
            end
        end
        return nil
    end,
    findAllDescendants = function(arg1, str1: string)
        local allDescendants = {}
        for _, descendant in arg1:GetDescendants() do
            if descendant:IsA(str1) then
                table.insert(allDescendants, descendant)
            end
        end
        return allDescendants
    end
}
