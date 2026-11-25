-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUi = script:FindFirstAncestor("VrSpatialUi")
local VrSpatialUiParent = VrSpatialUi.Parent
local CoreGui = game:GetService("CoreGui")

local engineFeature = game:GetEngineFeature("CurvedSurfaceGuisEnabled")
local FFlagSpatialUIHiddenPanelRaycastFix = require(VrSpatialUi.Flags.FFlagSpatialUIHiddenPanelRaycastFix)
local Constants = require(VrSpatialUi.Constants)
local SpatialUIType = Constants.SpatialUIType
local Object = require(VrSpatialUiParent.LuauPolyfill).Object
local VRService = game:GetService("VRService")

local tbl1 = {
    spatialPanelProps = nil,
    screenGuiProps = nil,
    type = SpatialUIType.ScreenUI
}

local tbl2 = { Name = "ScreenGui", ResetOnSpawn = false, DisplayOrder = 0, ZIndexBehavior = nil }

local tbl3 = {
    name = "",
    partSize = Constants.DEFAULT_VR_PANEL_SIZE,
    virtualScreenSize = Constants.DEFAULT_VR_PANEL_SIZE * Constants.VR_PANEL_RESOLUTION_MULTIPLIER,
    cframe = CFrame.new(0, 0, 0),
    alwaysOnTop = true,
    hidden = false,
    curvature = 1,
    transparency = 1
}

local function createPanelPart(arg1): Part
    local part = Instance.new("Part")
    part.Name = arg1.name .. "_Part"
    part.CFrame = arg1.cframe
    part.CastShadow = false
    part.Size = Vector3.new(arg1.partSize.X, arg1.partSize.Y, 0.002)
    part.Transparency = if arg1.transparency then arg1.transparency else 1
    part.Color = Color3.new(0, 0, 0)
    part.CanCollide = false
    part.CanTouch = false
    part.Anchored = true
    part.Parent = workspace
    return part
end

local function createPanel(arg1)
    local var1 = Object.assign({}, tbl1, arg1)
    if var1.type == SpatialUIType.SpatialUIPartOnly then
        local var2 = Object.assign({}, tbl3, var1.spatialPanelProps)
        local part = createPanelPart(var2)
        if FFlagSpatialUIHiddenPanelRaycastFix then
            part.CanQuery = false
        end
        return {
            type = var1.type,
            panelObject = part
        }
    end

    if var1.type ~= SpatialUIType.SpatialUI then
        if var1.type ~= SpatialUIType.ScreenUI then
            print("Invalid panel type: " .. tostring(var1.type))
            return nil
        end

        local var2 = Object.assign({}, tbl2, var1.screenGuiProps)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = CoreGui
        screenGui.Name = var2.Name
        screenGui.ResetOnSpawn = var2.ResetOnSpawn
        screenGui.DisplayOrder = var2.DisplayOrder
        if var2.ZIndexBehavior then
            screenGui.ZIndexBehavior = var2.ZIndexBehavior
        end
        return {
            type = var1.type,
            panelObject = screenGui
        }
    end

    local var2 = Object.assign({}, tbl3, var1.spatialPanelProps)
    local part = createPanelPart(var2)
    local surfaceGui = Instance.new("SurfaceGui")
    surfaceGui.Parent = CoreGui
    surfaceGui.Name = var2.name .. "_SurfaceGui"
    surfaceGui.Enabled = not var2.hidden
    surfaceGui.CanvasSize = var2.virtualScreenSize
    surfaceGui.AlwaysOnTop = var2.alwaysOnTop
    surfaceGui.Shape = if engineFeature and var2.curvature ~= 0 then Enum.SurfaceGuiShape.CurvedHorizontally else Enum.SurfaceGuiShape.Flat

    surfaceGui.HorizontalCurvature = if engineFeature then var2.curvature else 0
    surfaceGui.Active = true
    surfaceGui.Adornee = part
    surfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    surfaceGui.LightInfluence = 0
    surfaceGui.ZOffset = 0
    surfaceGui.Face = Enum.NormalId.Back
    return {
        type = var1.type,
        panelObject = surfaceGui
    }
end

return function(arg1)
    if VRService.VREnabled then
        local panel = createPanel(Constants.COMPAT_PANEL_PROPS_MAP[arg1.panelType])

        if panel == nil then
            return nil
        end

        return {
            panelObject = panel.panelObject,
            uiType = panel.type,
            panelType = arg1.panelType,
            panelPositionProps = Constants.SPATIAL_PANEL_POSITION_PROPS_MAP[arg1.panelType],
            headScale = 1
        }
    end

    local panel = createPanel({ type = SpatialUIType.ScreenUI, screenGuiProps = arg1.screenGuiProps })

    if panel == nil then
        return nil
    end

    return {
        panelObject = panel.panelObject,
        uiType = panel.type,
        panelType = arg1.panelType,
        panelPositionProps = nil
    }
end
