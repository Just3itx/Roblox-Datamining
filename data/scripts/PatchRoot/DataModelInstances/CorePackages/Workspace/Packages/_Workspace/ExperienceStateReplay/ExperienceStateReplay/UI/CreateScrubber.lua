-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local SecondsToTimeStr = require(scriptParent.SecondsToTimeStr)

local module = {}

function module.createScrubber(arg1)
    arg1.ScrubberLoadProgress = Instance.new("Frame")
    arg1.ScrubberLoadProgress.Name = "ScrubberLoadProgress"
    arg1.ScrubberLoadProgress.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    arg1.ScrubberLoadProgress.BackgroundTransparency = 0.5
    arg1.ScrubberLoadProgress.BorderSizePixel = 0
    arg1.ScrubberLoadProgress.AnchorPoint = Vector2.new(0, 0)
    arg1.ScrubberLoadProgress.Position = UDim2.new(0, 0, 0, 0)
    arg1.ScrubberLoadProgress.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.ScrubberLoadProgress.Size = UDim2.new(0, 0, 1, 0)
    arg1.ScrubberLoadProgress.Parent = arg1.ScrubberControlBar

    arg1.ScrubberPlayProgress = Instance.new("Frame")
    arg1.ScrubberPlayProgress.Name = "ScrubberPlayProgress"
    arg1.ScrubberPlayProgress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    arg1.ScrubberPlayProgress.BorderSizePixel = 0
    arg1.ScrubberPlayProgress.AnchorPoint = Vector2.new(0, 0)
    arg1.ScrubberPlayProgress.Position = UDim2.new(0, 0, 0, 0)
    arg1.ScrubberPlayProgress.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.ScrubberPlayProgress.Size = UDim2.new(0, 0, 1, 0)
    arg1.ScrubberPlayProgress.Parent = arg1.ScrubberLoadProgress

    arg1.ScrubberButton = Instance.new("TextButton")
    arg1.ScrubberButton.Name = "ScrubberButton"
    arg1.ScrubberButton.Text = ""
    arg1.ScrubberButton.BackgroundTransparency = 1
    arg1.ScrubberButton.BorderSizePixel = 0
    arg1.ScrubberButton.AnchorPoint = Vector2.new(0, 0)
    arg1.ScrubberButton.Position = UDim2.new(0, 0, 0, 0)
    arg1.ScrubberButton.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.ScrubberButton.Size = UDim2.new(1, 0, 1, 0)
    arg1.ScrubberButton.Parent = arg1.ScrubberControlBar

    arg1.ScrubberTimeLabel = Instance.new("TextLabel")
    arg1.ScrubberTimeLabel.Name = "ScrubberTimeLabel"
    arg1.ScrubberTimeLabel.Font = Enum.Font.SourceSans
    arg1.ScrubberTimeLabel.TextXAlignment = Enum.TextXAlignment.Center
    arg1.ScrubberTimeLabel.TextYAlignment = Enum.TextYAlignment.Center
    arg1.ScrubberTimeLabel.Size = UDim2.new(0.15, 0, 1.3, 0)
    arg1.ScrubberTimeLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.ScrubberTimeLabel.AnchorPoint = Vector2.new(0.5, 1)
    arg1.ScrubberTimeLabel.Position = UDim2.new(0, 0, 0, 0)
    arg1.ScrubberTimeLabel.BorderSizePixel = 0
    arg1.ScrubberTimeLabel.BackgroundColor3 = arg1.defaultBackgroundColor3
    arg1.ScrubberTimeLabel.BackgroundTransparency = arg1.defaultBackgroundTransparency
    arg1.ScrubberTimeLabel.Text = SecondsToTimeStr.convertSecondsToTimeStr(0)
    arg1.ScrubberTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    arg1.ScrubberTimeLabel.TextScaled = true
    arg1.ScrubberTimeLabel.Parent = arg1.ScrubberControlBar
    arg1.ScrubberTimeLabel.Visible = false

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingBottom = UDim.new(0.05, 0)
    uiPadding.Parent = arg1.ScrubberTimeLabel

    local scrubberControlBar = arg1.ScrubberControlBar
    if not scrubberControlBar then
        warn("No ScrubberControlBar found")
        return
    end

    local function func1(num1: number)
        local scrubberTimeLabel = arg1.ScrubberTimeLabel
        if not scrubberTimeLabel then
            warn("No ScrubberTimeLabel found")
            return
        end
        scrubberTimeLabel.Position = UDim2.new(0, num1 - scrubberControlBar.AbsolutePosition.X, 0, 0)
        local absolutePositionX = scrubberControlBar.AbsolutePosition.X
        local var1 = absolutePositionX + scrubberControlBar.AbsoluteSize.X
        local var2 = (num1 - absolutePositionX) / (var1 - absolutePositionX)
        local var3 = var2 * arg1.overallLengthSeconds

        arg1.ScrubberTimeLabel.Text = SecondsToTimeStr.convertSecondsToTimeStr(var3)
        if var2 > 0.75 then
            arg1.ScrubberTimeLabel.AnchorPoint = Vector2.new(1, 1)
            return
        end
        arg1.ScrubberTimeLabel.AnchorPoint = Vector2.new(0.5, 1)
    end

    scrubberControlBar.MouseEnter:Connect(function(num1: number)
        arg1.ScrubberTimeLabel.Visible = true
        func1(num1)
    end)
    scrubberControlBar.MouseMoved:Connect(function(x: number)
        func1(x)
    end)
    scrubberControlBar.MouseLeave:Connect(function()
        arg1.ScrubberTimeLabel.Visible = false
    end)
end

return module
