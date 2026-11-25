-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUi = script:FindFirstAncestor("VrSpatialUi")
local GuiService = game:GetService("GuiService")
local VrSpatialUiParent = VrSpatialUi.Parent
local UIBlox = require(VrSpatialUiParent.UIBlox)
local React = require(VrSpatialUiParent.React)
local __subscribeToBinding = React.__subscribeToBinding
local Constants = UIBlox.Core.VR.Constants
local Panel3D = UIBlox.Core.VR.Panel3D

local UIManager = require(VrSpatialUi.UIManager)
local _Constants = require(VrSpatialUi.Constants)
local registerRoactPanel = require(VrSpatialUi.registerRoactPanel)
local useHeadScale = require(VrSpatialUi.Hooks.useHeadScale)
local InExperienceUIVRIXP = require(VrSpatialUiParent.SharedExperimentDefinition).InExperienceUIVRIXP

return React.memo(function(tbl1) -- name: Panel3DInSpatialUI
    local scaledPartSizeInPixel = UIManager.getInstance():getScaledPartSizeInPixel(tbl1.panelType)
    local panelSizeInPixel = UIManager.getInstance():getPanelSizeInPixel(tbl1.panelType)
    local partRef = if InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then React.useRef(nil) else nil
    local var2, _ = useHeadScale(partRef, scaledPartSizeInPixel)

    local var3 = nil
    local createElement = React.createElement
    local var4 = Panel3D
    local tbl2 = {
        panelName = tbl1.panelType,
        partRef = partRef,
        partSize = 0,
        virtualScreenSize = 0,
        offset = 0,
        lerp = true,
        tilt = 0,
        anchoring = 0,
        faceCamera = true,
        curvature = 0,
        parent = 0,
        connectPanelManagerFunction = 0,
        zOffset = 0
    }

    if not InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then
        scaledPartSizeInPixel *= var2
    end

    tbl2.partSize = scaledPartSizeInPixel
    tbl2.virtualScreenSize = if InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then panelSizeInPixel else panelSizeInPixel * var2
    tbl2.offset = CFrame.new(0, 0, 0)

    tbl2.anchoring = Constants.AnchoringTypes.PanelManaged

    tbl2.parent = GuiService.CoreGuiFolder
    function tbl2.connectPanelManagerFunction(arg1)
        if not arg1 then
            if var3 then
                var3()
                var3 = nil
            end
            UIManager.getInstance():removeRoactPanel(tbl1.panelType)
            return
        end

        registerRoactPanel(arg1, tbl1.panelType, tbl1.visibilityObservable, tbl1.keepVisibleWhenTopBarHidden)

        if not tbl1.keepVisibleWhenTopBarHidden or not tbl1.controlsVisible or not arg1.current then
            return
        end

        local current = arg1.current
        local adornee = current.Adornee
        local active = current.Active
        local canQuery = adornee.CanQuery
        local function updateInput(bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
            current.Active = active and bool1
            adornee.CanQuery = canQuery and bool1
        end
        local var5 = __subscribeToBinding(tbl1.controlsVisible, updateInput)
        updateInput((tbl1.controlsVisible:getValue()))
        var3 = function()
            var5()
            local var6 = adornee
            local var1 = canQuery
            current.Active = active
            var6.CanQuery = var1
        end
    end
    tbl2.zOffset = tbl1.zOffset or 1
    local tbl3 = { ContentContainer = 0 }
    local var5

    if tbl1.requireCanvasGroup then
        local createElement2 = React.createElement
        local str1 = "CanvasGroup"
        local tbl4 = {
            BackgroundTransparency = 1,
            Name = "AnimatablePanelManagedContent",
            BorderSizePixel = 0,
            GroupTransparency = 0,
            Size = UDim2.new(1, 0, 1, 0)
        }
        local tbl5 = { Content = 0 }
        local renderFunction = tbl1.renderFunction
        if not InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then
            panelSizeInPixel *= var2
        end

        tbl5.Content = renderFunction(panelSizeInPixel)
        var5 = createElement2(str1, tbl4, tbl5)
    else
        local renderFunction = tbl1.renderFunction
        if not InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then
            panelSizeInPixel *= var2
        end

        var5 = renderFunction(panelSizeInPixel)
    end

    tbl3.ContentContainer = var5
    return createElement(var4, tbl2, tbl3)
end)
