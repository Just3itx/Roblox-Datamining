-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUi = script:FindFirstAncestor("VrSpatialUi")
local VrSpatialUiParent = VrSpatialUi.Parent
local Observable = require(VrSpatialUiParent.Observable)
local VRService = game:GetService("VRService")
local RunService = game:GetService("RunService")
local isInExperienceUIVREnabled = require(VrSpatialUiParent.SharedExperimentDefinition).isInExperienceUIVREnabled
local InExperienceUIVRIXP = require(VrSpatialUiParent.SharedExperimentDefinition).InExperienceUIVRIXP
local VRHub = if isInExperienceUIVREnabled then nil else require(VrSpatialUiParent.VrCommon).VRHub

local Constants = require(VrSpatialUi.Constants)
local Utils = require(VrSpatialUi.Utils)
local PanelType = Constants.PanelType
local SpatialUIType = Constants.SpatialUIType
local createCompatPanel = require(script.Parent.createCompatPanel)
local createUIGroupDragBar = require(script.Parent.createUIGroupDragBar)
local _DragBar = require(VrSpatialUi.DragBar)
local UIGroupHelper = nil
local StableCameraCache = nil
if isInExperienceUIVREnabled then
    UIGroupHelper = require(VrSpatialUi.UIGroupHelper)
    StableCameraCache = require(VrSpatialUi.StableCameraCache)
end
local Players = game:GetService("Players")
local num1 = game:DefineFastInt("FIntUIResetDelayInSec", 3)
local num2 = game:DefineFastInt("SpatialUIPanelDistance", 64)
local bool1 = game:DefineFastFlag("SpatialUIEnablePanelsRefocusing", false)
local bool2 = game:DefineFastFlag("SpatialUIDisableBottomBarFading", false)

local bool3 = game:DefineFastFlag("SpatialUIDisableBottomBarInteractionOnAnimating", false)
local bool4 = game:DefineFastFlag("VRSpatialUIGuardNilHeadScale", false)
local cFrame = if isInExperienceUIVREnabled then CFrame.Angles(0, 0, 0) else CFrame.Angles(-math.rad(18), math.rad(10), 0)
local var1

if isInExperienceUIVREnabled then
    local num3 = math.min(math.max(num2, 0), 500) / 100
    var1 = CFrame.new(0, 0, num3 * -1 * (10 / 3))
else
    var1 = CFrame.new(-0.46666666666666673, -0.8, -32 / 15)
end

local vector2 = Vector2.new(2.666666666666667, 1.866666666666667)

local var2 = var1 * cFrame

local function getZAxisStablizedCFrame(cFrame2: CFrame) -- Luacid: Inlined by compiler; 6 call sites recovered
    local rx, ry, _ = cFrame2:ToOrientation()
    return CFrame.new(cFrame2.Position) * CFrame.fromOrientation(rx, ry, 0)
end

local function getCameraOffsetFromHeadRotationWithZAxisStabl(arg1, cFrame2: CFrame?) -- Luacid: unused: defined but never referenced
    local var3 = cFrame2 or workspace.CurrentCamera.CFrame
    return var3:ToObjectSpace(
        (getZAxisStablizedCFrame(((var3 * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(arg1))))
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

function createUIGroup(arg1, arg2, bool5: boolean?)
    local uiGroupHelper = arg1.uiGroupHelper
    local vector2_2 = vector2
    local tbl1 = {
        uiGroupHeadRotation = var2,
        uiGroupCameraOffSet = 0,
        defaultGroupHeadRotation = 0
    }
    local var3 = var2
    local currentCameraCFrame = workspace.CurrentCamera.CFrame
    tbl1.uiGroupCameraOffSet = currentCameraCFrame:ToObjectSpace(
        (getZAxisStablizedCFrame(((currentCameraCFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(var3))))
    )
    tbl1.defaultGroupHeadRotation = var2
    local var4 = uiGroupHelper:createUIGroup(arg1, arg2, vector2_2, tbl1, arg1.uiElements, bool5)
    arg1.uiGroups[arg2] = var4
end

local module = {}

local var3 = nil

module.__index = module

function module:removeRoactPanel(arg1)
    if isInExperienceUIVREnabled then
        self:disconnectPanelVisibility(arg1)
    end
    self.uiElements[arg1] = nil
end

function module:registerRoactPanel(arg1, arg2, arg3)
    self.uiElements[arg1] = arg2

    if isInExperienceUIVREnabled then
        local var4 = self.uiGroupHelper:checkAndGetUIGroupTypeForTempPanel(arg1, self.uiElements)
        if var4 ~= nil then
            self:rescaleUIForCurrentHeadScale(var4, arg1)
            if InExperienceUIVRIXP:isSpatialUICameraTypeFixEnabled() then
                self:updateUIGroupsForCurCamera(arg1, (self.stableCameraCache:getCurrentStableCameraCFrame()))
            else
                self:updateUIGroupsForCurCamera(arg1)
            end
        else
            self:rescaleUIForCurrentHeadScale()
            self:updateUIGroupsForCurHeadCFrame()
        end
    else
        self:rescaleUIForCurrentHeadScale()
        self:updateUIGroupsForCurHeadCFrame()
    end
    if not isInExperienceUIVREnabled then
        return
    end

    self:connectPanelVisibility(arg1, arg3 or Observable.ObservableValue.new(true))

    if arg2.keepVisibleWhenTopBarHidden ~= nil then
        self.uiGroupHelper:updateAllElements(self.uiElements, self.uiGroups)
    end
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

function module:getPanelObject(arg1)
    local uiElement = self.uiElements[arg1]
    return if uiElement then uiElement.panelObject else nil
end

function module.getPanelSizeInPixel(arg1, arg2)
    return arg1:getScaledPartSizeInPixel(arg2) * Constants.VR_PANEL_RESOLUTION_MULTIPLIER
end

function module.getScaledPartSizeInPixel(_, bottomBar)
    if bottomBar == PanelType.BottomBar then
        return Constants.BOTTOM_BAR_SIZE
    end
    local spatialPanelProps = Constants.COMPAT_PANEL_PROPS_MAP[bottomBar].spatialPanelProps
    if not spatialPanelProps then
        return Vector2.new(0, 0)
    end
    local partSize = spatialPanelProps.partSize
    return Vector2.new(partSize.X, partSize.Y)
end

function module:connectTopBarVisibility(arg1)
    self.uiGroupHelper:setTopBarVisible(arg1, function()
        self.uiGroupHelper:updateAllElements(self.uiElements, self.uiGroups)
    end)
end

function module:connectPanelVisibility(arg1, arg2)
    self.uiGroupHelper:connectPanelVisibility(arg1, arg2, self.uiElements, self.uiGroups)
end

function module:disconnectPanelVisibility(arg1)
    self.uiGroupHelper:disconnectPanelVisibility(arg1, self.uiElements, self.uiGroups)
end

function module:updateUIGroupForCurHeadCFrame(arg1, bool5: boolean?)
    local uiGroup = self.uiGroups[arg1]

    local uiGroupHeadRotation = uiGroup.positionProps.uiGroupHeadRotation
    local currentCameraCFrame = workspace.CurrentCamera.CFrame
    local cFrame2 = currentCameraCFrame:ToObjectSpace(
        (getZAxisStablizedCFrame(
            ((currentCameraCFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(uiGroupHeadRotation))
        ))
    )

    uiGroup.positionProps.uiGroupCameraOffSet = cFrame2
    if uiGroup.draggable and uiGroup.dragBar and not bool5 then
        uiGroup.dragBar:setCFrame(workspace.CurrentCamera.CFrame * cFrame2:ToWorldSpace(uiGroup.dragBarOffset))
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
    local cFrame2 = currentCameraCFrame:ToObjectSpace(
        (getZAxisStablizedCFrame(
            ((currentCameraCFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(uiGroupHeadRotation))
        ))
    )
    local panelPart = getPanelPart(uiElement)

    if panelPart == nil then
        return
    end

    panelPart.CFrame = workspace.CurrentCamera.CFrame * cFrame2
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
    local cFrame2 = workspace.CurrentCamera.CFrame:ToWorldSpace(self.uiGroups[arg1].positionProps.uiGroupCameraOffSet)

    dragBar:startDrag((dragBar:getCFrame():ToObjectSpace(cFrame2)))
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

    local var4 = workspace.CurrentCamera.CFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)

    local cFrame2 = dragBar:getCFrame()

    local vec3 = Vector3.new(var4.Position.X, var4.Position.Y - 0.6666666666666667, var4.Position.Z)
    local rx, ry, _ = (CFrame.lookAt(cFrame2.Position, vec3) * CFrame.Angles(0, math.pi, 0)):ToEulerAnglesXYZ()
    local _, _, rz = cFrame2:ToEulerAnglesXYZ()
    dragBar:setCFrame((getZAxisStablizedCFrame(CFrame.new(cFrame2.Position) * CFrame.Angles(rx, ry, rz))))

    local var5 = dragBar:getCFrame():ToWorldSpace(dragBar.uiGroupOffSet)
    self.uiGroups[arg1].positionProps.uiGroupHeadRotation = var4:ToObjectSpace(var5)
    self:updateUIGroupForCurHeadCFrame(arg1, true)
end

function module:setUpUiGroups(bool5: boolean?)
    if isInExperienceUIVREnabled then
        createUIGroup(self, Constants.SpatialUIGroupType.MainUIGroup, bool5)
        createUIGroup(self, Constants.SpatialUIGroupType.MenuUIGroup, bool5)
        createUIGroup(self, Constants.SpatialUIGroupType.ChatUIGroup, bool5)
        createUIGroup(self, Constants.SpatialUIGroupType.ChromeSubMenuUIGroup, bool5)
        self.uiGroupHelper:updateAllDragBar(self.uiElements, self.uiGroups)
        return
    end

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
        uiGroupHeadRotation = var2,
        uiGroupCameraOffSet = 0,
        defaultGroupHeadRotation = 0
    }
    local var4 = var2
    local currentCameraCFrame = workspace.CurrentCamera.CFrame
    positionProps.uiGroupCameraOffSet = currentCameraCFrame:ToObjectSpace(
        (getZAxisStablizedCFrame(((currentCameraCFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToWorldSpace(var4))))
    )
    positionProps.defaultGroupHeadRotation = var2
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

        local var4 = if uiElement.uiType == SpatialUIType.SpatialUI then uiElement.panelObject.Adornee else uiElement.panelObject
        local x, y, _ = var4.CFrame:ToOrientation()
        local x2, y2, _ = (workspace.CurrentCamera.CFrame * VRService:GetUserCFrame(Enum.UserCFrame.Head)):ToOrientation()

        if isInExperienceUIVREnabled and not bool2 and self.uiGroupHelper then
            self.uiGroupHelper:animateBottomBarOnHeadMoveIfNeeded(self.uiElements, Vector2.new(x, y), Vector2.new(x2, y2))
        end

        if isInExperienceUIVREnabled and bool1 and (math.abs(y - y2) > math.rad(100) or math.abs(x - x2) > math.rad(100)) then
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

function module:prepareGuiToggleAnimationState()
    if self.uiGroupHelper:isTopBarVisible() then
        self.uiGroupHelper:prepareGuiToggleAnimationState(self.uiElements)
    end
end

function module:onShowTopBarChanged()
    if isInExperienceUIVREnabled then
        return
    end

    if not VRService.VREnabled then
        return
    end

    if VRHub and VRHub.ShowTopBar then
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

function module:updateUIGroupsForCurCamera(arg1, cFrame2: CFrame?)
    if not VRService.VREnabled then
        return
    end
    for _, uiGroup in pairs(self.uiGroups) do
        if arg1 == nil and uiGroup.draggable then
            uiGroup.dragBar:setCFrame(
                (cFrame2 or workspace.CurrentCamera.CFrame) * uiGroup.positionProps.uiGroupCameraOffSet:ToWorldSpace(uiGroup.dragBarOffset)
            )
        end
    end

    for k, uiElement in pairs(self.uiElements) do
        if arg1 ~= nil and arg1 ~= k
            or not (panelExistsInSpace(uiElement) and uiElement.panelPositionProps and uiElement.panelPositionProps.cameraFixedPanelProp)
        then
            continue
        end
        local panelPositionProps = uiElement.panelPositionProps
        local cameraFixedPanelProp = panelPositionProps.cameraFixedPanelProp
        local panelPart = getPanelPart(uiElement)

        if panelPart == nil then
            return
        end
        local var4 = cFrame2 or workspace.CurrentCamera.CFrame
        if isInExperienceUIVREnabled and not InExperienceUIVRIXP:isSpatialUICameraTypeFixEnabled() then
            var4 = self.uiGroupHelper:getGroupCameraCFrameIfPossible(k, self.uiElements)
        end

        panelPart.CFrame = var4 * self.uiGroups[panelPositionProps.uiGroup].positionProps.uiGroupCameraOffSet:ToWorldSpace(
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

function module:resetDragAndDrop()
    for _, uiGroup in pairs(self.uiGroups) do
        if uiGroup.draggable and uiGroup.dragBar then
            uiGroup.dragBar:hide()
        end
    end
    self:setUpUiGroups(true)
    self:rescaleUIForCurrentHeadScale()
    self:updateUIGroupsForCurCamera()
end

function module:getAdditionalCameraScaleIfNeeded(): number
    return if VRService.VREnabled then workspace.CurrentCamera.HeadScale else 1
end

function module:rescaleUIForCurrentHeadScale(arg1, arg2)
    local headScale = if isInExperienceUIVREnabled then self:getAdditionalCameraScaleIfNeeded() else workspace.CurrentCamera.HeadScale

    for _, uiGroup in pairs(self.uiGroups) do
        if arg1 ~= nil then
            continue
        end

        local var5 = headScale / (if bool4 then uiGroup.headScale or headScale else uiGroup.headScale)

        uiGroup.positionProps.uiGroupHeadRotation = Utils.rescaleCFramePosition(uiGroup.positionProps.uiGroupHeadRotation, var5)
        uiGroup.positionProps.uiGroupCameraOffSet = Utils.rescaleCFramePosition(uiGroup.positionProps.uiGroupCameraOffSet, var5)
        uiGroup.positionProps.defaultGroupHeadRotation = Utils.rescaleCFramePosition(uiGroup.positionProps.defaultGroupHeadRotation, var5)
        if uiGroup.draggable then
            uiGroup.dragBarOffset = Utils.rescaleCFramePosition(uiGroup.dragBarOffset, var5)
            uiGroup.dragBar:rescale(var5)
        end
        uiGroup.headScale = headScale
        if isInExperienceUIVREnabled then
            uiGroup.lastCameraCFrame = workspace.CurrentCamera.CFrame
        end
    end

    for k, uiElement in pairs(self.uiElements) do
        if arg2 ~= nil and arg2 ~= k then
            continue
        end

        local var5 = headScale / (if bool4 then uiElement.headScale or headScale else uiElement.headScale)

        if uiElement.uiType ~= SpatialUIType.SpatialUIRoact then
            local panelPart = getPanelPart(uiElement)

            if panelPart ~= nil then
                panelPart.Size *= var5
            end
        end
        local panelPositionProps = uiElement.panelPositionProps
        if panelPositionProps and panelPositionProps.cameraFixedPanelProp then
            panelPositionProps.cameraFixedPanelProp.uiGroupElementOffset = Utils.rescaleCFramePosition(panelPositionProps.cameraFixedPanelProp.uiGroupElementOffset, var5)
        end

        uiElement.headScale = headScale
    end
end

function module.new()
    local tbl1 = {
        currentMouseTarget = nil,
        uiGroupsOutOfViewTimeStamp = nil,
        uiElements = {},
        uiGroups = {},
        uiGroupHelper = {},
        stableCameraCache = {}
    }
    if isInExperienceUIVREnabled then
        tbl1.uiGroupHelper = UIGroupHelper.new(false)
        tbl1.stableCameraCache = StableCameraCache.new()
    end
    setmetatable(tbl1, module)

    tbl1:setUpUiGroups()
    tbl1:rescaleUIForCurrentHeadScale()
    tbl1:updateUIGroupsForCurCamera()

    RunService:BindToRenderStep("UIManagerRenderStep", Enum.RenderPriority.Last.Value, function()
        tbl1:step()
    end)

    if not isInExperienceUIVREnabled and VRHub then
        VRHub.ShowTopBarChanged.Event:connect(function()
            tbl1:onShowTopBarChanged()
        end)
    end

    local currentCamera = workspace.CurrentCamera
    currentCamera:GetPropertyChangedSignal("CFrame"):Connect(function()
        if isInExperienceUIVREnabled and InExperienceUIVRIXP:isSpatialUICameraTypeFixEnabled() then
            if tbl1.stableCameraCache:updateAndCheckCameraMoved() then
                tbl1:updateUIGroupsForCurCamera(nil, (tbl1.stableCameraCache:getCurrentStableCameraCFrame()))
            end
        else
            tbl1:updateUIGroupsForCurCamera()
        end
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

function module:getBottomBarVisibility()
    if bool3 then
        return nil
    end
    return self.uiGroupHelper:getBottomBarVisibility()
end

function module:isBottomBarInteractionOnAnimationSupported()
    if bool3 then
        return false
    end
    return (self.uiGroupHelper:getBottomBarVisibility():get())
end

function module.getInstance()
    if var3 == nil then
        var3 = module.new()
    end
    return var3
end

return module
