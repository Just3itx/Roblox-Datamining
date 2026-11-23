-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EventNames = require(script.Parent.EventNames)
local getTileRowInSort = require(script.Parent.getTileRowInSort)

return function(tbl1, callback: (...any) -> (...any))
    local impressions = tbl1.impressions
    local entries = tbl1.entries
    local startRowNumber = tbl1.startRowNumber
    local itemsPerRow = tbl1.itemsPerRow

    if not entries then
        return
    end

    local tilePos = {}
    local playerId = {}
    local playerName = {}
    local rowInSort = {}

    for i = 1, #impressions do
        local impression = impressions[i]
        local var1 = entries[impression]

        if var1 then
            table.insert(tilePos, impression)
            table.insert(playerId, var1.id)
            table.insert(playerName, var1.name)

            table.insert(rowInSort, (getTileRowInSort(impression, startRowNumber, itemsPerRow)))
        end
    end

    callback(
        EventNames.PlayerTileImpressions,
        { tilePos = tilePos, playerId = playerId, playerName = playerName, rowInSort = rowInSort }
    )
end
