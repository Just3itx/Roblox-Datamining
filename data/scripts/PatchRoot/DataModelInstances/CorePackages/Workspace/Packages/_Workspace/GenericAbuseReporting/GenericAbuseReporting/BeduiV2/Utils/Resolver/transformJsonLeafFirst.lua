-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")

local _Types = require(GenericAbuseReporting.BeduiV2.Types)

local function transformJsonLeafFirst(arg1, func1: (...any) -> (...any))
    if type(arg1) ~= "table" then
        return func1(arg1)
    end

    local bool1 = false
    for k, _ in pairs(arg1) do
        if type(k) ~= "number" then
            bool1 = false
            break
        end

        bool1 = true
    end

    if not bool1 then
        local tbl1 = ({})
        for k, value in pairs(arg1) do
            tbl1[k] = transformJsonLeafFirst(value, func1)
        end
        return func1(tbl1)
    end

    local tbl1 = {}
    for _, value in ipairs(arg1) do
        local var1 = transformJsonLeafFirst(value, func1)
        if var1 ~= nil then
            table.insert(tbl1, var1)
        end
    end
    return func1(tbl1)
end

return transformJsonLeafFirst
