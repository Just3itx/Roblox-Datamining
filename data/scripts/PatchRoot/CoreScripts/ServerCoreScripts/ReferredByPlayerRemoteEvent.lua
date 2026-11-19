-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")

if not require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableReferredPlayerJoinRemoteEvent() then
    return
end

local referredPlayerJoin = Instance.new("RemoteEvent")
referredPlayerJoin.Name = "ReferredPlayerJoin"
referredPlayerJoin.Parent = RobloxReplicatedStorage

Players.PlayerAdded:Connect(function(player: Player)
    local joinData = player:GetJoinData()
    joinData = joinData and tonumber(joinData.ReferredByPlayerId)
    if not joinData or joinData == 0 then
        return
    end

    local player2 = Players:GetPlayerByUserId(joinData)
    if player2 then
        referredPlayerJoin:FireClient(player2, player)
    end
end)
