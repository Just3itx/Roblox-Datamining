-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Signals = require(scriptParentParentParent.Signals)

local _LeaderboardStore = require(scriptParentParentParent.LeaderboardStore)

local function getSortedPlayerInstances(tbl1)
    local sortedPlayerInstances = {}

    for _, value in tbl1 do
        for _, playerInstance in value.players do
            table.insert(sortedPlayerInstances, {
                teamId = value.teamId,
                teamOrder = value.order(false),
                playerOrder = playerInstance.order(false),
                playerInstance = playerInstance
            })
        end
    end

    table.sort(sortedPlayerInstances, function(arg1, arg2): boolean
        if arg1.teamOrder == arg2.teamOrder then
            return arg1.playerOrder < arg2.playerOrder
        end

        return arg1.teamOrder < arg2.teamOrder
    end)

    return sortedPlayerInstances
end

return {
    getNextPlayerInstance = function(tbl1, tbl2, teamId)
        local sortedPlayerInstances = getSortedPlayerInstances(tbl1)
        local playerInstance = nil

        for value, value2 in sortedPlayerInstances do
            if value2.playerInstance.userId ~= tbl2.userId then
                continue
            end

            if value2.playerInstance.object ~= tbl2.object then
                return value2.playerInstance
            end

            local var1 = if value - 1 > 0 then sortedPlayerInstances[value - 1] else nil
            local var2 = if value + 1 <= #sortedPlayerInstances then sortedPlayerInstances[value + 1] else nil

            if var2 then
                if var2.teamId == teamId or not var1 or var1.teamId ~= teamId then
                    playerInstance = var2.playerInstance
                else
                    playerInstance = var1.playerInstance
                end
            elseif var1 then
                playerInstance = var1.playerInstance
            end
        end

        return playerInstance
    end,
    getFirstPlayerInstance = function(tbl1)
        local var1 = nil
        local huge = math.huge

        for _, value in tbl1 do
            if not next(value.players) then
                continue
            end

            local var2 = value.order(false)
            if var1 and huge < var2 then
                continue
            end

            for _, player in value.players do
                if not var1 or player.order(false) < var1.order(false) then
                    huge = var2
                    var1 = player
                end
            end
        end

        return var1
    end
}
