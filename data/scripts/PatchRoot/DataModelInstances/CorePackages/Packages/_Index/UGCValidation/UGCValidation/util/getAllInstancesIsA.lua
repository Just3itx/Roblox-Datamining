-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, str1: string)
    local success, _result = pcall(Instance.new, str1)
    assert(success, `{str1} does not exist. Did you make a typo?`)

    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)

    local result = {}
    for _, descendant in descendants do
        if descendant:IsA(str1) then
            table.insert(result, descendant)
        end
    end

    return result
end
