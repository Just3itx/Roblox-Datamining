-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local scriptParentParent = script.Parent.Parent

local _React = require(scriptParentParent.React)
local ReactRoblox = require(scriptParentParent.ReactRoblox)

local FFlagExpChatTextChannelWindowFixLayerCollectorGeometry = require(script.Parent.Flags.FFlagExpChatTextChannelWindowFixLayerCollectorGeometry)
local createLayerCollectorOverlay = require(script.Parent.createLayerCollectorOverlay)

local num1 = game:DefineFastInt("ExpChatTextChannelWindowMinWidth", 200)
local num2 = game:DefineFastInt("ExpChatTextChannelWindowMinHeight", 200)

local tbl1 = ({})

local function getEffectiveAdornee(surfaceGui: SurfaceGui) -- Luacid: Inlined by compiler; 2 call sites recovered
    if surfaceGui.Adornee ~= nil then
        return surfaceGui.Adornee
    end
    local surfaceGuiParent = surfaceGui.Parent
    return if surfaceGuiParent and surfaceGuiParent:IsA("BasePart") then surfaceGuiParent else nil
end

local function createOverlay(textChannelWindow: TextChannelWindow, layerCollector: LayerCollector?): ScreenGui | SurfaceGui
    if layerCollector and layerCollector:IsA("SurfaceGui") then
        local surfaceGui = Instance.new("SurfaceGui")
        surfaceGui.Name = "TextChannelWindowOverlay_" .. textChannelWindow.Name
        surfaceGui.ResetOnSpawn = false
        surfaceGui.Adornee = getEffectiveAdornee(layerCollector)
        surfaceGui.Face = layerCollector.Face
        surfaceGui.SizingMode = layerCollector.SizingMode
        surfaceGui.CanvasSize = layerCollector.CanvasSize
        surfaceGui.Parent = CoreGui
        return surfaceGui
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TextChannelWindowOverlay_" .. textChannelWindow.Name
    screenGui.ResetOnSpawn = false
    if layerCollector and layerCollector:IsA("ScreenGui") then
        screenGui.IgnoreGuiInset = layerCollector.IgnoreGuiInset
        screenGui.DisplayOrder = -1
        screenGui.ZIndexBehavior = layerCollector.ZIndexBehavior
    else
        screenGui.IgnoreGuiInset = true
        screenGui.DisplayOrder = -1
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end
    screenGui.Parent = CoreGui
    return screenGui
end

local function connectGuiObjectSync(textChannelWindow: TextChannelWindow, frame: Frame, _, tbl2)
    local function syncTransform()
        frame.Position = UDim2.fromOffset(textChannelWindow.AbsolutePosition.X, textChannelWindow.AbsolutePosition.Y)
        frame.Size = UDim2.fromOffset(textChannelWindow.AbsoluteSize.X, textChannelWindow.AbsoluteSize.Y)
        frame.Rotation = textChannelWindow.Rotation
    end

    table.insert(tbl2, textChannelWindow:GetPropertyChangedSignal("AbsolutePosition"):Connect(syncTransform))
    table.insert(tbl2, textChannelWindow:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncTransform))
    table.insert(tbl2, textChannelWindow:GetPropertyChangedSignal("Rotation"):Connect(syncTransform))
end

local function connectSurfaceGuiSync(surfaceGui: SurfaceGui, arg1, tbl2)
    local function syncAdornee()
        arg1.Adornee = getEffectiveAdornee(surfaceGui)
    end
    table.insert(tbl2, surfaceGui:GetPropertyChangedSignal("Adornee"):Connect(syncAdornee))

    table.insert(tbl2, surfaceGui:GetPropertyChangedSignal("Parent"):Connect(syncAdornee))

    local faceChanged = surfaceGui:GetPropertyChangedSignal("Face")

    table.insert(tbl2, faceChanged:Connect(function()
        arg1.Face = surfaceGui.Face
    end))

    local sizingModeChanged = surfaceGui:GetPropertyChangedSignal("SizingMode")

    table.insert(tbl2, sizingModeChanged:Connect(function()
        arg1.SizingMode = surfaceGui.SizingMode
    end))

    local canvasSizeChanged = surfaceGui:GetPropertyChangedSignal("CanvasSize")

    table.insert(tbl2, canvasSizeChanged:Connect(function()
        arg1.CanvasSize = surfaceGui.CanvasSize
    end))
end

local function connectScreenGuiSync(screenGui: ScreenGui, arg1, tbl2)
    local ignoreGuiInsetChanged = screenGui:GetPropertyChangedSignal("IgnoreGuiInset")

    table.insert(tbl2, ignoreGuiInsetChanged:Connect(function()
        arg1.IgnoreGuiInset = screenGui.IgnoreGuiInset
    end))

    local zIndexBehaviorChanged = screenGui:GetPropertyChangedSignal("ZIndexBehavior")

    table.insert(tbl2, zIndexBehaviorChanged:Connect(function()
        arg1.ZIndexBehavior = screenGui.ZIndexBehavior
    end))
end

local function connectLayerCollectorSync(layerCollector: LayerCollector?, arg1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if layerCollector == nil then
        return
    end

    if layerCollector:IsA("SurfaceGui") then
        connectSurfaceGuiSync(layerCollector, arg1, tbl2)
    elseif layerCollector:IsA("ScreenGui") then
        connectScreenGuiSync(layerCollector, arg1, tbl2)
    end
end

local function doMount(arg1, arg2)
    if not arg1:IsA("TextChannelWindow") then
        return nil
    end

    if tbl1[arg1] then
        return nil
    end

    local layerCollector = arg1:FindFirstAncestorWhichIsA("LayerCollector")
    if layerCollector and not (layerCollector:IsA("ScreenGui") or layerCollector:IsA("SurfaceGui")) then
        return nil
    end

    local var1 = if FFlagExpChatTextChannelWindowFixLayerCollectorGeometry then createLayerCollectorOverlay.create(arg1, layerCollector) else createOverlay(arg1, layerCollector)
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.fromOffset(arg1.AbsolutePosition.X, arg1.AbsolutePosition.Y)
    frame.Size = UDim2.fromOffset(arg1.AbsoluteSize.X, arg1.AbsoluteSize.Y)
    frame.Rotation = arg1.Rotation
    frame.Parent = var1

    local root = ReactRoblox.createRoot(frame)
    root:render(arg2)

    local tbl2 = {}

    connectGuiObjectSync(arg1, frame, var1, tbl2)
    if FFlagExpChatTextChannelWindowFixLayerCollectorGeometry then
        createLayerCollectorOverlay.connect(layerCollector, var1, tbl2)
    else
        connectLayerCollectorSync(layerCollector, var1, tbl2)
    end

    local function updateEnabled() -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = var1
        local isRendering = arg1.IsRendering

        if isRendering then
            if arg1.AbsoluteSize.X >= num1 then
                local absoluteSizeY = arg1.AbsoluteSize.Y
                isRendering = num2 <= absoluteSizeY
            else
                isRendering = false
            end
        end

        var2.Enabled = isRendering
    end

    updateEnabled()
    local isRenderingChanged = arg1:GetPropertyChangedSignal("IsRendering")
    table.insert(tbl2, isRenderingChanged:Connect(updateEnabled))
    local absoluteSizeChanged = arg1:GetPropertyChangedSignal("AbsoluteSize")
    table.insert(tbl2, absoluteSizeChanged:Connect(updateEnabled))

    local function unmount()
        for _, value in tbl2 do
            value:Disconnect()
        end
        root:unmount()
        var1:Destroy()
        tbl1[arg1] = nil
    end

    local destroying = arg1.Destroying
    table.insert(tbl2, destroying:Connect(unmount))

    tbl1[arg1] = true
    return unmount
end

local function mountToTargetInstance(arg1, arg2)
    if arg1:IsDescendantOf(StarterGui) then
        return nil
    end

    return (doMount(arg1, arg2))
end

return mountToTargetInstance
