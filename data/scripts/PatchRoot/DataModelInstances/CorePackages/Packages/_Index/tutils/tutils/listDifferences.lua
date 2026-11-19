-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tableDifference = require(script.Parent.tableDifference)

local function membershipTable(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local result = {}
    for i = 1, #arg1 do
        result[arg1[i]] = true
    end
    return result
end

local function listOfKeys(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}
    for k, _ in pairs(arg1) do
        table.insert(result, k)
    end
    return result
end

return function(arg1, arg2)
    return listOfKeys((tableDifference(membershipTable(arg1), (membershipTable(arg2)))))
end
