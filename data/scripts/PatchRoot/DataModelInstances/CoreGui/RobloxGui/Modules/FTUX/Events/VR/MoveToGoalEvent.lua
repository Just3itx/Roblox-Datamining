-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _EventType = require(script.Parent.Parent.EventType)

local module = { Name = "MoveToGoalEvent" }

local connection = nil

local function spawnGoalArea(vec1: vector, vec2: vector): Part -- Luacid: unused: defined but never referenced
    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Size = Vector3.new(math.abs(vec2.X - vec1.X), 1, math.abs(vec2.Z - vec1.Z))
    part.Position = Vector3.new((vec2.X + vec1.X) / 2, 6.3, (vec2.Z + vec1.Z) / 2)
    part.Parent = workspace

    return part
end

function module.StartEvent(callback)
    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Size = Vector3.new(17, 1, 18)
    part.Position = Vector3.new(0.5, 6.3, -40)
    part.Parent = workspace

    task.wait(1)

    connection = part.Touched:Connect(function(otherPart: BasePart)
        if not game.Players:GetPlayerFromCharacter(otherPart.Parent) then
            return
        end
        part:Destroy()

        task.wait(0.2)
        callback()

        if connection then
            connection:Disconnect()
            connection = nil
        end
    end)
end

function module.StopEvent()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return module
