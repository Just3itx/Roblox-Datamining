-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.createControlBar(arg1)
    arg1.ControlBarContainer = Instance.new("Frame")
    arg1.ControlBarContainer.Name = "ControlBarContainer"
    arg1.ControlBarContainer.BackgroundTransparency = 1
    arg1.ControlBarContainer.BorderSizePixel = 0
    arg1.ControlBarContainer.AnchorPoint = Vector2.new(0, 1)
    arg1.ControlBarContainerVisiblePosition = UDim2.new(0, 0, 1, 0)
    arg1.ControlBarContainerNonVisiblePosition = UDim2.new(0, 0, 1.2, 0)
    arg1.ControlBarContainer.Position = arg1.ControlBarContainerVisiblePosition
    arg1.maxControlBarHeight = 45
    arg1.ControlBarContainer.Size = UDim2.new(1, 0, 0, arg1.maxControlBarHeight)
    arg1.ControlBarContainer.Parent = arg1.screenGui

    local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    uiAspectRatioConstraint.AspectRatio = 30
    uiAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
    uiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
    uiAspectRatioConstraint.Parent = arg1.ControlBarContainer

    arg1.defaultBackgroundColor3 = Color3.fromRGB(20, 20, 20)
    arg1.defaultBackgroundTransparency = 0.15
    arg1.defaultButtonsTimeControlBarXSize = 0.275
    arg1.defaultHelpBarXSize = 0.025
    arg1.defaultScrubberControlBarXSize = 1 - arg1.defaultButtonsTimeControlBarXSize - arg1.defaultHelpBarXSize

    arg1.ButtonsTimeControlBar = Instance.new("Frame")
    arg1.ButtonsTimeControlBar.Name = "ButtonsTimeControlBar"
    arg1.ButtonsTimeControlBar.BackgroundColor3 = arg1.defaultBackgroundColor3
    arg1.ButtonsTimeControlBar.BackgroundTransparency = arg1.defaultBackgroundTransparency
    arg1.ButtonsTimeControlBar.BorderSizePixel = 0
    arg1.ButtonsTimeControlBar.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.ButtonsTimeControlBar.Size = UDim2.new(arg1.defaultButtonsTimeControlBarXSize, 0, 1, 0)
    arg1.ButtonsTimeControlBar.Parent = arg1.ControlBarContainer

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0.02, 0)
    uiPadding.Parent = arg1.ButtonsTimeControlBar

    arg1.ScrubberControlBar = Instance.new("Frame")
    arg1.ScrubberControlBar.Name = "ScrubberControlBar"
    arg1.ScrubberControlBar.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    arg1.ScrubberControlBar.BackgroundTransparency = 0.5
    arg1.ScrubberControlBar.BorderSizePixel = 0
    arg1.ScrubberControlBar.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.ScrubberControlBar.Size = UDim2.new(arg1.defaultScrubberControlBarXSize, 0, 1, 0)
    arg1.ScrubberControlBar.Parent = arg1.ControlBarContainer

    local uiFlexItem = Instance.new("UIFlexItem")
    uiFlexItem.FlexMode = Enum.UIFlexMode.Fill
    uiFlexItem.Parent = arg1.ScrubberControlBar

    arg1.HelpBar = Instance.new("Frame")
    arg1.HelpBar.Name = "HelpBar"
    arg1.HelpBar.BackgroundColor3 = arg1.defaultBackgroundColor3
    arg1.HelpBar.BackgroundTransparency = arg1.defaultBackgroundTransparency
    arg1.HelpBar.BorderSizePixel = 0
    arg1.HelpBar.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.HelpBar.Size = UDim2.new(arg1.defaultHelpBarXSize, 0, 1, 0)
    arg1.HelpBar.Parent = arg1.ControlBarContainer

    arg1.maxViewportScalingWidth = arg1.maxControlBarHeight * uiAspectRatioConstraint.AspectRatio

    local function setupControlBarScaling()
        arg1.firstThresholdCheck = true
        arg1.lastCheckAboveThreshold = false
        local currentCamera = workspace.CurrentCamera
        if not currentCamera then
            warn("No current camera found in workspace")
            return
        end
        currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            if currentCamera.ViewportSize.X > arg1.maxViewportScalingWidth then
                if not arg1.firstBoundaryCheck and arg1.lastCheckAboveThreshold then
                    return
                end
                arg1.lastCheckAboveThreshold = true

                uiAspectRatioConstraint.Parent = nil

                local offset = arg1.ButtonsTimeControlBar.AbsoluteSize.X * uiPadding.PaddingLeft.Scale + uiPadding.PaddingLeft.Offset
                uiPadding.PaddingLeft = UDim.new(0, offset)

                arg1.ButtonsTimeControlBar.Size = UDim2.new(0, arg1.ButtonsTimeControlBar.AbsoluteSize.X, 1, 0)
                arg1.HelpBar.Size = UDim2.new(0, arg1.HelpBar.AbsoluteSize.X, 1, 0)
            else
                if not (arg1.firstBoundaryCheck or arg1.lastCheckAboveThreshold) then
                    return
                end
                arg1.lastCheckAboveThreshold = false

                uiAspectRatioConstraint.Parent = arg1.ControlBarContainer
                uiPadding.PaddingLeft = UDim.new(0.02, 0)

                arg1.ButtonsTimeControlBar.Size = UDim2.new(arg1.defaultButtonsTimeControlBarXSize, 0, 1, 0)
                arg1.HelpBar.Size = UDim2.new(arg1.defaultHelpBarXSize, 0, 1, 0)
            end
            arg1.firstBoundaryCheck = false
        end)
    end
    setupControlBarScaling()
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(setupControlBarScaling)

    function arg1.createUIListLayout(parent, offset: number): UIListLayout
        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        uiListLayout.FillDirection = Enum.FillDirection.Horizontal
        uiListLayout.Padding = UDim.new(0, offset)
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.Parent = parent
        return uiListLayout
    end
    arg1.createUIListLayout(arg1.ControlBarContainer, 0)
    arg1.createUIListLayout(arg1.ButtonsTimeControlBar, 7.5)
end

return module
