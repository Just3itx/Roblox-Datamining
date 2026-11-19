-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local tbl1 = ({})

local DefaultSoundEvents = ReplicatedStorage:FindFirstChild("DefaultSoundEvents")
if not DefaultSoundEvents then
    DefaultSoundEvents = Instance.new("Folder")
    DefaultSoundEvents.Name = "DefaultSoundEvents"
    DefaultSoundEvents.Archivable = false
    DefaultSoundEvents.Parent = ReplicatedStorage
end

local function createEvent(name: string, className: string): Instance -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = DefaultSoundEvents:FindFirstChild(name)
    if not var1 then
        var1 = Instance.new(className)
        var1.Name = name
        var1.Parent = DefaultSoundEvents
    end

    return var1
end

local event = createEvent("DefaultServerSoundEvent", "RemoteEvent")
local event2 = createEvent("AddCharacterLoadedEvent", "RemoteEvent")
local event3 = createEvent("RemoveCharacterEvent", "RemoteEvent")

local function removeCharacter(arg1)
    tbl1[arg1] = nil
end

createEvent("SoundDispatcher", "BindableEvent").Event:Connect(function(player: Player, arg1, arg2, arg3) -- name: fireDefaultServerSoundEventToClient
    if tbl1[player] then
        event:FireClient(player, arg1, arg2, arg3)
    end
end)
event.OnServerEvent:Connect(function() end)

event2.OnServerEvent:Connect(function(player: Player) -- name: addCharacterLoaded
    tbl1[player] = true
end)

event3.OnServerEvent:Connect(removeCharacter)
Players.PlayerRemoving:Connect(removeCharacter)
