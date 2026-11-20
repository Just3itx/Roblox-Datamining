-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DragIntent = require(Foundation.Enums.DragIntent)
local _InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)
local contentLock = require(script.Parent.contentLock)
local gestureInput = require(script.Parent.gestureInput)
local swipeMath = require(script.Parent.swipeMath)

local function showCapture(tbl1, currentVisible: boolean) -- Luacid: Inlined by compiler; 5 call sites recovered
    local current = tbl1.captureRef.current
    if current ~= nil then
        current.Visible = currentVisible
    end
end

local function releaseLock(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local unlock = tbl1.unlock
    tbl1.unlock = nil

    task.defer(function()
        if unlock ~= nil then
            unlock()
        end
        showCapture(tbl1, false)
    end)
end

local function claim(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    tbl1.latest.current.onClaim()
    tbl1.unlock = contentLock.lock(tbl1.panelRef.current, tbl1.backdropRef.current, tbl1.scrollingFrameRef.current)
    showCapture(tbl1, true)
end

return {
    onInputBegan = function(tbl1, arg1): boolean
        if not gestureInput.canBegin(tbl1.gesture, arg1) then
            return false
        end

        local current = tbl1.panelRef.current
        if current == nil then
            return false
        end
        local current2 = tbl1.backdropRef.current
        local position = arg1.Position
        local var1 = gestureInput.isInside(current, position)
        local var2 = not (current2 == nil) and gestureInput.isInside(current2, position)

        if not (var1 or var2) then
            return false
        end
        if gestureInput.isForeignHit(current, gestureInput.topGuiAt(current, position, current2), current2) then
            return false
        end

        tbl1.gesture = gestureInput.beginGesture(arg1, os.clock())
        return true
    end,
    onInputChanged = function(tbl1, arg1)
        local gesture = tbl1.gesture
        if gesture == nil or not gestureInput.matchesMove(arg1, gesture.input) then
            return
        end

        local current = tbl1.latest.current
        local var1, var2, var3 = gestureInput.move(gesture, arg1, swipeMath.closeSign(current.side))
        if var1 then
            claim(tbl1)
        end

        if not var2 then
            return
        end

        local var4 = swipeMath.distanceAlong(swipeMath.closeSign(current.side), gesture.startX, var3)
        gestureInput.setProgressIfChanged(gesture, current.setDrag, 1 - swipeMath.progress(var4, current.travel))
    end,
    onInputEnded = function(tbl1, arg1): boolean
        local gesture = tbl1.gesture
        if gesture == nil or not gestureInput.matchesRelease(arg1, gesture.input) then
            return false
        end

        tbl1.gesture = nil
        if gesture.intent ~= DragIntent.Claim then
            return true
        end

        releaseLock(tbl1)
        local current = tbl1.latest.current
        if not current.isOpen then
            return true
        end

        local var1 = swipeMath.shouldCommit(
            gesture,
            swipeMath.closeSign(current.side),
            current.travel,
            current.distanceFraction,
            current.velocityThreshold,
            os.clock()
        )
        current.onRelease(var1)
        return true
    end,
    reset = function(tbl1)
        local gesture = tbl1.gesture
        tbl1.gesture = nil
        if gesture ~= nil and gesture.intent == DragIntent.Claim then
            releaseLock(tbl1)
            tbl1.latest.current.onCancel()
        end
    end
}
