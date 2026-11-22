-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function createCreationToolRegistry(tbl1)
    local tbl2 = {}
    local tbl3 = {}

    local function rebuildOrdered()
        tbl3 = {}
        for _, value in tbl2 do
            table.insert(tbl3, value)
        end
        table.sort(tbl3, function(arg1, arg2): boolean
            return (arg1.cta.order or 0) < (arg2.cta.order or 0)
        end)
    end

    local function register(tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
        for _, value in tbl4 do
            tbl2[value.kind] = value
        end
        rebuildOrdered()
    end

    local function get(str1: string)
        return tbl2[str1]
    end

    local function getAll()
        return tbl3
    end

    if tbl1 ~= nil then
        register(tbl1)
    end

    return { register = register, get = get, getAll = getAll }
end

return createCreationToolRegistry
