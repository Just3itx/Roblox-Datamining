-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url

local tbl1 = {}
local rootPlaceId = nil

local TeleportToPurchasedVIPServer = Instance.new("RemoteEvent")
TeleportToPurchasedVIPServer.Name = "TeleportToPurchasedVIPServer"
TeleportToPurchasedVIPServer.Parent = RobloxReplicatedStorage

local function getRootPlaceId()
    if rootPlaceId == nil then
        local asyncFullUrl = HttpRbxApiService:GetAsyncFullUrl(
            `{Url.DEVELOP_URL}v1/universes/{game.GameId}`,
            Enum.ThrottlingPriority.Default,
            Enum.HttpRequestType.Default
        )
        local var1 = HttpService:JSONDecode(asyncFullUrl)
        if typeof(var1) ~= "table" or typeof(var1.rootPlaceId) ~= "number" then
            error("The universe response has no root place")
        end
        rootPlaceId = var1.rootPlaceId
    end
    return rootPlaceId
end

Players.PlayerRemoving:Connect(function(player: Player)
    tbl1[player.UserId] = nil
end)

TeleportToPurchasedVIPServer.OnServerEvent:Connect(function(player: Player, arguments)
    local var1 = (tbl1[player.UserId] or 0) + 1
    tbl1[player.UserId] = var1

    if var1 > 3 or typeof(arguments) ~= "string" or #arguments == 0 or #arguments > 64 then
        TeleportToPurchasedVIPServer:FireClient(player)
        return
    end

    if not pcall(function()
        local teleportOptions = Instance.new("TeleportOptions")
        teleportOptions.VipServerId = arguments
        TeleportService:TeleportAsync(getRootPlaceId(), { player }, teleportOptions)
    end) then
        TeleportToPurchasedVIPServer:FireClient(player)
    end
end)
