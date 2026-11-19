-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
if not game:GetService("RunService"):IsStudio() then
    return
end

local function ensureRemote(name: string): RemoteEvent -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = RobloxReplicatedStorage:FindFirstChild(name)
    if var1 and var1:IsA("RemoteEvent") then
        return var1
    end
    local remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = name
    remoteEvent.Parent = RobloxReplicatedStorage
    return remoteEvent
end

local function waitForBindable(childName: string): BindableEvent? -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = ReplicatedStorage:WaitForChild(childName, 5)
    return if var1 == nil or not var1:IsA("BindableEvent") then nil else var1
end

local remoteEvent = ensureRemote("PlatformLeaderboardPush")
local remoteEvent2 = ensureRemote("PlatformLeaderboardTabOpened")
local _remoteEvent = ensureRemote("PlatformLeaderboardTabClosed")
local var1 = waitForBindable("PlatformLeaderboardMockPushToAll")

if var1 == nil then
    return
end

local var2 = waitForBindable("PlatformLeaderboardMockPushToPlayer")
local var3 = waitForBindable("PlatformLeaderboardMockTabOpened")

if var2 == nil or var3 == nil then
    return
end

var1.Event:Connect(function(arg1)
    remoteEvent:FireAllClients(arg1)
end)

var2.Event:Connect(function(arg1, arg2)
    if typeof(arg1) == "Instance" and arg1:IsA("Player") then
        remoteEvent:FireClient(arg1, arg2)
    end
end)

remoteEvent2.OnServerEvent:Connect(function(player: Player, arguments)
    var3:Fire(player, arguments)
end)
