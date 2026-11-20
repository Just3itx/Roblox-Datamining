-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DragIntent = require(Foundation.Enums.DragIntent)
local _InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)
local gestureInput = require(script.Parent.gestureInput)
local swipeMath = require(script.Parent.swipeMath)

return {
    onInputBegan = function(tbl1, arg1): boolean
        if not gestureInput.canBegin(tbl1.gesture, arg1) then
            return false
        end

        local current = tbl1.latest.current
        if current.isOpen then
            return false
        end
        local current2 = tbl1.edgeRef.current
        if current2 == nil then
            return false
        end
        local position = arg1.Position
        if not gestureInput.isInside(current2, position) then
            return false
        end
        if gestureInput.isForeignHit(current2, gestureInput.topGuiAt(current2, position), nil) then
            return false
        end

        tbl1.gesture = gestureInput.beginGesture(arg1, os.clock())
        current.onPress()
        return true
    end,
    onInputChanged = function(tbl1, arg1)
        local gesture = tbl1.gesture
        if gesture == nil or not gestureInput.matchesMove(arg1, gesture.input) then
            return
        end

        local current = tbl1.latest.current
        local var1, var2, var3 = gestureInput.move(gesture, arg1, swipeMath.openSign(current.side))
        if var1 then
            current.onClaim()
        end
        if not var2 then
            return
        end

        local var4 = swipeMath.distanceAlong(swipeMath.openSign(current.side), gesture.startX, var3)
        gestureInput.setProgressIfChanged(gesture, current.setDrag, swipeMath.progress(var4, current.travel))
    end,
    onInputEnded = function(tbl1, arg1): boolean
        local gesture = tbl1.gesture
        if gesture == nil or not gestureInput.matchesRelease(arg1, gesture.input) then
            return false
        end

        tbl1.gesture = nil
        local current = tbl1.latest.current
        if gesture.intent ~= DragIntent.Claim then
            current.onPressEnd()
            return true
        end

        if swipeMath.shouldCommit(
            gesture,
            swipeMath.openSign(current.side),
            current.travel,
            current.distanceFraction,
            current.velocityThreshold,
            os.clock()
        ) then
            current.onCommit()
        else
            current.onDragCancel()
        end
        return true
    end,
    reset = function(tbl1)
        local gesture = tbl1.gesture
        tbl1.gesture = nil
        if gesture == nil then
            return
        end
        local current = tbl1.latest.current
        if gesture.intent == DragIntent.Claim then
            current.onDragCancel()
            return
        end
        current.onPressEnd()
    end
}
