-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
tbl1.__index = tbl1

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local _InsertService = game:GetService("InsertService")

local CurrentCamera = Workspace.CurrentCamera

local function removeScripts(selectedCharacterIndicatorClone)
    for _, descendant in ipairs(selectedCharacterIndicatorClone:GetDescendants()) do
        if descendant:IsA("LuaSourceContainer") then
            descendant:Destroy()
        end
    end
end

local function ApplyArrow(character, arg1)
    local contextMenuArrow = Instance.new("Model")
    contextMenuArrow.Name = "ContextMenuArrow"
    contextMenuArrow.Parent = CurrentCamera

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid == nil then
        humanoid = character:WaitForChild("Humanoid", 15)
        if humanoid == nil then
            return
        end
    end

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local selectedCharacterIndicatorClone = arg1.SelectedCharacterIndicator:Clone()
    removeScripts(selectedCharacterIndicatorClone)
    selectedCharacterIndicatorClone.Anchored = true
    selectedCharacterIndicatorClone.Transparency = 0
    selectedCharacterIndicatorClone.CanCollide = false
    selectedCharacterIndicatorClone.Parent = contextMenuArrow

    local tween = TweenService:Create(
        selectedCharacterIndicatorClone,
        TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false),
        { Orientation = Vector3.new(0, 360, 180) }
    )
    tween:Play()

    local bool1 = false
    local function kill()
        if bool1 then
            return
        end
        bool1 = true
        contextMenuArrow:Destroy()
        tween:Destroy()
        RunService:UnbindFromRenderStep("ContextActionMenuRenderArrow")
    end

    humanoid.Died:Connect(kill)
    character.AncestryChanged:Connect(kill)

    RunService:BindToRenderStep("ContextActionMenuRenderArrow", Enum.RenderPriority.Camera.Value + 1, function() -- name: update
        selectedCharacterIndicatorClone.Position = humanoidRootPart.Position + Vector3.new(0, 5, 0)
    end)

    contextMenuArrow.Parent = CurrentCamera

    return kill
end

function tbl1.ChangeSelectedPlayer(arg1, selectedPlayer, arg2)
    coroutine.wrap(function()
        if arg1.SelectedPlayer then
            arg1.SelectedPlayer = nil
            arg1.CharacterAddedConn:Disconnect()
            arg1.CharacterAddedConn = nil
            if arg1.KillOldRenderFunction then
                arg1.KillOldRenderFunction()
                arg1.KillOldRenderFunction = nil
            end
        end

        if not selectedPlayer then
            return
        end

        arg1.SelectedPlayer = selectedPlayer
        arg1.CharacterAddedConn = selectedPlayer.CharacterAdded:Connect(function(character: Model)
            if arg1.KillOldRenderFunction then
                arg1.KillOldRenderFunction()
            end
            arg1.KillOldRenderFunction = ApplyArrow(character, arg2)
        end)
        if selectedPlayer.Character then
            arg1.KillOldRenderFunction = ApplyArrow(selectedPlayer.Character, arg2)
        end
    end)()
end

function tbl1.new()
    local self = setmetatable({}, tbl1)

    self.KillOldRenderFunction = nil
    self.SelectedPlayer = nil
    self.CharacterAddedConn = nil

    return self
end

return tbl1.new()
