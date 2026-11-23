-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.Parent.Stores.types)

local FFlagDebugTimeToInteractiveTracker = require(script.Parent.FFlagDebugTimeToInteractiveTracker)

local function formatPayload(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return ""
    elseif type(arg1) ~= "table" then
        return tostring(arg1)
    else
        local success, result = pcall(function(): string
            return HttpService:JSONEncode(arg1)
        end)
        if success then
            return result
        end

        return tostring(arg1)
    end
end

local function formatMilestones(tbl1): string
    if not tbl1 or #tbl1 == 0 then
        return ""
    end

    local tbl2 = {}
    for _, value in tbl1 do
        local str1 = if value.totalMemoryMB or value.luaHeapMB then (" [mem: total=%.1fMB lua=%.1fMB]"):format(value.totalMemoryMB or 0, value.luaHeapMB or 0) else ""

        local name = value.name
        local deltaMs = value.deltaMs
        table.insert(tbl2, ("  %s %.0fms%s"):format(name, deltaMs, str1))

        if value.subphases then
            for _, value2 in value.subphases do
                local name2 = value2.name
                local deltaMs2 = value2.deltaMs or 0
                table.insert(tbl2, ("    -> %s %.0fms"):format(name2, deltaMs2))
            end
        end
        if not value.requests then
            continue
        end

        for _, request in value.requests do
            local name2 = request.name
            local deltaMs2 = request.deltaMs or 0
            table.insert(tbl2, ("    -> [req] %s %.0fms"):format(name2, deltaMs2))
        end
    end

    return "\n" .. table.concat(tbl2, "\n")
end

return function(str1: string, str2: string, num1: number?, arg1, tbl1)
    if not FFlagDebugTimeToInteractiveTracker then
        return
    end

    local str3 = ("[TimeToInteractiveTracker][%s]"):format(str1)
    local var1 = formatPayload(arg1)
    local tbl2 = { str3, str2 }
    if num1 ~= nil then
        table.insert(tbl2, ("%.0fms"):format(num1))
    end
    if var1 ~= "" then
        table.insert(tbl2, var1)
    end

    local str4 = formatMilestones(tbl1)
    if str4 ~= "" then
        table.insert(tbl2, str4)
    end

    print(table.unpack(tbl2))
end
