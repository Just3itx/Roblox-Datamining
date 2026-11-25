-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local GuiService = game:GetService("GuiService")
local GamepadService = game:GetService("GamepadService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local VirtualCursorModularParent = script:FindFirstAncestor("VirtualCursorModular").Parent
local SharedFlags = require(VirtualCursorModularParent.SharedFlags)
local FFlagEnableVirtualCursorMoveAssist = SharedFlags.FFlagEnableVirtualCursorMoveAssist
local FIntVirtualCursorMoveAssistLevel = SharedFlags.FIntVirtualCursorMoveAssistLevel
local FIntVirtualCursorMoveAssistHoverSpeed = SharedFlags.FIntVirtualCursorMoveAssistHoverSpeed
local FFlagVirtualCursorInputSink = SharedFlags.FFlagVirtualCursorInputSink
local FIntVirtualCursorMoveAssistSpeedSizeMinScale = SharedFlags.FIntVirtualCursorMoveAssistSpeedSizeMinScale
local FIntVirtualCursorMoveAssistSpeedSizeMaxScale = SharedFlags.FIntVirtualCursorMoveAssistSpeedSizeMaxScale
local FIntVirtualCursorMoveAssistSpeedSmoothingTimeMs = SharedFlags.FIntVirtualCursorMoveAssistSpeedSmoothingTimeMs

local Properties = require(scriptParentParent.Properties)

local Util = require(scriptParentParent.Util)
local GetMaxSpeed = Util.GetMaxSpeed
local GetUsesInputSink = Util.GetUsesInputSink
local IsCircleContainedInGuiObject = Util.IsCircleContainedInGuiObject
local IsScreenSpaceGuiObject = Util.IsScreenSpaceGuiObject
local IsSelectableGuiObject = Util.IsSelectableGuiObject
local IsSinkingGuiObject = Util.IsSinkingGuiObject
local GetPointRotatedAroundObject = Util.GetPointRotatedAroundObject

local cos = math.cos
local sin = math.sin
local abs = math.abs
local max = math.max
local min = math.min
local sign = math.sign

local module = {}
module.__index = module

function module.new(_inputController, _cursorController, _moveAssistController)
    return (setmetatable({
        _isScrolling = false,
        _selectedObject = nil,
        _inputController = _inputController,
        _cursorController = _cursorController,
        _moveAssistController = _moveAssistController,
        _selectionRadius = Properties.SelectionRadius,
        _scrolled = {},
        _hoverSlowdown = 1
    }, module))
end

function module:processScrolling(arg1, vector2: Vector2, num1: number)
    if not arg1:IsA("ScrollingFrame") then
        return false
    end

    if not arg1.ScrollingEnabled then
        return false
    end

    if self._scrolled[arg1] then
        return false
    end
    self._scrolled[arg1] = true

    local scrollVector = self._inputController:GetScrollVector()
    local var1 = Properties.ScrollingSpeed * num1
    local scrollingRadius = Properties.ScrollingRadius
    local absoluteCanvasSize = arg1.AbsoluteCanvasSize
    local absoluteSize = arg1.AbsoluteSize
    local scrollingDirection = arg1.ScrollingDirection
    local bool1 = absoluteCanvasSize.X > absoluteSize.X
        and (scrollingDirection == Enum.ScrollingDirection.XY or scrollingDirection == Enum.ScrollingDirection.X)
    local bool2 = absoluteCanvasSize.Y > absoluteSize.Y
        and (scrollingDirection == Enum.ScrollingDirection.XY or scrollingDirection == Enum.ScrollingDirection.Y)
    local absolutePosition = arg1.AbsolutePosition
    local num2 = arg1.Rotation / 180 * math.pi

    if abs(scrollVector.x) > Properties.ThumbstickDeadzone and bool1 then
        arg1.CanvasPosition += Vector2.new(scrollVector.x * var1, 0)
    end

    if abs(scrollVector.y) > Properties.ThumbstickDeadzone and bool2 then
        arg1.CanvasPosition += Vector2.new(0, scrollVector.y * var1)
    end

    local vector2_2 = Vector2.new(cos(num2), (sin(num2)))

    local vector2_3 = Vector2.new(-sin(num2), (cos(num2)))
    local var2 = Vector2.new(vector2.X, vector2.Y) - absolutePosition

    local var3 = var2:Dot(vector2_2) - absoluteSize.X / 2
    local var4 = var2:Dot(vector2_3) - absoluteSize.Y / 2
    local var5 = Vector2.new(abs(var3), (abs(var4))) - absoluteSize / 2
    local magnitude = Vector2.new(max(var5.X, 0), (max(var5.Y, 0))).Magnitude
    if abs(min(max(var5.X, var5.Y), 0) + magnitude) < scrollingRadius then
        local var6 = abs(var5.X)

        if var6 < abs(var5.Y) and bool1 then
            arg1.CanvasPosition += Vector2.new(sign(var3) * var1, 0)
            self._cursorController:SetArrow(sign(var3), 0)
            return true
        end

        local var7 = abs(var5.X)

        if abs(var5.Y) <= var7 and bool2 then
            arg1.CanvasPosition += Vector2.new(0, sign(var4) * var1)
            self._cursorController:SetArrow(0, (sign(var4)))
            return true
        end
    end

    return false
end

function module:getClosestCandidate(tbl1, vector2: Vector2, _: number, num1: number, tbl2, arg1)
    local closestCandidate, occludingCandidate, var1

    if tbl2 then
        closestCandidate = tbl2.closestCandidate
        occludingCandidate = tbl2.occludingCandidate
        var1 = tbl2.closestDistance
    else
        closestCandidate = nil
        occludingCandidate = nil
        var1 = math.huge
    end

    local isCoreGui = not (arg1 == nil) and arg1:IsA("CoreGui")

    for _, value in tbl1 do
        if self:processScrolling(value, vector2, num1) then
            self._isScrolling = true
            return closestCandidate, occludingCandidate, var1
        end

        local usesInputSink = if FFlagVirtualCursorInputSink and arg1 ~= nil then GetUsesInputSink(value, isCoreGui) else false
        local var2 = IsSelectableGuiObject

        if var2(value, if FFlagVirtualCursorInputSink then usesInputSink else nil) then
            local absolutePosition = value.AbsolutePosition
            local var3 = value.AbsolutePosition + value.AbsoluteSize

            local num2 = 0
            local var4 = if value.AbsoluteRotation == 0 then vector2 else GetPointRotatedAroundObject(vector2, value)

            if var4.X < absolutePosition.X or var4.Y < absolutePosition.Y or var4.X > var3.X or var4.Y > var3.Y then
                local var5 = if var4.X < absolutePosition.X then absolutePosition.X - var4.X elseif var4.X > var3.X then var4.X - var3.X else 0
                local var6 = if var4.Y < absolutePosition.Y then absolutePosition.Y - var4.Y elseif var4.Y > var3.Y then var4.Y - var3.Y else 0
                num2 = math.sqrt(math.pow(var5, 2) + math.pow(var6, 2))
            end

            if num2 < var1 or closestCandidate == nil then
                var1 = num2
                closestCandidate = value
            end
        end

        local var3 = IsSinkingGuiObject

        if not FFlagVirtualCursorInputSink then
            usesInputSink = nil
        end

        if var3(value, usesInputSink)
            and IsCircleContainedInGuiObject(vector2, Properties.CursorRadius * Properties.OcclusionRadiusScale, value)
        then
            return closestCandidate, value, var1
        end
    end

    return closestCandidate, occludingCandidate, var1
end

function module:getSizeAdaptiveHoverSpeed(arg1, num1: number, num2: number, num3: number): number
    local var1 = Properties.CursorRadius * 2
    local var2 = min(arg1.AbsoluteSize.X, arg1.AbsoluteSize.Y) / var1
    local num4 = num3 - num2
    local var3 = if num4 > 0 then math.clamp((var2 - num2) / num4, 0, 1) else 1
    return num1 + (1 - num1) * var3
end

function module:processMoving(num1: number)
    local var1 = GuiService:GetScreenResolution() + GuiService:GetGuiInset()

    local moveVector = self._inputController:GetMoveVector()
    local vector2 = GamepadService:GetGamepadCursorPosition()

    local var2 = FFlagEnableVirtualCursorMoveAssist and FIntVirtualCursorMoveAssistLevel > 0

    if var2 and not self._isScrolling and moveVector.Magnitude >= Properties.MoveAssistMinInputMagnitude then
        local cursorScreenGuiOffset = self._cursorController:GetCursorScreenGuiOffset()
        moveVector = self._moveAssistController:applyMoveAssist(moveVector, {
            cursorPosition = vector2 + cursorScreenGuiOffset,
            strengthMultiplier = FIntVirtualCursorMoveAssistLevel / 100,
            candidates = self:getAssistCandidateList(vector2, Properties.MoveAssistRadius)
        })
    elseif FFlagEnableVirtualCursorMoveAssist then
        self._moveAssistController:clearDebugSnapshot()
    end

    local var3 = moveVector * GetMaxSpeed()
    local _selectedObject = self._selectedObject
    local var4

    if var2 then
        local var5 = if FIntVirtualCursorMoveAssistHoverSpeed > 0 then FIntVirtualCursorMoveAssistHoverSpeed / 100 else Properties.SpeedAdjustmentTarget
        local var6 = FIntVirtualCursorMoveAssistSpeedSizeMinScale / 100
        local var7 = FIntVirtualCursorMoveAssistSpeedSizeMaxScale / 100
        if var6 < var7 and _selectedObject ~= nil and not self._isScrolling and IsScreenSpaceGuiObject(_selectedObject) then
            var5 = self:getSizeAdaptiveHoverSpeed(_selectedObject, var5, var6, var7)
        end

        if _selectedObject == nil then
            var5 = 1
        elseif self._isScrolling then
            var5 = Properties.ScrollingSlowDown
        end

        local var8 = FIntVirtualCursorMoveAssistSpeedSmoothingTimeMs / 1000
        if var8 > 0 then
            local num2 = 1 - math.exp(-num1 / var8)
            self._hoverSlowdown += (var5 - self._hoverSlowdown) * num2
            var4 = var3 * self._hoverSlowdown
        else
            var4 = var3 * var5
        end
    else
        var4 = var3 * (if _selectedObject == nil then 1 elseif self._isScrolling then Properties.ScrollingSlowDown else Properties.SpeedAdjustmentTarget)
    end

    if var4.Magnitude > 0 then
        local var5 = vector2 + var4 * num1
        vector2 = Vector2.new(math.clamp(var5.X, 0, var1.X), math.clamp(var5.Y, 0, var1.Y))
    end

    self._cursorController:SetPosition(vector2)
    GamepadService:SetGamepadCursorPosition(vector2)
end

function module:getCandidates(vector2: Vector2, num1: number)
    local localPlayer = Players.LocalPlayer
    local var1 = if localPlayer then localPlayer:FindFirstChildOfClass("PlayerGui") else nil
    local var2 = not var1 and {} or var1:GetGuiObjectsInCircle(vector2, num1)
    local guiObjectsInCircle = CoreGui:GetGuiObjectsInCircle(vector2, num1)

    return {
        { CoreGui, guiObjectsInCircle },
        { var1, var2 }
    }
end

function module:processAncestors(arg1, arg2, vector2: Vector2, num1: number)
    local parent = arg1.Parent
    while parent and parent ~= arg2 do
        if self:processScrolling(parent, vector2, num1) then
            self._isScrolling = true
            return
        end
        parent = parent.Parent
    end
end

function module:processCandidates(vector2: Vector2, num1: number, num2: number)
    vector2 -= GuiService:GetGuiInset()
    local candidates = self:getCandidates(vector2, num1)

    local var1 = nil
    local var2 = nil
    local huge = math.huge
    self._scrolled = {}
    self._isScrolling = false

    for _, value in ipairs(candidates) do
        local var3 = value[1]
        local var4 = value[2]

        local tbl1 = { closestCandidate = var1, occludingCandidate = var2, closestDistance = huge }
        local var5 = if FFlagVirtualCursorInputSink then var3 else nil
        var1, var2, huge = self:getClosestCandidate(var4, vector2, num1, num2, tbl1, var5)

        if self._isScrolling then
            return nil, math.huge
        end

        if var1 then
            self:processAncestors(var1, var3, vector2, num2)
        end

        if self._isScrolling then
            return nil, math.huge
        end

        if var2 and var2 ~= var1 then
            self:processAncestors(var2, var3, vector2, num2)
        end

        if self._isScrolling then
            return nil, math.huge
        end

        if var2 then
            return var1, huge
        end
    end

    return var1, huge
end

function module:getAssistCandidateList(vector2: Vector2, num1: number)
    local tbl1 = {}
    local tbl2 = {}

    for _, value in self:getCandidates(vector2 - GuiService:GetGuiInset(), num1) do
        for _, value2 in value[2] do
            if not value2:IsA("GuiObject") then
                continue
            end

            if value[1] == CoreGui then
                table.insert(if FFlagVirtualCursorInputSink then tbl1 else tbl2, value2)
            else
                table.insert(tbl2, value2)
            end
        end
    end

    if FFlagVirtualCursorInputSink then
        return self:filterAssistCandidates(tbl1, tbl2)
    end
    return self:DEPRECATED_filterAssistCandidates(tbl2)
end

function module:filterAssistCandidates<T>(tbl1, tbl2)
    local result = {}

    local tbl3 = {}
    local var1 = Properties.CursorRadius * Properties.OcclusionRadiusScale

    for _, value in { tbl1, tbl2 } do
        for _, value2 in value do
            local usesInputSink = GetUsesInputSink(value2, value == tbl1)

            if IsSelectableGuiObject(value2, usesInputSink) then
                local var2 = value2.AbsolutePosition + value2.AbsoluteSize * 0.5
                local bool1 = false
                for _, value3 in tbl3 do
                    if value3 ~= value2 and IsCircleContainedInGuiObject(var2, var1, value3) then
                        bool1 = true
                        break
                    end
                end

                if not bool1 then
                    table.insert(result, value2)
                end
            end

            if IsSinkingGuiObject(value2, usesInputSink) then
                table.insert(tbl3, value2)
            end
        end
    end

    return result
end

function module:DEPRECATED_filterAssistCandidates(tbl1)
    local result = {}

    local tbl2 = {}
    local var1 = Properties.CursorRadius * Properties.OcclusionRadiusScale
    for _, value in tbl1 do
        if IsSelectableGuiObject(value) then
            local var2 = value.AbsolutePosition + value.AbsoluteSize * 0.5
            local bool1 = false
            for _, value2 in tbl2 do
                if value2 ~= value and IsCircleContainedInGuiObject(var2, var1, value2) then
                    bool1 = true
                    break
                end
            end

            if not bool1 then
                table.insert(result, value)
            end
        end

        if IsSinkingGuiObject(value) then
            table.insert(tbl2, value)
        end
    end

    return result
end

function module:onRenderStep(num1: number)
    self:processMoving(num1)
    local var1 = self:processCandidates(GamepadService:GetGamepadCursorPosition(), self._selectionRadius, num1)

    if var1 == self._selectedObject then
        return
    end

    local localPlayer = Players.LocalPlayer
    local var2 = if localPlayer then localPlayer:FindFirstChildOfClass("PlayerGui") else nil

    if var1 then
        self._cursorController:SetHighlight(true)

        if var1:IsDescendantOf(CoreGui) then
            GuiService.SelectedCoreObject = var1
            GuiService.SelectedObject = nil
        elseif var2 and var1:IsDescendantOf(var2) then
            GuiService.SelectedObject = var1
            GuiService.SelectedCoreObject = nil
        end
    else
        self._cursorController:SetHighlight(false)

        GuiService.SelectedObject = nil
        GuiService.SelectedCoreObject = nil
    end

    self._selectedObject = var1
end

return module
