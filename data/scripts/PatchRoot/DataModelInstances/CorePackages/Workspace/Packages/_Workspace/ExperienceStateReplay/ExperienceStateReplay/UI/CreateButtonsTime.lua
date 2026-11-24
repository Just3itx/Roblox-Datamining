-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local ButtonAssets = require(scriptParent.ButtonAssets)
local SecondsToTimeStr = require(scriptParent.SecondsToTimeStr)

local module = {
    regularColor = Color3.fromRGB(255, 255, 255),
    hoverColor = Color3.fromRGB(200, 200, 200),
    clickColor = Color3.fromRGB(150, 150, 150)
}
function module.createButtonsTime(arg1)
    function arg1.createControlBarButton(image: string, bool1: boolean): ImageButton
        local controlBarButton = Instance.new("ImageButton")
        controlBarButton.Name = "ControlBarButton"
        controlBarButton.Parent = arg1.ButtonsTimeControlBar
        controlBarButton.BackgroundTransparency = 1
        controlBarButton.Image = image
        controlBarButton.ImageColor3 = module.regularColor
        controlBarButton.AnchorPoint = Vector2.new(0, 0.5)
        controlBarButton.Size = UDim2.new(0.1, 0, 0.9, 0)
        controlBarButton.SizeConstraint = Enum.SizeConstraint.RelativeXY

        controlBarButton:SetAttribute("useHoverColor", true)
        controlBarButton.MouseEnter:Connect(function()
            if controlBarButton:GetAttribute("useHoverColor") then
                controlBarButton.ImageColor3 = module.hoverColor
            end
        end)
        controlBarButton.MouseLeave:Connect(function()
            if controlBarButton:GetAttribute("useHoverColor") then
                controlBarButton.ImageColor3 = module.regularColor
            end
        end)
        controlBarButton.MouseButton1Down:Connect(function()
            controlBarButton.ImageColor3 = module.clickColor
        end)
        if bool1 then
            controlBarButton.MouseButton1Up:Connect(function()
                controlBarButton.ImageColor3 = module.hoverColor
            end)
        end

        local uiSizeConstraint = Instance.new("UISizeConstraint")
        uiSizeConstraint.MaxSize = Vector2.new(arg1.maxControlBarHeight * 0.9, arg1.maxControlBarHeight * 0.9)

        uiSizeConstraint.Parent = controlBarButton

        return controlBarButton
    end

    arg1.PlayButton = arg1.createControlBarButton(ButtonAssets.PlayButton, true)
    arg1.PlayButton.LayoutOrder = 2

    arg1.StopButton = arg1.createControlBarButton(ButtonAssets.StopButton, false)
    arg1.StopButton.LayoutOrder = 3

    arg1.ReverseButton = arg1.createControlBarButton(ButtonAssets.ReverseButton, false)
    arg1.ReverseButton.LayoutOrder = 4

    arg1.CurrentTimeLabel = Instance.new("TextLabel")
    arg1.CurrentTimeLabel.Name = "CurrentTimeLabel"
    arg1.CurrentTimeLabel.Font = Enum.Font.SourceSans
    arg1.CurrentTimeLabel.TextXAlignment = Enum.TextXAlignment.Left
    arg1.CurrentTimeLabel.TextYAlignment = Enum.TextYAlignment.Center
    arg1.CurrentTimeLabel.AnchorPoint = Vector2.new(0, 0.5)
    arg1.CurrentTimeLabel.Size = UDim2.new(0.4, 0, 1.3, 0)
    arg1.CurrentTimeLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.CurrentTimeLabel.BackgroundTransparency = 1
    arg1.CurrentTimeLabel.Text = SecondsToTimeStr.convertSecondsToTimeStr(0)
    arg1.CurrentTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    arg1.CurrentTimeLabel.TextScaled = true
    arg1.CurrentTimeLabel.LayoutOrder = 5
    arg1.CurrentTimeLabel.Parent = arg1.ButtonsTimeControlBar

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingBottom = UDim.new(0.05, 0)
    uiPadding.Parent = arg1.CurrentTimeLabel
end

return module
