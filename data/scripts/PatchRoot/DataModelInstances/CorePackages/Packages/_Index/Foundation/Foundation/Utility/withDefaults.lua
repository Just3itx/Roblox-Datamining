-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local Dash = require(FoundationParent.Dash)
local ReactIs = require(FoundationParent.ReactIs)

local function isTableNotBinding(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return type(arg1) == "table" and not ReactIs.isBinding(arg1)
end

local function deepJoin(arg1, arg2)
    local var1 = table.clone(arg1)
    for value, value2 in arg2 do
        if isTableNotBinding(value2) and isTableNotBinding(var1[value]) then
            var1[value] = deepJoin(var1[value], value2)
        else
            var1[value] = value2
        end
    end
    return var1
end

local function withDefaults(arg1, arg2)
    local tbl1 = ({})

    if type(arg1) == "table" and type(arg2) == "table" then
        for value, _ in arg2 do
            tbl1[value] = arg1[value]
        end
    end

    local var1 = deepJoin(arg2, tbl1)

    return (Dash.union(arg1, var1))
end

return withDefaults
