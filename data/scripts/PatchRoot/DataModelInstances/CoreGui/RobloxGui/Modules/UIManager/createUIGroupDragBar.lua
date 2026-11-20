-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local DragBar = require(scriptParent.DragBar)
local Constants = require(scriptParent.Constants)
local CoreGui = game:GetService("CoreGui")

return function(arg1)
    local part = Instance.new("Part")
    part.Size = Vector3.new(0.6, 0.12, 0.00001)
    part.Name = arg1.name .. "_DragBar"
    part.Color = Color3.new(1, 1, 1)
    part.Parent = workspace.CurrentCamera
    part.Anchored = true
    part.CanTouch = true
    part.CanCollide = false
    part.CastShadow = false
    part.Material = Enum.Material.Glass
    part.Transparency = 1

    local dragDetector = Instance.new("DragDetector")
    dragDetector.Enabled = true
    dragDetector.Parent = part
    dragDetector.DragStyle = Enum.DragDetectorDragStyle.BestForDevice

    local dragBarSurfaceGui = Instance.new("SurfaceGui", CoreGui)

    dragBarSurfaceGui.Name = "dragBar_SurfaceGui"
    dragBarSurfaceGui.Enabled = true
    dragBarSurfaceGui.CanvasSize = Vector2.new(part.Size.X, part.Size.Y) * Constants.VR_PANEL_RESOLUTION_MULTIPLIER
    dragBarSurfaceGui.AlwaysOnTop = true
    dragBarSurfaceGui.Shape = Enum.SurfaceGuiShape.Flat
    dragBarSurfaceGui.HorizontalCurvature = 0
    dragBarSurfaceGui.Active = true
    dragBarSurfaceGui.Adornee = part
    dragBarSurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    dragBarSurfaceGui.LightInfluence = 0
    dragBarSurfaceGui.ZOffset = 0
    dragBarSurfaceGui.Face = Enum.NormalId.Back

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Image = "rbxasset://textures/ui/InGameMenu/DragBar_Bright.png"
    imageLabel.Parent = dragBarSurfaceGui
    imageLabel.BackgroundTransparency = 1
    imageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    imageLabel.Size = UDim2.new(0.5, 0, 0.25, 0)
    imageLabel.ImageColor3 = Color3.new(1, 1, 1)

    dragDetector.RunLocally = true
    if arg1.dragFunction then
        dragDetector.DragContinue:Connect(arg1.dragFunction)
    end
    if arg1.dragStartFunction then
        dragDetector.DragStart:Connect(arg1.dragStartFunction)
    end
    if arg1.dragEndFunction then
        dragDetector.DragEnd:Connect(arg1.dragEndFunction)
    end
    return (DragBar.new(part, imageLabel))
end
