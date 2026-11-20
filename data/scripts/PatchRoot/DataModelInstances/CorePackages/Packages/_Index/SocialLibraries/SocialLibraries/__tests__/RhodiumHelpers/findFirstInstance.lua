-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getProperty(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return arg1[arg2]
    end)

    return success == true and result or nil
end

local function propertyMatch(arg1, arg2)
    for k, value in pairs(arg2) do
        if getProperty(arg1, k) ~= value then
            return false
        end
    end

    return true
end

local function findFirstInstance(arg1, arg2)
    for _, descendant in ipairs(arg1:GetDescendants()) do
        if propertyMatch(descendant, arg2) then
            return descendant
        end
    end

    return nil
end

return findFirstInstance
