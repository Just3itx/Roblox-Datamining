-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VRService = game:GetService("VRService")
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local scriptParent = script.Parent
local Constants = require(scriptParent.Constants)
local Utils = require(scriptParent.Utils)
local PanelType = Constants.PanelType
local SpatialUIType = Constants.SpatialUIType
local createCompatPanel = require(script.Parent.createCompatPanel)
local createUIGroupDragBar = require(script.Parent.createUIGroupDragBar)
local _DragBar = require(scriptParent.DragBar)
local Players = game:GetService("Players")
local num1 = game:DefineFastInt("FIntUIResetDelayInSec", 3)

local cFrame = CFrame.Angles(-math.rad(18), math.rad(10), 0)

local cFrame2 = CFrame.new(-0.46666666666666673, -0.8, -32 / 15)

local vector2 = Vector2.new(2.666666666666667, 1.866666666666667)

local var1 = cFrame2 * cFrame

local function getZAxisStablizedCFrame(cFrame3: CFrame) -- Luacid: Inlined by compiler; 5 call sites recovered
    local rx, ry, _ = cFrame3:ToOrientation()
    return CFrame.new(cFrame3.Position) * CFrame.fromOrientation(rx, ry, 0)
end

local function getCameraOffsetFromHeadRotationWithZAxisStabl(arg1): CFrame -- Luacid: unused: defined but never referenced
    local currentCameraCFrame = workspace.CurrentCamera.CFrame
    return currentCameraCFrame:ToObjectSpace(
        (getZAxisStablizedCFrame(((currentCameraCFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(arg1))))
    )
end

local function getPanelPart(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1.uiType == SpatialUIType.SpatialUI or arg1.uiType == SpatialUIType.SpatialUIRoact then
        return arg1.panelObject.Adornee
    end

    if arg1.uiType == SpatialUIType.SpatialUIPartOnly then
        return arg1.panelObject
    end

    return nil
end

local function panelExistsInSpace(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return not (arg1 == nil or arg1.panelObject == nil) and arg1.uiType ~= SpatialUIType.ScreenUI
end

local module = {}

local var2 = nil

module.__index = module

function module:removeRoactPanel(arg1)
    self.uiElements[arg1] = nil
end

function module:registerRoactPanel(arg1, arg2)
    self.uiElements[arg1] = arg2

    self:rescaleUIForCurrentHeadScale()
    self:updateUIGroupsForCurHeadCFrame()
end

function module:createUI(arg1)
    local compatPanel = createCompatPanel(arg1)
    if compatPanel == nil then
        return nil
    end
    self.uiElements[arg1.panelType] = compatPanel
    self:updatePanelForCurHeadCFrame(arg1.panelType)
    return {
        type = compatPanel.uiType,
        panelObject = compatPanel.panelObject
    }
end

function module:updateUIGroupForCurHeadCFrame(arg1, bool1: boolean?)
    local uiGroup = self.uiGroups[arg1]

    local uiGroupHeadRotation = uiGroup.positionProps.uiGroupHeadRotation
    local currentCameraCFrame = workspace.CurrentCamera.CFrame
    local cFrame3 = currentCameraCFrame:ToObjectSpace(
        (getZAxisStablizedCFrame(
            ((currentCameraCFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(uiGroupHeadRotation))
        ))
    )

    uiGroup.positionProps.uiGroupCameraOffSet = cFrame3
    if uiGroup.draggable and uiGroup.dragBar and not bool1 then
        uiGroup.dragBar:setCFrame(workspace.CurrentCamera.CFrame * cFrame3:ToWorldSpace(uiGroup.dragBarOffset))
    end

    self:updatePanelsInUIGroupForCurHeadCFrame(arg1)
end

function module:updateUIGroupsForCurHeadCFrame()
    for k, _ in pairs(self.uiGroups) do
        self:updateUIGroupForCurHeadCFrame(k)
    end
end

function module:updatePanelForCurHeadCFrame(arg1)
    local uiElement = self.uiElements[arg1]

    if not panelExistsInSpace(uiElement)
        or not uiElement.panelPositionProps
        or not uiElement.panelPositionProps.cameraFixedPanelProp
    then
        return
    end
    local panelPositionProps = uiElement.panelPositionProps
    local cameraFixedPanelProp = panelPositionProps.cameraFixedPanelProp

    local uiGroupHeadRotation = self.uiGroups[panelPositionProps.uiGroup].positionProps.uiGroupHeadRotation
    local currentCameraCFrame = workspace.CurrentCamera.CFrame
    local cFrame3 = currentCameraCFrame:ToObjectSpace(
        (getZAxisStablizedCFrame(
            ((currentCameraCFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(uiGroupHeadRotation))
        ))
    )
    local panelPart = getPanelPart(uiElement)

    if panelPart == nil then
        return
    end

    panelPart.CFrame = workspace.CurrentCamera.CFrame * cFrame3
    panelPart.CFrame = panelPart.CFrame:ToWorldSpace(cameraFixedPanelProp.uiGroupElementOffset)
end

function module:updatePanelsInUIGroupForCurHeadCFrame(uiGroup)
    for k, uiElement in pairs(self.uiElements) do
        if uiElement.panelPositionProps and uiElement.panelPositionProps.uiGroup == uiGroup then
            self:updatePanelForCurHeadCFrame(k)
        end
    end
end

function module:updatePanelsForCurHeadCFrame()
    for k, _ in pairs(self.uiElements) do
        self:updatePanelForCurHeadCFrame(k)
    end
end

function module:dragUiGroupStart(arg1)
    if self.uiGroups[arg1].draggable == false then
        return
    end
    local dragBar = self.uiGroups[arg1].dragBar
    local cFrame3 = workspace.CurrentCamera.CFrame:ToWorldSpace(self.uiGroups[arg1].positionProps.uiGroupCameraOffSet)

    dragBar:startDrag((dragBar:getCFrame():ToObjectSpace(cFrame3)))
end

function module:dragUiGroupEnd(arg1)
    if self.uiGroups[arg1].draggable == false then
        return
    end
    self.uiGroups[arg1].dragBar:dragEnd()
end

function module:dragUiGroupStep(arg1)
    if self.uiGroups[arg1].draggable == false then
        return
    end
    local dragBar = self.uiGroups[arg1].dragBar

    local var3 = workspace.CurrentCamera.CFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)

    local cFrame3 = dragBar:getCFrame()

    local vec3 = Vector3.new(var3.Position.X, var3.Position.Y - 0.6666666666666667, var3.Position.Z)
    local rx, ry, _ = (CFrame.lookAt(cFrame3.Position, vec3) * CFrame.Angles(0, math.pi, 0)):ToEulerAnglesXYZ()
    local _, _, rz = cFrame3:ToEulerAnglesXYZ()
    dragBar:setCFrame((getZAxisStablizedCFrame(CFrame.new(cFrame3.Position) * CFrame.Angles(rx, ry, rz))))

    local var4 = dragBar:getCFrame():ToWorldSpace(dragBar.uiGroupOffSet)
    self.uiGroups[arg1].positionProps.uiGroupHeadRotation = var3:ToObjectSpace(var4)
    self:updateUIGroupForCurHeadCFrame(arg1, true)
end

function module:setUpUiGroups()
    local dragBar = createUIGroupDragBar({
        name = "MainUIGroup",
        dragFunction = function(_, _, _, _, _)
            self:dragUiGroupStep(Constants.SpatialUIGroupType.MainUIGroup)
        end,
        dragStartFunction = function(_, _, _, _, _, _, _)
            self:dragUiGroupStart(Constants.SpatialUIGroupType.MainUIGroup)
        end,
        dragEndFunction = function(_)
            self:dragUiGroupEnd(Constants.SpatialUIGroupType.MainUIGroup)
        end
    })
    local tbl1 = {
        positionProps = 0,
        uiContainerSize = 0,
        draggable = true,
        dragBar = 0,
        dragBarOffset = 0,
        headScale = 1
    }
    local positionProps = {
        uiGroupHeadRotation = var1,
        uiGroupCameraOffSet = 0,
        defaultGroupHeadRotation = 0
    }
    local var3 = var1
    local currentCameraCFrame = workspace.CurrentCamera.CFrame
    positionProps.uiGroupCameraOffSet = currentCameraCFrame:ToObjectSpace(
        (getZAxisStablizedCFrame(((currentCameraCFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(var3))))
    )
    positionProps.defaultGroupHeadRotation = var1
    tbl1.positionProps = positionProps

    tbl1.uiContainerSize = vector2

    tbl1.dragBar = dragBar
    tbl1.dragBarOffset = CFrame.new(0, Constants.ROACT_PANEL_UIGROUP_ELEMENT_OFFSET_MAP[PanelType.BottomBar].Y - 0.075 - 1 / 15, 0)

    self.uiGroups[Constants.SpatialUIGroupType.MainUIGroup] = tbl1
end

function module:step()
    if not VRService.VREnabled then
        return
    end

    for k, uiElement in pairs(self.uiElements) do
        if not panelExistsInSpace(uiElement) or k ~= PanelType.RobloxGui then
            continue
        end

        local var3 = if uiElement.uiType == SpatialUIType.SpatialUI then uiElement.panelObject.Adornee else uiElement.panelObject
        local var4, var5, _ = var3.CFrame:ToOrientation()
        local var6, var7, _ = (workspace.CurrentCamera.CFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToOrientation()

        if math.abs(var5 - var7) > math.rad(100) or math.abs(var4 - var6) > math.rad(100) then
            if self.uiGroupsOutOfViewTimeStamp then
                if os.clock() - self.uiGroupsOutOfViewTimeStamp >= num1 then
                    self:updateUIGroupsForCurHeadCFrame()
                    self.uiGroupsOutOfViewTimeStamp = nil
                end
            else
                self.uiGroupsOutOfViewTimeStamp = os.clock()
            end
        else
            self.uiGroupsOutOfViewTimeStamp = nil
        end
    end
end

function module:onShowTopBarChanged()
    if not VRService.VREnabled then
        return
    end

    if VRHub.ShowTopBar then
        for _, uiGroup in pairs(self.uiGroups) do
            if uiGroup.draggable and uiGroup.dragBar then
                uiGroup.dragBar:show()
            end
        end
        for _, uiElement in pairs(self.uiElements) do
            if uiElement.uiType == SpatialUIType.SpatialUI or uiElement.uiType == SpatialUIType.SpatialUIRoact then
                local panelObject = uiElement.panelObject
                panelObject.Enabled = true
                panelObject.Adornee.Parent = workspace
            elseif uiElement.uiType == SpatialUIType.SpatialUIPartOnly then
                uiElement.panelObject.Parent = workspace
            end
        end
    else
        for _, uiGroup in pairs(self.uiGroups) do
            if uiGroup.draggable and uiGroup.dragBar then
                uiGroup.dragBar:hide()
            end
        end
        for _, uiElement in pairs(self.uiElements) do
            if uiElement.uiType == SpatialUIType.SpatialUI or uiElement.uiType == SpatialUIType.SpatialUIRoact then
                local panelObject = uiElement.panelObject
                panelObject.Enabled = false
                panelObject.Adornee.Parent = nil
            elseif uiElement.uiType == SpatialUIType.SpatialUIPartOnly then
                uiElement.panelObject.Parent = nil
            end
        end
    end
end

function module:updateUIGroupsForCurCamera()
    if not VRService.VREnabled then
        return
    end
    for _, uiGroup in pairs(self.uiGroups) do
        if uiGroup.draggable then
            uiGroup.dragBar:setCFrame(
                workspace.CurrentCamera.CFrame * uiGroup.positionProps.uiGroupCameraOffSet:ToWorldSpace(uiGroup.dragBarOffset)
            )
        end
    end

    for _, uiElement in pairs(self.uiElements) do
        if not (panelExistsInSpace(uiElement) and uiElement.panelPositionProps and uiElement.panelPositionProps.cameraFixedPanelProp) then
            continue
        end
        local panelPositionProps = uiElement.panelPositionProps
        local cameraFixedPanelProp = panelPositionProps.cameraFixedPanelProp
        local panelPart = getPanelPart(uiElement)

        if panelPart == nil then
            return
        end

        panelPart.CFrame = workspace.CurrentCamera.CFrame * self.uiGroups[panelPositionProps.uiGroup].positionProps.uiGroupCameraOffSet:ToWorldSpace(
            cameraFixedPanelProp.uiGroupElementOffset
        )
    end
end

function module:onMouseTargetChanged(part)
    for _, uiGroup in pairs(self.uiGroups) do
        if not uiGroup.draggable then
            continue
        end
        if uiGroup.dragBar and uiGroup.dragBar.part == part then
            uiGroup.dragBar:startHover()
        elseif uiGroup.dragBar and uiGroup.dragBar.part ~= part then
            uiGroup.dragBar:hoverEnd()
        end
    end
end

function module:rescaleUIForCurrentHeadScale()
    local headScale = workspace.CurrentCamera.HeadScale

    for _, uiGroup in pairs(self.uiGroups) do
        local var3 = headScale / uiGroup.headScale
        uiGroup.positionProps.uiGroupHeadRotation = Utils.rescaleCFramePosition(uiGroup.positionProps.uiGroupHeadRotation, var3)
        uiGroup.positionProps.uiGroupCameraOffSet = Utils.rescaleCFramePosition(uiGroup.positionProps.uiGroupCameraOffSet, var3)
        uiGroup.positionProps.defaultGroupHeadRotation = Utils.rescaleCFramePosition(uiGroup.positionProps.defaultGroupHeadRotation, var3)
        if uiGroup.draggable then
            uiGroup.dragBarOffset = Utils.rescaleCFramePosition(uiGroup.dragBarOffset, var3)
            uiGroup.dragBar:rescale(var3)
        end
        uiGroup.headScale = headScale
    end
    for _, uiElement in pairs(self.uiElements) do
        local var3 = headScale / uiElement.headScale

        if uiElement.uiType ~= SpatialUIType.SpatialUIRoact then
            local panelPart = getPanelPart(uiElement)

            if panelPart ~= nil then
                panelPart.Size *= var3
            end
        end
        local panelPositionProps = uiElement.panelPositionProps
        if panelPositionProps and panelPositionProps.cameraFixedPanelProp then
            panelPositionProps.cameraFixedPanelProp.uiGroupElementOffset = Utils.rescaleCFramePosition(panelPositionProps.cameraFixedPanelProp.uiGroupElementOffset, var3)
        end

        uiElement.headScale = headScale
    end
end

function module.new()
    local tbl1 = {
        currentMouseTarget = nil,
        uiGroupsOutOfViewTimeStamp = nil,
        uiElements = {},
        uiGroups = {}
    }

    setmetatable(tbl1, module)

    tbl1:setUpUiGroups()
    tbl1:rescaleUIForCurrentHeadScale()
    tbl1:updateUIGroupsForCurCamera()

    RunService:BindToRenderStep("UIManagerRenderStep", Enum.RenderPriority.Last.Value, function()
        tbl1:step()
    end)

    VRHub.ShowTopBarChanged.Event:connect(function()
        tbl1:onShowTopBarChanged()
    end)

    local currentCamera = workspace.CurrentCamera
    currentCamera:GetPropertyChangedSignal("CFrame"):Connect(function()
        tbl1:updateUIGroupsForCurCamera()
    end)

    currentCamera:GetPropertyChangedSignal("HeadScale"):Connect(function()
        tbl1:rescaleUIForCurrentHeadScale()
        tbl1:updateUIGroupsForCurHeadCFrame()
    end)

    local mouse = Players.LocalPlayer:GetMouse()
    if mouse then
        mouse.Move:Connect(function()
            local mouse2 = Players.LocalPlayer:GetMouse()
            if mouse2.Target ~= tbl1.currentMouseTarget then
                tbl1:onMouseTargetChanged(mouse2.Target)
                tbl1.currentMouseTarget = mouse2.Target
            end
        end)
    end

    return tbl1
end

function module.getInstance()
    if var2 == nil then
        var2 = module.new()
    end
    return var2
end

return module
