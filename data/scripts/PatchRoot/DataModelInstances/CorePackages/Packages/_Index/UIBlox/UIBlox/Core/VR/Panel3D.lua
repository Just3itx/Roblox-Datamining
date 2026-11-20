-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local scriptParent = script.Parent
local Constants = require(scriptParent.Constants)
local usePanel3DRenderStep = require(scriptParent.usePanel3DRenderStep)

local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local React = require(scriptParentParentParentParent.React)
local Roact = require(scriptParentParentParentParent.Roact)
local Object = require(scriptParentParentParentParent.LuauPolyfill).Object
local var1 = require(scriptParentParentParent.Core.Utility.GetEngineFeatureSafe)("CurvedSurfaceGuisEnabled")

local tbl1 = {
    partSize = Vector2.new(10, 10),
    virtualScreenSize = Vector2.new(10, 10),
    offset = CFrame.new(0, 0, 0),
    lerp = false,
    tilt = 0,
    anchoring = Constants.AnchoringTypes.World,
    faceCamera = false,
    panelName = "PanelBase",
    movementUpdateEvent = RunService.RenderStepped,
    vrService = game:GetService("VRService"),
    alwaysOnTop = true,
    parent = workspace,
    hidden = false,
    curvature = 1,
    zOffset = 0,
    connectPanelManagerFunction = nil,
    partRef = nil
}

local function Panel3D(arg1)
    local var2 = Object.assign({}, tbl1, arg1)

    local var3 = var2.partRef or React.useRef(nil)
    local ref = React.useRef(nil)
    local var4 = React.useRef(nil)

    usePanel3DRenderStep(var2, var3)
    React.useEffect(function()
        if var2.anchoring ~= Constants.AnchoringTypes.PanelManaged then
            return function() end
        end

        if var2.connectPanelManagerFunction == nil then
            return function() end
        end

        if ref == nil or not var2.connectPanelManagerFunction then
            return function() end
        end

        var2.connectPanelManagerFunction(ref)
        return function()
            var2.connectPanelManagerFunction(nil)
        end
    end, { ref, var2.anchoring, var2.connectPanelManagerFunction })

    local createElement = React.createElement
    local str1 = "Folder"
    local tbl2 = { ref = var4, Archivable = false }

    local tbl3 = { WorkspacePortal = 0, AppUI = 0 }
    local createElement2 = React.createElement
    local portal = Roact.Portal
    local tbl4 = {
        target = var2.parent
    }
    local tbl5 = { GUIPart = 0 }
    local element

    if var2.hidden then
        element = nil
    else
        element = React.createElement("Part", {
            Name = var2.panelName .. "_Part",
            ref = var3,
            Anchored = true,
            CFrame = var2.offset * CFrame.Angles(math.rad(var2.tilt), 0, 0),
            Size = Vector3.new(var2.partSize.X, var2.partSize.Y, 0.05),
            Transparency = 1,
            Color = Color3.new(0, 0, 0),
            CanCollide = false,
            CanTouch = false
        })
    end

    tbl5.GUIPart = element
    tbl3.WorkspacePortal = createElement2(portal, tbl4, tbl5)

    tbl3.AppUI = React.createElement("SurfaceGui", {
        Name = var2.panelName .. "_SurfaceGui",
        ref = ref,
        Adornee = var3,
        Active = true,
        Enabled = not var2.hidden,
        CanvasSize = var2.virtualScreenSize,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        LightInfluence = 0,
        children = var2.children,
        AlwaysOnTop = var2.alwaysOnTop,
        Shape = if var1 and var2.curvature ~= 0 then Enum.SurfaceGuiShape.CurvedHorizontally else nil,
        HorizontalCurvature = if var1 then var2.curvature else nil,
        ZOffset = var2.zOffset
    })
    return createElement(str1, tbl2, tbl3)
end

return Panel3D
