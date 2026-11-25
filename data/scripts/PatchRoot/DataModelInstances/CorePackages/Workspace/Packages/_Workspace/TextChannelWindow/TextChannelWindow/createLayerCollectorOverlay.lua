-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local function getEffectiveAdornee(surfaceGui: SurfaceGui) -- Luacid: Inlined by compiler; 2 call sites recovered
    if surfaceGui.Adornee ~= nil then
        return surfaceGui.Adornee
    end
    local surfaceGuiParent = surfaceGui.Parent
    return if surfaceGuiParent and surfaceGuiParent:IsA("BasePart") then surfaceGuiParent else nil
end

local function connectSurfaceGuiSync(surfaceGui: SurfaceGui, arg1, tbl1)
    local function syncAdornee()
        arg1.Adornee = getEffectiveAdornee(surfaceGui)
    end
    table.insert(tbl1, surfaceGui:GetPropertyChangedSignal("Adornee"):Connect(syncAdornee))

    table.insert(tbl1, surfaceGui:GetPropertyChangedSignal("Parent"):Connect(syncAdornee))

    local faceChanged = surfaceGui:GetPropertyChangedSignal("Face")

    table.insert(tbl1, faceChanged:Connect(function()
        arg1.Face = surfaceGui.Face
    end))

    local sizingModeChanged = surfaceGui:GetPropertyChangedSignal("SizingMode")

    table.insert(tbl1, sizingModeChanged:Connect(function()
        arg1.SizingMode = surfaceGui.SizingMode

        arg1.CanvasSize = surfaceGui.CanvasSize
        arg1.PixelsPerStud = surfaceGui.PixelsPerStud
    end))

    local canvasSizeChanged = surfaceGui:GetPropertyChangedSignal("CanvasSize")

    table.insert(tbl1, canvasSizeChanged:Connect(function()
        arg1.CanvasSize = surfaceGui.CanvasSize
    end))

    local pixelsPerStudChanged = surfaceGui:GetPropertyChangedSignal("PixelsPerStud")

    table.insert(tbl1, pixelsPerStudChanged:Connect(function()
        arg1.PixelsPerStud = surfaceGui.PixelsPerStud
    end))
end

local function connectScreenGuiSync(screenGui: ScreenGui, arg1, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local zIndexBehaviorChanged = screenGui:GetPropertyChangedSignal("ZIndexBehavior")

    table.insert(tbl1, zIndexBehaviorChanged:Connect(function()
        arg1.ZIndexBehavior = screenGui.ZIndexBehavior
    end))
end

return {
    create = function(arg1, arg2): ScreenGui | SurfaceGui
        if arg2 and arg2:IsA("SurfaceGui") then
            local surfaceGui = Instance.new("SurfaceGui")
            surfaceGui.Name = "TextChannelWindowOverlay_" .. arg1.Name
            surfaceGui.ResetOnSpawn = false
            surfaceGui.Adornee = getEffectiveAdornee(arg2)
            surfaceGui.Face = arg2.Face
            surfaceGui.SizingMode = arg2.SizingMode
            surfaceGui.CanvasSize = arg2.CanvasSize

            surfaceGui.PixelsPerStud = arg2.PixelsPerStud
            surfaceGui.Parent = CoreGui
            return surfaceGui
        end

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "TextChannelWindowOverlay_" .. arg1.Name
        screenGui.ResetOnSpawn = false
        if arg2 and arg2:IsA("ScreenGui") then
            screenGui.IgnoreGuiInset = false
            screenGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
            screenGui.DisplayOrder = -1
            screenGui.ZIndexBehavior = arg2.ZIndexBehavior
        else
            screenGui.IgnoreGuiInset = true
            screenGui.DisplayOrder = -1
            screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        end
        screenGui.Parent = CoreGui
        return screenGui
    end,
    connect = function(arg1, arg2, tbl1)
        if arg1 == nil then
            return
        end

        if arg1:IsA("SurfaceGui") then
            connectSurfaceGuiSync(arg1, arg2, tbl1)
        elseif arg1:IsA("ScreenGui") then
            connectScreenGuiSync(arg1, arg2, tbl1)
        end
    end
}
