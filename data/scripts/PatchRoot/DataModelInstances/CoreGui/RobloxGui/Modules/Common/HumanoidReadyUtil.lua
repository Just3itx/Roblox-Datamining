-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function waitForFirst(...)
    local bindableEvent = Instance.new("BindableEvent")
    local tbl1 = { ... }

    local function fire(...)
        for i = 1, #tbl1 do
            tbl1[i]:Disconnect()
        end

        return bindableEvent:Fire(...)
    end

    for i = 1, #tbl1 do
        tbl1[i] = tbl1[i]:Connect(fire)
    end

    return bindableEvent.Event:Wait()
end

local module = {}

function module.registerHumanoidReady(callback)
    local function characterAdded(player: Player, model: Model)
        if not model.Parent then
            waitForFirst(model.AncestryChanged, player.CharacterAdded)
        end

        if player.Character ~= model or not model.Parent then
            return
        end

        local humanoid = model:FindFirstChildOfClass("Humanoid")
        while model:IsDescendantOf(game) and not humanoid do
            waitForFirst(model.ChildAdded, model.AncestryChanged, player.CharacterAdded)
            humanoid = model:FindFirstChildOfClass("Humanoid")
        end

        if player.Character ~= model or not model:IsDescendantOf(game) then
            return
        end

        local humanoidRootPart = model:FindFirstChild("HumanoidRootPart")
        while model:IsDescendantOf(game) and not humanoidRootPart do
            waitForFirst(model.ChildAdded, model.AncestryChanged, humanoid.AncestryChanged, player.CharacterAdded)
            humanoidRootPart = model:FindFirstChild("HumanoidRootPart")
        end

        if humanoidRootPart and humanoid:IsDescendantOf(game) and model:IsDescendantOf(game) and player.Character == model then
            callback(player, model, humanoid)
        end
    end

    local function playerAdded(player: Player)
        local connection = player.CharacterAdded:Connect(function(character: Model)
            characterAdded(player, character)
        end)

        local connection2 = nil
        connection2 = player.AncestryChanged:Connect(function(_: Instance, parent: Instance)
            if not game:IsAncestorOf(parent) then
                connection2:Disconnect()
                connection:Disconnect()
            end
        end)

        local character = player.Character
        if character then
            characterAdded(player, character)
        end
    end

    Players.PlayerAdded:Connect(playerAdded)
    for _, player in pairs(Players:GetPlayers()) do
        playerAdded(player)
    end
end

return module
