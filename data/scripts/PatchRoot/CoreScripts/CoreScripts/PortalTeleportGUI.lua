-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local AdService = game:GetService("AdService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local colorCorrectionEffect = nil
local num1 = 0

local _RobloxGui = CoreGui.RobloxGui
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts

local TeleportEffectGui = Instance.new("ScreenGui")
TeleportEffectGui.Name = "TeleportEffectGui"
TeleportEffectGui.IgnoreGuiInset = true
TeleportEffectGui.Enabled = false
TeleportEffectGui.DisplayOrder = 7
TeleportEffectGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TeleportEffectGui.Parent = CoreGui

local TopFrame = Instance.new("Frame")
TopFrame.Name = "TopFrame"
TopFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopFrame.BorderSizePixel = 0
TopFrame.AnchorPoint = Vector2.new(0.5, 1)
TopFrame.Position = UDim2.new(0.5, 0, 0, 0)
TopFrame.Size = UDim2.new(1, 0, 1, 0)
TopFrame.ZIndex = 1
TopFrame.Parent = TeleportEffectGui
local frame = TopFrame:Clone()
frame.AnchorPoint = Vector2.new(0.5, 0)
frame.Position = UDim2.new(0.5, 0, 1, 0)
frame.Parent = TeleportEffectGui

local SpinnerContainer = Instance.new("Frame")
SpinnerContainer.Name = "SpinnerContainer"
SpinnerContainer.ZIndex = 2
SpinnerContainer.BackgroundTransparency = 1
SpinnerContainer.AnchorPoint = Vector2.new(1, 1)
SpinnerContainer.Size = UDim2.new(0.125, 0, 0.125, 0)
SpinnerContainer.Position = UDim2.new(1, 0, 1, 0)
SpinnerContainer.Parent = TeleportEffectGui
local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
uiAspectRatioConstraint.AspectRatio = 1
uiAspectRatioConstraint.Parent = SpinnerContainer
local SpinnerRobloxTilt = Instance.new("ImageLabel")
SpinnerRobloxTilt.Name = "SpinnerRobloxTilt"
SpinnerRobloxTilt.BackgroundTransparency = 1
SpinnerRobloxTilt.ImageTransparency = 1
SpinnerRobloxTilt.Image = "rbxasset://textures/loading/robloxTilt.png"
SpinnerRobloxTilt.ZIndex = 2
SpinnerRobloxTilt.AnchorPoint = Vector2.new(0.5, 0.5)
SpinnerRobloxTilt.Size = UDim2.new(1, 0, 1, 0)
SpinnerRobloxTilt.Position = UDim2.new(0, 0, 0, 0)
SpinnerRobloxTilt.Parent = SpinnerContainer
local uiAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
uiAspectRatioConstraint2.AspectRatio = 1
uiAspectRatioConstraint2.Parent = SpinnerRobloxTilt

local textLabel = Instance.new("TextLabel")
textLabel.Text = RobloxTranslator:FormatByKey("CoreScripts.Ads.Label.Teleporting")
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextTransparency = 1
textLabel.BackgroundTransparency = 1
textLabel.ZIndex = 2
textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel.Size = UDim2.new(0.6, 0, 0, 48)
textLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
textLabel.Font = AppFonts.default:getDefault()
textLabel.TextScaled = true
textLabel.Parent = TeleportEffectGui

local bool1 = false
function spinSpinner()
    if bool1 then
        return
    end

    bool1 = true
    local startTime = os.clock()
    RunService:BindToRenderStep("PortalLoadingSpinner", Enum.RenderPriority.Last.Value, function()
        if not (SpinnerRobloxTilt and SpinnerRobloxTilt.Parent) then
            stopSpinner()

            return
        end

        local num2 = (os.clock() - startTime) / 4 % 1
        local var1, num3

        if num2 <= 0.75 then
            var1 = math.cos(math.pi * (num2 / 0.75)) * -0.5 + 0.5
            num3 = 2.25
        else
            var1 = math.cos(math.pi + math.pi * ((num2 - 0.75) / 0.25)) * -0.5 + 0.5
            num3 = 0.25
        end

        local num4 = var1 * 0.25 + 1
        SpinnerRobloxTilt.Size = UDim2.new(num4, 0, num4, 0)
        SpinnerRobloxTilt.Rotation = var1 * 360 * num3
    end)
end

function stopSpinner()
    RunService:UnbindFromRenderStep("PortalLoadingSpinner")
    bool1 = false
end

function cover()
    num1 += 1
    local num2 = num1

    if colorCorrectionEffect then
        if colorCorrectionEffect.Parent then
            colorCorrectionEffect:Destroy()
        end
        colorCorrectionEffect = nil
    end
    colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    colorCorrectionEffect.Name = "TeleportColorCorrectionEffect"
    colorCorrectionEffect.Parent = Lighting

    TweenService:Create(
        colorCorrectionEffect,
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        { Brightness = 1 }
    ):Play()

    task.delay(0.25, function()
        if num2 ~= num1 then
            return
        end
        if TeleportEffectGui and TeleportEffectGui.Parent then
            TeleportEffectGui.Enabled = true
        end
        if not TopFrame or not TopFrame.Parent or not frame or not frame.Parent then
            return
        end

        TweenService:Create(
            TopFrame,
            TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }
        ):Play()
        TweenService:Create(
            frame,
            TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }
        ):Play()
    end)

    task.delay(1.25, function()
        if num2 ~= num1 then
            return
        end
        if SpinnerRobloxTilt and SpinnerRobloxTilt.Parent then
            TweenService:Create(
                SpinnerRobloxTilt,
                TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                { ImageTransparency = 0 }
            ):Play()
            spinSpinner()
        end
        if textLabel and textLabel.Parent then
            TweenService:Create(
                textLabel,
                TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                { TextTransparency = 0 }
            ):Play()
        end
    end)
end

function uncover()
    num1 += 1
    local num2 = num1

    if SpinnerRobloxTilt and SpinnerRobloxTilt.Parent then
        TweenService:Create(
            SpinnerRobloxTilt,
            TweenInfo.new(0.6000000000000001, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            { ImageTransparency = 1 }
        ):Play()
    end
    if textLabel and textLabel.Parent then
        TweenService:Create(
            textLabel,
            TweenInfo.new(0.6000000000000001, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            { TextTransparency = 1 }
        ):Play()
    end
    if colorCorrectionEffect and colorCorrectionEffect.Parent then
        TweenService:Create(
            colorCorrectionEffect,
            TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            { Brightness = 0 }
        ):Play()
    end
    if TopFrame and TopFrame.Parent and frame and frame.Parent then
        TweenService:Create(
            TopFrame,
            TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {
                Position = UDim2.new(0.5, 0, 0, 0)
            }
        ):Play()
        TweenService:Create(
            frame,
            TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {
                Position = UDim2.new(0.5, 0, 1, 0)
            }
        ):Play()
    end

    task.delay(3, function()
        if num2 ~= num1 then
            return
        end
        if colorCorrectionEffect then
            if colorCorrectionEffect.Parent then
                colorCorrectionEffect:Destroy()
            end
            colorCorrectionEffect = nil
        end
        if TeleportEffectGui and TeleportEffectGui.Parent then
            TeleportEffectGui.Enabled = false
        end
        stopSpinner()
    end)
end

AdService.AdTeleportInitiated:Connect(cover)
AdService.AdTeleportEnded:Connect(uncover)
