-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local SetDialogInUse = Instance.new("RemoteEvent")
SetDialogInUse.Name = "SetDialogInUse"
SetDialogInUse.Parent = RobloxReplicatedStorage

local tbl1 = ({})

Players.PlayerRemoving:Connect(function(player: Player)
    local var1 = tbl1[player]
    if var1 then
        var1:SetPlayerIsUsing(player, false)
        tbl1[player] = nil
    end
end)

SetDialogInUse.OnServerEvent:Connect(function(player: Player, arguments, arg1) -- name: setDialogInUse
    if typeof(arguments) == "Instance"
        and arguments:IsA("Dialog")
        and type(arg1) == "boolean"
        and typeof(player) == "Instance"
        and player:IsA("Player")
        and arguments
    then
        arguments:SetPlayerIsUsing(player, arg1)
        tbl1[player] = arg1 and arguments or nil
    end
end)
