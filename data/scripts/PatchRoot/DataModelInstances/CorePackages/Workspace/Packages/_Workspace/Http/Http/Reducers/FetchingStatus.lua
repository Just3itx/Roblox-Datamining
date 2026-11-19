-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Http = script:FindFirstAncestor("Http")
local HttpParent = Http.Parent

local UpdateFetchingStatus = require(Http.Actions).UpdateFetchingStatus
local BatchUpdateFetchingStatus = require(Http.Actions).BatchUpdateFetchingStatus
local Cryo = require(HttpParent.Cryo)

local function mapStatusToValue(fetchingStatuses)
    local result = ({})
    for _, value in pairs(fetchingStatuses) do
        local key = value.key
        local status = value.status

        if status == nil then
            status = Cryo.None
        end
        result[key] = status
    end

    return result
end

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == UpdateFetchingStatus.name then
        local key = arg2.key
        local status = arg2.status

        if status == nil then
            status = Cryo.None
        end

        arg1 = Cryo.Dictionary.join(arg1, { [key] = status })
    end

    if arg2.type == BatchUpdateFetchingStatus.name then
        local fetchingStatuses = arg2.fetchingStatuses
        arg1 = Cryo.Dictionary.join(arg1, (mapStatusToValue(fetchingStatuses)))
    end

    return arg1
end
