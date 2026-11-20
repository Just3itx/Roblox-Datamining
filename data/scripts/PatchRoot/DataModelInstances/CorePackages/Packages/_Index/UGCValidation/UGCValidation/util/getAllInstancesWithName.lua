-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, name: string)
    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)

    local result = {}
    for _, descendant in descendants do
        if descendant.Name == name then
            table.insert(result, descendant)
        end
    end

    return result
end
