-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local module = {}

local var1 = nil

function module.hideOverlay()
    if var1 then
        var1:Destroy()
        var1 = nil
    end
end

function module.showOverlay(overlayLabelText, arg1, parent)
    module.hideOverlay()

    local textOverlay = Instance.new("Frame")
    textOverlay.Name = "TextOverlay"
    textOverlay.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    textOverlay.BackgroundTransparency = 0.5
    textOverlay.Size = UDim2.new(0.7, 0, 0.1, 0)
    textOverlay.Position = UDim2.new(0.5, 0, 0.8, 0)
    textOverlay.AnchorPoint = Vector2.new(0.5, 0.5)
    textOverlay.ZIndex = 100

    local overlayLabel = Instance.new("TextLabel")
    overlayLabel.Name = "OverlayLabel"
    overlayLabel.Text = overlayLabelText
    overlayLabel.TextColor3 = Color3.new(1, 1, 1)
    overlayLabel.TextScaled = true
    overlayLabel.TextWrapped = true
    overlayLabel.BackgroundTransparency = 1
    overlayLabel.Size = UDim2.new(0.8, 0, 0.8, 0)
    overlayLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    overlayLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    overlayLabel.Font = Enum.Font.SourceSans
    overlayLabel.Parent = textOverlay
    overlayLabel.ZIndex = 200

    textOverlay.Parent = parent

    var1 = textOverlay

    task.spawn(function()
        task.wait(arg1)

        if var1 == textOverlay then
            module.hideOverlay()
        end
    end)
end

return module
