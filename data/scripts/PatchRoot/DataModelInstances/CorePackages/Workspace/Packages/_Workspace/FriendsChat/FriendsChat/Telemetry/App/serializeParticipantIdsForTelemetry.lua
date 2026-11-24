-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function serializeParticipantIdsForTelemetry(tbl1, num1: number?)
    local input = {}
    for _, value in tbl1 or {} do
        if typeof(value) == "table" then
            value = value.id
        end

        local var1 = tonumber(value)
        if var1 ~= nil and var1 ~= num1 then
            table.insert(input, var1)
        end
    end

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    return if success then result else "[]"
end

return serializeParticipantIdsForTelemetry
