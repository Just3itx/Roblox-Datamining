-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local EventNames = require(SquadsCore.Analytics.EventNames)
local _SquadCoplayJoin = require(SquadsCore.Enums.SquadCoplayJoin)
local SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local FFlagEncodeSquadMembersUpdated = require(SquadsCore.Flags.FFlagEncodeSquadMembersUpdated)
local encodeSquadMembers = require(SquadsCore.Common.encodeSquadMembers)

local Cryo = require(SquadsCoreParent.Cryo)
local _RoduxSquads = require(SquadsCoreParent.RoduxSquads)

local var1 = not FFlagEncodeSquadMembersUpdated and function(input)
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)

    return if success then result else "[]"
end or require(SquadsCore.Common.encodeUserIds)

return function(partyId: string, tbl1, inExperience, partyCoplayEvent, callback: (...any) -> (...any))
    if inExperience ~= SquadLocationEnum.InExperience then
        return
    end

    local tbl2 = {}
    local tbl3 = {}
    for _, value in ipairs(tbl1) do
        tbl2[value.userId] = true
    end

    for _, player in Players:GetPlayers() do
        if tbl2[player.UserId] then
            table.insert(tbl3, player.UserId)
        end
    end

    local var2 = nil
    local var3, var4

    if FFlagEncodeSquadMembersUpdated then
        var3 = var1(tbl3)
        var4 = encodeSquadMembers(tbl1)
    else
        var2 = Cryo.List.map(tbl1, function(arg1)
            return arg1.userId
        end)

        var3 = var1(tbl3)
        var4 = var1(var2)
    end

    callback(EventNames.PartyCoplay, {
        partyCoplayEvent = partyCoplayEvent,
        partyId = partyId,
        partyPlayersInGameInstanceCount = #tbl3,
        partyPlayersInGameInstanceUserIds = var3,
        partyTotalSize = FFlagEncodeSquadMembersUpdated and #tbl1 or #var2,
        partyTotalSizeUserIds = var4
    })
end
