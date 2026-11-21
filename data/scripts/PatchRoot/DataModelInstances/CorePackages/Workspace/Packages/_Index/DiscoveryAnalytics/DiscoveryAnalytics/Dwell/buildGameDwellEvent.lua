-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _DwellTracker = require(script.Parent.DwellTracker)
local _GameDwellItem = require(script.Parent.GameDwellItem)

local function viewArrays()
    return {
        universeIds = {},
        viewUuids = {},
        absPositions = {},
        topicDataPositions = {},
        rowsOnPage = {},
        itemComponentTypes = {},
        adFlags = {},
        sampledStartTimestampsMs = {},
        precedingScanGapsMs = {},
        positionsInRows = {},
        rows = {}
    }
end

local function appendView(tbl1, arg1)
    local item = arg1.item
    table.insert(tbl1.universeIds, tostring(item.universeId))
    table.insert(tbl1.viewUuids, arg1.uuid)
    table.insert(tbl1.absPositions, tostring(item.cell))
    table.insert(tbl1.topicDataPositions, tostring(item.rank))
    table.insert(tbl1.rowsOnPage, tostring(item.rowOnPage))
    table.insert(tbl1.itemComponentTypes, item.componentType)
    table.insert(tbl1.adFlags, tostring(item.adFlag))
    table.insert(tbl1.sampledStartTimestampsMs, tostring(arg1.startTimestamp))
    table.insert(tbl1.precedingScanGapsMs, tostring(arg1.precedingGap))
    table.insert(tbl1.positionsInRows, tostring(item.positionInRow))
    table.insert(tbl1.rows, tostring(item.row))
end

local function join(tbl1, tbl2)
    local var1 = table.clone(tbl1)
    for value, value2 in tbl2 do
        var1[value] = table.concat(value2, ",")
    end
    return var1
end

return {
    starts = function(tbl1, tbl2)
        local tbl3 = viewArrays()
        for _, value in tbl2 do
            appendView(tbl3, value)
        end
        return (join(tbl1, tbl3))
    end,
    ends = function(tbl1, tbl2)
        local tbl3 = viewArrays()
        tbl3.sampledEndTimestampsMs = {}
        tbl3.dwellTimesMs = {}
        tbl3.lastPresentOffsetsMs = {}
        tbl3.visibleSampleCounts = {}
        tbl3.maxObservationGapsMs = {}
        tbl3.endReasons = {}
        for _, value in tbl2 do
            local view = value.view
            appendView(tbl3, view)
            table.insert(tbl3.sampledEndTimestampsMs, tostring(value.timestamp))
            table.insert(tbl3.dwellTimesMs, tostring(value.duration))
            table.insert(tbl3.lastPresentOffsetsMs, tostring(view.lastPresent - view.start))
            table.insert(tbl3.visibleSampleCounts, tostring(view.count))
            table.insert(tbl3.maxObservationGapsMs, tostring(view.maxGap))
            table.insert(tbl3.endReasons, value.reason)
        end
        return (join(tbl1, tbl3))
    end
}
