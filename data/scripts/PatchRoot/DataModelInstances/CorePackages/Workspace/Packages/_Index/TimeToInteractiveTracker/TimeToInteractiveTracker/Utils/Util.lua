-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local _types = require(TimeToInteractiveTracker.Stores.types)

local _types2 = require(TimeToInteractiveTracker.Milestones.types)

local FFlagTTITrackerMemoryTracking = require(script.Parent.FFlagTTITrackerMemoryTracking)

local tbl1 = ({})
local tbl2 = ({})

for _, value in (require(TimeToInteractiveTracker.Milestones.constants)) do
    if type(value) == "string" then
        tbl1[value] = true
    else
        tbl1[value.Name] = true
        for _, value2 in value.Subphase do
            tbl2[value2] = true
        end
    end
end

local function sanitizeIdSegment(id: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return id:gsub("[^%w_%-]", "_"):sub(1, 40)
end

local module = {}

function module.findLastMilestoneIndex(tbl3, name)
    for i = #tbl3, 1, -1 do
        if tbl3[i].name == name then
            return i
        end
    end
    return nil
end

function module.deepCloneMilestones(tbl3)
    local var1 = table.clone(tbl3)
    for value, value2 in var1 do
        local var2 = table.clone(value2)
        if var2.subphases then
            local subphases = table.clone(var2.subphases)
            for value3, value4 in subphases do
                subphases[value3] = table.clone(value4)
            end
            var2.subphases = subphases
        end
        if var2.requests then
            local requests = table.clone(var2.requests)
            for value3, value4 in requests do
                requests[value3] = table.clone(value4)
            end
            var2.requests = requests
        end
        var1[value] = var2
    end
    return var1
end

function module.encodeMilestonesJSON(input)
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    return if success then result else nil
end

function module.milestonesToProto(tbl3)
    local result = {}
    for _, value in tbl3 do
        local tbl4 = {
            name = value.name,
            timestamp_seconds = value.timestamp,
            delta_ms = value.deltaMs,
            total_memory_mb = value.totalMemoryMB,
            lua_heap_mb = value.luaHeapMB
        }
        if value.id then
            tbl4.id = value.id
        end
        if value.subphases then
            local subphases = {}
            for _, value2 in value.subphases do
                table.insert(subphases, { name = value2.name, timestamp_seconds = value2.timestamp, delta_ms = value2.deltaMs or 0 })
            end

            tbl4.subphases = subphases
        end
        if value.requests then
            local requests = {}
            for _, request in value.requests do
                table.insert(requests, { name = request.name, timestamp_seconds = request.timestamp, delta_ms = request.deltaMs or 0 })
            end

            tbl4.requests = requests
        end
        table.insert(result, tbl4)
    end
    return result
end

function module.generateMilestoneStats(str1: string, tbl3)
    local result = {}

    for _, value in tbl3 do
        local eventName = str1 .. "_" .. (if value.id then value.name .. "__" .. value.id else value.name)

        local tbl4 = {
            eventName = eventName,
            deltaMs = value.deltaMs
        }
        if FFlagTTITrackerMemoryTracking then
            tbl4.totalMemoryMB = value.totalMemoryMB
            tbl4.luaHeapMB = value.luaHeapMB
        end
        table.insert(result, tbl4)

        if value.subphases then
            for _, value2 in value.subphases do
                table.insert(result, { eventName = eventName .. "_sp_" .. value2.name, deltaMs = value2.deltaMs or 0 })
            end
        end

        if not value.requests then
            continue
        end

        for _, request in value.requests do
            table.insert(result, { eventName = eventName .. "_rq_" .. request.name, deltaMs = request.deltaMs or 0 })
        end
    end

    return result
end

function module.milestonesToPointsFields(tbl3)
    local result = ({})
    for _, value in tbl3 do
        if not tbl1[value.name] then
            continue
        end

        local var1 = if value.id == nil or value.id == "" then "" else "__" .. sanitizeIdSegment(value.id)
        local var2 = "ms_" .. value.name .. var1
        result[var2] = value.deltaMs
        if FFlagTTITrackerMemoryTracking then
            if value.totalMemoryMB then
                result[var2 .. "_total_memory_mb"] = value.totalMemoryMB
            end
            if value.luaHeapMB then
                result[var2 .. "_lua_heap_mb"] = value.luaHeapMB
            end
        end
        if not value.subphases then
            continue
        end

        for _, value2 in value.subphases do
            if tbl2[value2.name] then
                result[var2 .. "_sp_" .. value2.name] = value2.deltaMs or 0
            end
        end
    end

    return result
end

return module
