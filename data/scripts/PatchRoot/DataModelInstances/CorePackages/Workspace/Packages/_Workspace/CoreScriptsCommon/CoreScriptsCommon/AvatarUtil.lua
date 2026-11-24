-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(player)
    local self = setmetatable({}, tbl1)

    self.player = player

    self.characterChangedEvent = Instance.new("BindableEvent")
    self.eventQueued = false

    self.connections = {}

    self.connections.characterAddedConnection = player.CharacterAdded:Connect(function(character: Model)
        self:onCharacterChanged(character)
    end)

    self.connections.characterAppearanceChangedConnection = player.CharacterAppearanceLoaded:Connect(function(character: Model)
        self:onCharacterChanged(character)
    end)

    if self.player.Character then
        self:onCharacterChanged(self.player.Character)
    end

    return self
end

function tbl1:removeConnection(arg1)
    if self.connections[arg1] then
        self.connections[arg1]:Disconnect()
        self.connections[arg1] = nil
    end
end

function tbl1:onCharacterChanged(arg1)
    self:removeConnection("descendantAddedConnection")
    self.connections.descendantAddedConnection = arg1.DescendantAdded:Connect(function(descendant: Instance)
        self:onDescendantAdded(descendant)
    end)

    self:removeConnection("descendantRemovedConnection")
    self.connections.descendantRemovedConnection = arg1.DescendantRemoving:Connect(function(descendant: Instance)
        self:onDescendantRemoving(descendant)
    end)

    for _, descendant in pairs(arg1:GetDescendants()) do
        self:onDescendantAdded(descendant)
    end

    self:fireCharacterChanged()
end

function tbl1:onDescendantAdded(arg1)
    if arg1:IsA("NumberValue") then
        local str1 = arg1.Name .. "Connection"
        self:removeConnection(str1)
        self.connections[str1] = arg1.Changed:Connect(function()
            self:fireCharacterChanged()
        end)
    end

    self:fireCharacterChanged()
end

function tbl1:onDescendantRemoving(arg1)
    if arg1:IsA("NumberValue") then
        self:removeConnection(arg1.Name .. "Connection")
    end

    self:fireCharacterChanged()
end

function tbl1:fireCharacterChanged()
    if self.eventQueued then
        return
    end

    self.eventQueued = true
    task.delay(0.1, function()
        self.eventQueued = false

        local character = self.player.Character
        if character then
            self.characterChangedEvent:Fire(character)
        end
    end)
end

local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)

    self.playerConnections = {}

    return self
end

function module.connectLocalCharacterChanges(tbl2, func1: (...any) -> (...any))
    local localPlayer = Players.LocalPlayer

    while not localPlayer do
        Players.Changed:Wait()
        localPlayer = Players.LocalPlayer
    end

    tbl2:connectPlayerCharacterChanges(localPlayer, func1)
end

function module:connectPlayerCharacterChanges(arg1, func1: (...any) -> (...any))
    if not self.playerConnections[arg1] then
        self.playerConnections[arg1] = tbl1.new(arg1)
    end

    self.playerConnections[arg1].characterChangedEvent.Event:Connect(func1)

    self.playerConnections[arg1]:fireCharacterChanged()
end

return module
