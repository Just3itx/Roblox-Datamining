-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetService = game:GetService("AssetService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local var1 = nil
local tbl1 = {}

local BuildExperiencePlaytestTeleport = Instance.new("RemoteEvent")
BuildExperiencePlaytestTeleport.Name = "BuildExperiencePlaytestTeleport"
BuildExperiencePlaytestTeleport.Parent = RobloxReplicatedStorage

Players.PlayerRemoving:Connect(function(player: Player)
    tbl1[player.UserId] = nil
end)

local function getCurrentExperiencePlaceIds()
    if var1 ~= nil then
        return var1
    end

    local gamePlacesAsync = AssetService:GetGamePlacesAsync()
    local tbl2 = {}

    while true do
        for _, value in gamePlacesAsync:GetCurrentPage() do
            tbl2[value.PlaceId] = true
        end

        if gamePlacesAsync.IsFinished then
            var1 = tbl2
            return tbl2
        end

        gamePlacesAsync:AdvanceToNextPageAsync()
    end
end
BuildExperiencePlaytestTeleport.OnServerEvent:Connect(function(player: Player, arguments)
    local var2 = tbl1[player.UserId]
    if var2 ~= nil and var2 > 5 then
        return
    end
    if var2 == nil then
        tbl1[player.UserId] = 1
    else
        tbl1[player.UserId] = var2 + 1
    end

    if not player:GetCanManageAsync()
        or typeof(arguments) ~= "number"
        or arguments <= 0
        or game.PlaceId ~= arguments and not getCurrentExperiencePlaceIds()[arguments]
    then
        return
    end

    local teleportOptions = Instance.new("TeleportOptions")
    teleportOptions.ReservedServerId = HttpService:GenerateGUID(false)
    TeleportService:TeleportAsync(arguments, { player }, teleportOptions)
end)
