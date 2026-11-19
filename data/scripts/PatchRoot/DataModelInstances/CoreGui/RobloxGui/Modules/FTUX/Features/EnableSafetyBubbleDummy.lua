-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CorePackages = game:GetService("CorePackages")

local Workspace = game:GetService("Workspace")

local GenerateDummy = require(script.Parent.Parent.Utility.GenerateDummy)
local CurrentCamera = workspace.CurrentCamera

local FIntSafetyBubbleRadius = require(CorePackages.Workspace.Packages.VrCommon).FIntSafetyBubbleRadius
local var1 = require(CorePackages.Workspace.Packages.VrCommon).FIntSafetyBubbleTransparencyPercent * 0.01

local bool1 = true

local num1 = math.max(FIntSafetyBubbleRadius * CurrentCamera.HeadScale, 0.1)

local var2 = nil
function initDummy()
    var2 = GenerateDummy(Vector3.new(0, 8.8, -50.5), Vector3.new(0, 180, 0))
    var2.Parent = Workspace
end

local function calculateTransparency(_player: Player, bool2: boolean): number
    if not bool2 then
        return 0
    end

    local cFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)
    local magnitude = ((CurrentCamera.CFrame * cFrame).Position - var2.HumanoidRootPart.Position).Magnitude

    local num2 = num1 * 0.75

    return math.clamp(if magnitude < num2 then var1 else (1 - (magnitude - num2) / (num1 - num2)) * var1, 0, 1)
end

function EnableSafetyBubbleDummy()
    initDummy()

    RunService.Stepped:Connect(function() -- name: onStep
        local children = var2:GetChildren()

        if UserGameSettings.VRSafetyBubbleMode == Enum.VRSafetyBubbleMode.Anyone then
            bool1 = false
        else
            bool1 = true
        end

        for _, player in ipairs(game.Players:GetPlayers()) do
            if not player.Character then
                continue
            end

            local transparency = calculateTransparency(player, bool1)

            var2.Head.Face.Transparency = transparency

            for i = 1, #children do
                if children[i]:IsA("Part") then
                    children[i].Transparency = transparency
                end
            end
        end
    end)
end

return EnableSafetyBubbleDummy
