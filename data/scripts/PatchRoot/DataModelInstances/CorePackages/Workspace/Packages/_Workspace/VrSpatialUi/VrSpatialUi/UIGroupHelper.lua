-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUi = script:FindFirstAncestor("VrSpatialUi")
local VrSpatialUiParent = VrSpatialUi.Parent
local _AppCommonLib = require(VrSpatialUiParent.AppCommonLib)
local Observable = require(VrSpatialUiParent.Observable)

local Constants = require(VrSpatialUi.Constants)
local createUIGroupDragBar = require(VrSpatialUi.createUIGroupDragBar)
local _DragBar = require(VrSpatialUi.DragBar)
local UIGroupState = require(VrSpatialUi.UIGroupState)
local PanelManagedAnimatable = require(VrSpatialUi.PanelManagedAnimatable)

local FFlagEnableSpatialUIBottomBarFixPlaceFilter = require(VrSpatialUi.Flags.FFlagEnableSpatialUIBottomBarFixPlaceFilter)
local FFlagSpatialUIHiddenPanelRaycastFix = require(VrSpatialUi.Flags.FFlagSpatialUIHiddenPanelRaycastFix)

local InExperienceUIVRIXP = require(VrSpatialUiParent.SharedExperimentDefinition).InExperienceUIVRIXP

local num1 = game:DefineFastInt("SpatialUIRepositionDeviationAngle", 10)
local bool1 = game:DefineFastFlag("SpatialUIEnableCameraCacheFix", false)
local num2 = math.rad(num1)

function getUIGroupTypeForPanel(tbl1, arg1)
    local var1 = if arg1 then tbl1[arg1] else nil

    if var1 == nil then
        return nil
    end
    local panelPositionProps = var1.panelPositionProps
    return if panelPositionProps then panelPositionProps.uiGroup else nil
end

function getDragBarSafely(uiGroup)
    return if uiGroup and uiGroup.dragBar and uiGroup.draggable then uiGroup.dragBar else nil
end

function isTempPanel(toolTipsContainer): boolean
    return toolTipsContainer == Constants.PanelType.ToolTipsContainer
end

function visitAllPanels(tbl1, callback: (...any) -> (...any))
    for k, value in pairs(tbl1) do
        callback(k, value)
    end
end

function visitDraggablePanels(tbl1, uiGroup, callback: (...any) -> (...any))
    visitAllPanels(tbl1, function(arg1, arg2)
        local panelPositionProps = arg2.panelPositionProps
        if panelPositionProps
            and not isTempPanel(arg1)
            and panelPositionProps.cameraFixedPanelProp
            and panelPositionProps.uiGroup == uiGroup
        then
            callback(arg1, panelPositionProps.cameraFixedPanelProp)
        end
    end)
end

function connect(value, arg2)
    return {
        value = value,
        connection = value:connect(arg2)
    }
end

function disconnect(tbl1)
    if tbl1.connection then
        tbl1.connection:disconnect()
        tbl1.connection = nil
    end
end

function setPanelParent(arg1, arg2)
    local panelObjectEnabled = arg2 ~= nil

    if arg1.uiType ~= Constants.SpatialUIType.SpatialUI and arg1.uiType ~= Constants.SpatialUIType.SpatialUIRoact then
        if arg1.uiType == Constants.SpatialUIType.SpatialUIPartOnly then
            arg1.panelObject.Parent = arg2
        end
        return
    end

    local panelObject = arg1.panelObject
    panelObject.Enabled = panelObjectEnabled

    local adornee = panelObject.Adornee
    adornee.CanCollide = false
    adornee.CanTouch = false
    adornee.Anchored = true
    adornee.Parent = arg2
end

function setPanelEnabledWithoutReparent(arg1, panelObjectEnabled: boolean)
    if arg1.uiType ~= Constants.SpatialUIType.SpatialUI and arg1.uiType ~= Constants.SpatialUIType.SpatialUIRoact then
        return
    end
    local panelObject = arg1.panelObject
    panelObject.Enabled = panelObjectEnabled

    local adornee = panelObject.Adornee
    adornee.CanCollide = false
    adornee.CanTouch = false
    adornee.Anchored = true
end

function setPanelVisibleState(arg1, bottomBar, bool2: boolean)
    if FFlagEnableSpatialUIBottomBarFixPlaceFilter and bottomBar == Constants.PanelType.BottomBar then
        setPanelEnabledWithoutReparent(arg1, bool2)
        return
    end
    setPanelParent(arg1, if bool2 then workspace else nil)
end

local module = {}

module.__index = module

function module:setTopBarVisible(arg1, arg2)
    self.topBarVisibleValue = connect(arg1, arg2)
end

function module:isTopBarVisible()
    return self.topBarVisibleValue.value:get()
end

function module.prepareGuiToggleAnimationState(arg1, _)
    arg1:setUIGroupState(UIGroupState.GuiToggleAnimation)
end

function module:setUIGroupState(uiGroupState)
    self.uiGroupState = uiGroupState
end

function module:animateBottomBarOnHeadMoveIfNeeded(_, vector2: Vector2, vector2_2: Vector2)
    if self.uiGroupState ~= UIGroupState.GuiToggleAnimation or self.currentBottomBarAnimatable == nil then
        return
    end
    local vector2X = vector2.X
    local vector2Y = vector2.Y
    local vector22X = vector2_2.X
    local vector22Y = vector2_2.Y
    local num3 = math.abs(vector2X - vector22X)
    local num4 = math.abs(vector2Y - vector22Y)
    if num2 < num3 or num2 < num4 then
        self.currentBottomBarAnimatable:animateHideIfNeeded(false)
        return
    end
    self.currentBottomBarAnimatable:animateShowIfNeeded()
end

function module:isGroupVisibleForPanel(arg1, tbl1)
    local uIGroupTypeForPanel = getUIGroupTypeForPanel(tbl1, arg1)
    local var1 = if uIGroupTypeForPanel then self.uiGroupVisibilityMap[uIGroupTypeForPanel] else nil

    if var1 then
        return var1.value:get()
    end
    return true
end

function module:applyGroupPanelsEnabled(arg1, tbl1, bool2: boolean?)
    local var1 = self.uiGroupVisibilityMap[arg1]
    local var2 = not var1 or var1.value:get()
    local var3 = self:isTopBarVisible() and var2
    if bool2 and var3 then
        return
    end
    visitAllPanels(tbl1, function(arg2, arg3)
        if not isTempPanel(arg2) and getUIGroupTypeForPanel(tbl1, arg2) == arg1 then
            setPanelVisibleState(arg3, arg2, var3)
        end
    end)
end

function module:updateAllElements(tbl1, tbl2)
    local var1 = self:isTopBarVisible()
    if var1 then
        self:setUIGroupState(UIGroupState.Default)
        if self.currentBottomBarAnimatable then
            self.currentBottomBarAnimatable:reset()
            self.currentBottomBarAnimatable = nil
        end
    end
    self:updateAllDragBar(tbl1, tbl2)
    visitAllPanels(tbl1, function(bottomBar, arg1)
        local bool2 = bottomBar == Constants.PanelType.BottomBar
        if var1 then
            if FFlagSpatialUIHiddenPanelRaycastFix and not self:isGroupVisibleForPanel(bottomBar, tbl1) then
                setPanelVisibleState(arg1, bottomBar, false)
                return
            elseif FFlagEnableSpatialUIBottomBarFixPlaceFilter and bool2 then
                setPanelEnabledWithoutReparent(arg1, true)
                return
            else
                setPanelParent(arg1, workspace)
                return
            end
        end
        if not bool2 or self.uiGroupState ~= UIGroupState.GuiToggleAnimation and not arg1.keepVisibleWhenTopBarHidden then
            if FFlagEnableSpatialUIBottomBarFixPlaceFilter and bool2 then
                setPanelEnabledWithoutReparent(arg1, false)
                return
            end
            setPanelParent(arg1, nil)
            return
        end

        if not self.currentBottomBarAnimatable then
            local var2 = arg1.keepVisibleWhenTopBarHidden and self.uiGroupState ~= UIGroupState.GuiToggleAnimation
            self.currentBottomBarAnimatable = PanelManagedAnimatable.create(arg1.panelObject, self.bottomBarVisibility, var2)

            if self.currentBottomBarAnimatable then
                self.currentBottomBarAnimatable:hideAndBlockAnimationUntilLookBackAgain()
            end
        end
        if not arg1.keepVisibleWhenTopBarHidden then
            return
        end

        if FFlagEnableSpatialUIBottomBarFixPlaceFilter then
            setPanelEnabledWithoutReparent(arg1, true)
            return
        end
        setPanelParent(arg1, workspace)
    end)
end

function module:connectPanelVisibility(arg1, arg2, tbl1, tbl2)
    if isTempPanel(arg1) then
        return
    end
    self:disconnectPanelVisibility(arg1, tbl1, tbl2)
    local uIGroupTypeForPanel = getUIGroupTypeForPanel(tbl1, arg1)
    if not uIGroupTypeForPanel then
        return
    end
    self.uiGroupVisibilityMap[uIGroupTypeForPanel] = connect(arg2, function()
        self:updateDragBar(arg1, tbl1, tbl2)
        if FFlagSpatialUIHiddenPanelRaycastFix then
            self:applyGroupPanelsEnabled(uIGroupTypeForPanel, tbl1)
        end
    end)
    self:updateDragBar(arg1, tbl1, tbl2)
    if FFlagSpatialUIHiddenPanelRaycastFix then
        self:applyGroupPanelsEnabled(uIGroupTypeForPanel, tbl1, true)
    end
end

function module:disconnectPanelVisibility(arg1, tbl1, tbl2)
    if isTempPanel(arg1) then
        return
    end
    local uIGroupTypeForPanel = getUIGroupTypeForPanel(tbl1, arg1)
    local var1 = if uIGroupTypeForPanel then self.uiGroupVisibilityMap[uIGroupTypeForPanel] else nil

    if var1 then
        disconnect(var1)
        self.uiGroupVisibilityMap[uIGroupTypeForPanel] = nil
        self:updateDragBar(arg1, tbl1, tbl2)
    end
end

function module:updateDragBar(arg1, tbl1, tbl2)
    local uIGroupTypeForPanel = getUIGroupTypeForPanel(tbl1, arg1)
    local var1 = if uIGroupTypeForPanel then tbl2[uIGroupTypeForPanel] else nil

    if not var1 or not var1.dragBar or not var1.draggable or isTempPanel(arg1) then
        return
    end
    local var2 = self:isTopBarVisible()
    local var3 = self.uiGroupVisibilityMap[uIGroupTypeForPanel]

    if var3 and var2 and var3.value:get() then
        var1.dragBar:show()
        return
    end
    var1.dragBar:hide()
end

function module:updateAllDragBar(tbl1, tbl2)
    for k, _ in pairs(tbl1) do
        self:updateDragBar(k, tbl1, tbl2)
    end
end

function module:createUIGroup(arg1, name, vector2: Vector2, positionProps, tbl1, bool2: boolean?)
    local var1 = Constants.UIGROUP_INITITIAL_ROTATION_MAP[name]
    local uiGroup = self.uiGroups[name]
    local dragBarSafely = getDragBarSafely(uiGroup)
    if bool2 and var1 and dragBarSafely and dragBarSafely:isEverDragged() then
        visitDraggablePanels(tbl1, name, function(_, arg3)
            uiGroup.dragBarOffset *= var1
            arg3.uiGroupElementOffset *= var1
        end)
    end

    local var2 = nil
    local uIGroupDragBar = nil
    uIGroupDragBar = createUIGroupDragBar({
        name = name,
        dragFunction = function(_, _, _, _, _)
            arg1:dragUiGroupStep(name)
        end,
        dragStartFunction = function(_, _, _, _, _, _, _)
            if var1 and var2 and uIGroupDragBar and not uIGroupDragBar:isEverDragged() then
                uIGroupDragBar:setCFrame(uIGroupDragBar:getCFrame() * var1:Inverse())
                var2.dragBarOffset *= var1:Inverse()
                visitDraggablePanels(tbl1, name, function(_, arg3)
                    arg3.uiGroupElementOffset *= var1:Inverse()
                end)
            end

            arg1:dragUiGroupStart(name)
        end,
        dragEndFunction = function(_)
            arg1:dragUiGroupEnd(name)
        end,
        dragBarPartSize = Constants.DRAG_BAR_SIZE
    })
    uIGroupDragBar:hide()
    var2 = {
        positionProps = positionProps,
        uiContainerSize = vector2,
        draggable = InExperienceUIVRIXP:isDraggingAllowed(),
        dragBar = uIGroupDragBar,
        dragBarOffset = Constants.UIGROUP_DRAGBAR_OFFSET_MAP[name],
        headScale = 1
    }

    self.uiGroups[name] = var2
    return var2
end

function module.checkAndGetUIGroupTypeForTempPanel(_, arg1, tbl1)
    if isTempPanel(arg1) then
        return (getUIGroupTypeForPanel(tbl1, arg1))
    end

    return nil
end

function module:getGroupCameraCFrameIfPossible(arg1, tbl1)
    local currentCameraCFrame = workspace.CurrentCamera.CFrame
    if bool1 and isTempPanel(arg1) then
        local uIGroupTypeForPanel = getUIGroupTypeForPanel(tbl1, arg1)
        if uIGroupTypeForPanel ~= nil and self.uiGroups[uIGroupTypeForPanel].lastCameraCFrame then
            currentCameraCFrame = self.uiGroups[uIGroupTypeForPanel].lastCameraCFrame
        end
    end
    return currentCameraCFrame
end

function module:getBottomBarVisibility()
    return self.bottomBarVisibility
end

function module.new(bool2: boolean)
    local tbl1 = {
        uiGroupVisibilityMap = {},
        topBarVisibleValue = {
            value = Observable.ObservableValue.new(bool2)
        },
        uiGroups = {},
        uiGroupState = UIGroupState.Default,
        bottomBarVisibility = Observable.ObservableValue.new(true),
        currentBottomBarAnimatable = nil
    }

    setmetatable(tbl1, module)
    return tbl1
end

return module
