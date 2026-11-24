-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.createLoadingOverlay(arg1)
    arg1.LoadingOverlay = Instance.new("Frame")
    arg1.LoadingOverlay.Name = "LoadingOverlay"
    arg1.LoadingOverlay.BackgroundColor3 = arg1.defaultBackgroundColor3
    arg1.LoadingOverlay.BackgroundTransparency = arg1.defaultBackgroundTransparency
    arg1.LoadingOverlay.AnchorPoint = Vector2.new(0.5, 0.5)
    arg1.LoadingOverlay.Position = UDim2.new(0.5, 0, 0.5, 0)
    arg1.LoadingOverlay.BorderSizePixel = 0
    arg1.LoadingOverlay.Size = UDim2.new(0.5, 0, 0.5, 0)
    arg1.LoadingOverlay.Visible = false
    arg1.LoadingOverlay.Parent = arg1.screenGui

    arg1.LoadingLabel = Instance.new("TextLabel")
    arg1.LoadingLabel.Name = "LoadingLabel"
    arg1.LoadingLabel.Font = Enum.Font.SourceSans
    arg1.LoadingLabel.TextXAlignment = Enum.TextXAlignment.Center
    arg1.LoadingLabel.TextYAlignment = Enum.TextYAlignment.Center
    arg1.LoadingLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    arg1.LoadingLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    arg1.LoadingLabel.Size = UDim2.new(1, 0, 1, 0)
    arg1.LoadingLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.LoadingLabel.BackgroundTransparency = 1
    arg1.LoadingLabel.Text = "Loading"
    arg1.LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    arg1.LoadingLabel.TextScaled = true
    arg1.LoadingLabel.Parent = arg1.LoadingOverlay
end

return module
