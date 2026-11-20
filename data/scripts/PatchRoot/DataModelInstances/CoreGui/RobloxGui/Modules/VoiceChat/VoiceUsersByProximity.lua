-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _VoiceChatServiceManager = require(script.Parent.VoiceChatServiceManager)

local function getPlayerPrimaryPart(arg1) -- Luacid: Inlined by compiler; 11 call sites recovered
    return arg1 and arg1.Character and arg1.Character.PrimaryPart
end

local function getPlayerDistanceFrom(arg1, vec1: vector) -- Luacid: Inlined by compiler; 5 call sites recovered
    local playerPrimaryPart = getPlayerPrimaryPart(arg1)
    return if playerPrimaryPart then (playerPrimaryPart.Position - vec1).Magnitude else nil
end

local function getComparator(vec1: vector) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1, arg2): boolean
        local playerPrimaryPart = getPlayerPrimaryPart(arg1)
        local playerPrimaryPart2 = getPlayerPrimaryPart(arg2)

        if not (playerPrimaryPart or playerPrimaryPart2) then
            return arg1.Name:lower() < arg2.Name:lower()
        end

        if playerPrimaryPart and not playerPrimaryPart2 then
            return true
        end

        if playerPrimaryPart or not playerPrimaryPart2 then
            return getPlayerDistanceFrom(arg1, vec1) < getPlayerDistanceFrom(arg2, vec1)
        end

        return false
    end
end

return {
    getComparator = getComparator,
    getSortedPlayers = function(arg1, arg2, vec1: vector, num1: number?, bool1: boolean?, arg3, bool2: boolean?)
        local sortedPlayers = {}
        local comparator = getComparator(vec1)

        for k, _ in pairs(arg2.participants) do
            local playerByUserId = arg1:GetPlayerByUserId(k)

            if playerByUserId
                and arg3 ~= playerByUserId
                and (bool2 or getPlayerPrimaryPart(playerByUserId))
                and not (num1 and playerByUserId and num1 < getPlayerDistanceFrom(playerByUserId, vec1))
                and (not bool1 or arg2:getRecentUsersInteractionData()[tostring(playerByUserId.UserId)])
            then
                table.insert(sortedPlayers, playerByUserId)
            end
        end
        table.sort(sortedPlayers, comparator)

        return sortedPlayers
    end
}
