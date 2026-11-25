-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUiParent = script:FindFirstAncestor("VrSpatialUi").Parent
local Otter = require(VrSpatialUiParent.Otter)
local _Observable = require(VrSpatialUiParent.Observable)

local function _pendingHideAnimation() end

local tbl1 = {
    Default = { dampingRatio = 1, frequency = 4.5 },
    Slower = { dampingRatio = 1, frequency = 0.66 }
}

local module = {}

module.__index = module

function module:checkIfAnimateNeeded(_currentGoal: number): boolean
    return _currentGoal ~= self._currentGoal
end

function module:hideAndBlockAnimationUntilLookBackAgain()
    self._ignoreAnimateShow = true
    self:animateHideIfNeeded(true)
end

function module:animateHideIfNeeded(bool1: boolean)
    if not bool1 then
        self._ignoreAnimateShow = false
    end
    if not self:checkIfAnimateNeeded(1) or self._pendingHideAnimation and self._pendingHideAnimation ~= _pendingHideAnimation then
        return
    end
    self._currentGoal = 1
    self:animateToGoal(self._currentGoal, tbl1.Slower)
end

function module:animateShowIfNeeded()
    if not self:checkIfAnimateNeeded(0) or self._ignoreAnimateShow then
        return
    end
    self:cancelPendingTaskIfNeeded()
    self._currentGoal = 0
    self:animateToGoal(self._currentGoal, tbl1.Default)

    local _pendingHideAnimation2 = nil
    function self._pendingHideAnimation()
        if self._pendingHideAnimation == _pendingHideAnimation2 then
            self._pendingHideAnimation = _pendingHideAnimation
            self:animateToGoal(1, tbl1.Slower)
        end
    end
    _pendingHideAnimation2 = self._pendingHideAnimation
    task.delay(3, self._pendingHideAnimation)
end

function module:animateToGoal(arg1, arg2)
    self._fadeTransparencyMotor:stop()
    self._fadeTransparencyMotor:setGoal(Otter.spring(arg1, arg2))
end

function module:isTargetVisible(): boolean
    return self._targetInstance.GroupTransparency == 0
end

function module:reset()
    self._fadeTransparencyMotor:stop()
    self:cancelPendingTaskIfNeeded()
    self._ignoreAnimateShow = false
    self._currentGoal = -1
    self._targetInstance.GroupTransparency = 0
    self._visibilityObservable:set(true)
end

function module:cancelPendingTaskIfNeeded()
    self._pendingHideAnimation = _pendingHideAnimation
end

function module.create(arg1, _visibilityObservable, bool1: boolean?): {_currentGoal: number, _fadeTransparencyMotor: any, _ignoreAnimateShow: boolean, _pendingHideAnimation: () -> (), _targetInstance: any, _visibilityObservable: any}?
    local var1 = nil
    for _, descendant in ipairs(arg1:GetDescendants()) do
        if descendant.Name == "AnimatablePanelManagedContent" then
            var1 = descendant
            break
        end
    end

    if var1 == nil then
        return nil
    end
    if bool1 then
        var1.GroupTransparency = 1
    end
    _visibilityObservable:set(var1.GroupTransparency == 0)
    local _fadeTransparencyMotor = Otter.createSingleMotor(if bool1 then 1 else 0)
    _fadeTransparencyMotor:onStep(function(groupTransparency)
        var1.GroupTransparency = groupTransparency
        _visibilityObservable:set(var1.GroupTransparency == 0)
    end)

    local tbl2 = {
        _targetInstance = var1,
        _fadeTransparencyMotor = _fadeTransparencyMotor,
        _currentGoal = -1,
        _pendingHideAnimation = _pendingHideAnimation,
        _ignoreAnimateShow = false,
        _visibilityObservable = _visibilityObservable
    }
    setmetatable(tbl2, module)
    return tbl2
end

return module
