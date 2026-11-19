-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local Players = game:GetService("Players")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui", math.huge)
assert(RobloxGui ~= nil, "RobloxGui should exist")

local GetFFlagPlayerViewRemoteEnabled = require(RobloxGui.Modules.Common.Flags.GetFFlagPlayerViewRemoteEnabled)

local bool1 = game:DefineFastFlag("EnablePlayerViewRemoteEventUserIdValidation2", false)

local RequestDeviceCameraOrientationCapability = Instance.new("RemoteEvent")
RequestDeviceCameraOrientationCapability.Name = "RequestDeviceCameraOrientationCapability"
RequestDeviceCameraOrientationCapability.Parent = RobloxReplicatedStorage

local tbl1 = {}

RequestDeviceCameraOrientationCapability.OnServerEvent:Connect(function(player: Player, arguments)
    local now = os.clock()
    local var1 = tbl1[player.UserId]
    if not (var1 and now - var1 < 2) and typeof(arguments) == "Instance" and arguments:IsA("Player") then
        tbl1[player.UserId] = now

        local osPlatform = arguments.OsPlatform
        RequestDeviceCameraOrientationCapability:FireClient(player, arguments, osPlatform == "iOS" or osPlatform == "Android")
    end
end)

Players.PlayerRemoving:Connect(function(player: Player)
    tbl1[player.UserId] = nil
end)

if not GetFFlagPlayerViewRemoteEnabled() then
    return
end

local requestDeviceCameraCFrame = Instance.new("RemoteEvent")
requestDeviceCameraCFrame.Name = "RequestDeviceCameraCFrame"
requestDeviceCameraCFrame.Parent = RobloxReplicatedStorage

local replicateDeviceCameraCFrame = Instance.new("UnreliableRemoteEvent")
replicateDeviceCameraCFrame.Name = "ReplicateDeviceCameraCFrame"
replicateDeviceCameraCFrame.Parent = RobloxReplicatedStorage

local tbl2 = ({})

Players.PlayerRemoving:Connect(function(player: Player)
    local str1 = tostring(player.UserId)
    tbl2[str1] = nil
end)

requestDeviceCameraCFrame.OnServerEvent:Connect(function(player: Player, arguments)
    if bool1 then
        if typeof(arguments) ~= "number" or arguments <= 0 or player.UserId == arguments or math.floor(arguments) ~= arguments then
            return
        end
    elseif typeof(arguments) ~= "number" or arguments <= 0 or player.UserId == arguments then
        return
    end

    local player2 = Players:GetPlayerByUserId(arguments)
    if not player2 then
        return
    end

    local str1 = tostring(player2.UserId)

    if not tbl2[str1] then
        tbl2[str1] = {}
    end

    local var1 = tbl2[str1]
    local userId = player.UserId
    var1[tostring(userId)] = os.clock()
    requestDeviceCameraCFrame:FireClient(player2)
end)

replicateDeviceCameraCFrame.OnServerEvent:Connect(function(player: Player, arguments, arg1)
    if typeof(arguments) ~= "CFrame" or typeof(arg1) ~= "number" or arg1 <= 0 then
        return
    end

    local str1 = tostring(player.UserId)

    if not tbl2[str1] then
        return
    end

    local tbl3 = {}

    for value, value2 in tbl2[str1] do
        if os.clock() - value2 > 5 then
            table.insert(tbl3, value)
        else
            local var1 = tonumber(value)
            if var1 then
                local player2 = Players:GetPlayerByUserId(var1)
                if player2 then
                    replicateDeviceCameraCFrame:FireClient(player2, player, arguments, arg1)
                end
            end
        end
    end
    for _, value in tbl3 do
        tbl2[str1][value] = nil
    end
end)
