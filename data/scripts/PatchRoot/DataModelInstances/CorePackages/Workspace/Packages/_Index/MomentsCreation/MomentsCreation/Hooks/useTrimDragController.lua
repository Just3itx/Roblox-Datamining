-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)

local useBinding = React.useBinding
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef

local validateRefs = require(MomentsCreation.Utils.validateRefs)
local DragHandle = require(MomentsCreation.Enums.DragHandle)

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local function initialFraction(num1: number?, num2: number, num3: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if num1 == nil or not (num2 > 0) then num3 else num1 / num2
end

local function useTrimDragController(bool1: boolean, callback: (...any) -> (...any), callback2: (...any) -> (...any), callback3: (...any) -> (...any), callback4: (...any) -> (...any), arg1, num1: number, callback5: ((...any) -> (...any))?)
    local dragContainerRef = useRef(nil)
    local leftHandleRef = useRef(nil)
    local rightHandleRef = useRef(nil)
    local segmentRef = useRef(nil)
    local scrubberDisplayRef = useRef(nil)
    local scrubberRef = useRef(nil)

    local var7 = useBinding
    local startTime = if arg1 then arg1.startTime else nil
    local leftHandlePosition, var9 = var7((initialFraction(startTime, num1, 0)))

    local var10 = useBinding
    local endTime = if arg1 then arg1.endTime else nil
    local rightHandlePosition, var12 = var10((initialFraction(endTime, num1, 1)))

    local var13 = useRef(nil)
    local var14 = useRef(nil)
    local var15 = useRef(nil)

    local var16 = useRef(nil)

    local num2 = if num1 > 0 then 1 / num1 else 0

    local var17 = useCallback(function()
        if not validateRefs({ leftHandleRef }) or var16.current then
            return
        end
        var16.current = DragHandle.LeftHandle
        var13.current = leftHandlePosition:getValue()
        callback2(DragHandle.LeftHandle)
    end, { callback2 })

    local var18 = useCallback(function()
        if not validateRefs({ var13, leftHandleRef }) then
            return
        end
        local current = leftHandleRef.current

        local num3 = math.clamp(var13.current + current.DragUDim2.X.Scale, 0, rightHandlePosition:getValue() - num2)
        var9(num3)
        if callback5 then
            callback5(DragHandle.LeftHandle, num3, rightHandlePosition:getValue())
        end
    end, { num2, callback5 })

    local var19 = useCallback(function()
        if var16.current ~= DragHandle.LeftHandle then
            return
        end
        callback3(leftHandlePosition:getValue() * num1, nil)
        var16.current = nil
        var13.current = nil
        callback()
    end, { callback, callback3, num1 })

    local var20 = useCallback(function()
        if not validateRefs({ rightHandleRef }) or var16.current then
            return
        end
        var16.current = DragHandle.RightHandle
        var14.current = rightHandlePosition:getValue()
        callback2(DragHandle.RightHandle)
    end, { callback2 })

    local var21 = useCallback(function()
        if not validateRefs({ var14, rightHandleRef }) then
            return
        end
        local current = rightHandleRef.current
        local num3 = math.clamp(var14.current + current.DragUDim2.X.Scale, leftHandlePosition:getValue() + num2, 1)
        var12(num3)
        if callback5 then
            callback5(DragHandle.RightHandle, leftHandlePosition:getValue(), num3)
        end
    end, { num2, callback5 })

    local var22 = useCallback(function()
        if var16.current ~= DragHandle.RightHandle then
            return
        end
        callback3(nil, rightHandlePosition:getValue() * num1)
        var16.current = nil
        var14.current = nil
        callback()
    end, { callback, callback3, num1 })

    local var23 = useCallback(function()
        if not validateRefs({ scrubberRef, scrubberDisplayRef }) or var16.current then
            return
        end
        var16.current = DragHandle.Scrubber
        var15.current = scrubberDisplayRef.current.Position.X.Scale
        callback2(DragHandle.Scrubber)
    end, { callback2 })

    local var24 = useCallback(function()
        if not validateRefs({ var15, scrubberRef }) then
            return
        end
        local current = scrubberRef.current
        local num3 = math.clamp(var15.current + current.DragUDim2.X.Scale, 0, 1)
        callback4(num3)
    end, { callback4 })

    local var25 = useCallback(function()
        if var16.current ~= DragHandle.Scrubber then
            return
        end
        var16.current = nil
        var15.current = nil
        callback()
    end, { callback })

    local var26 = useCallback(function()
        if not validateRefs({ segmentRef }) or var16.current then
            return
        end
        var16.current = DragHandle.Segment
        var13.current = leftHandlePosition:getValue()
        var14.current = rightHandlePosition:getValue()
        callback2(DragHandle.Segment)
    end, { callback2 })

    local var27 = useCallback(function()
        if not validateRefs({ segmentRef, var13, leftHandleRef, var14, rightHandleRef }) then
            return
        end
        local scale = segmentRef.current.DragUDim2.X.Scale
        local current = var13.current
        local current2 = var14.current

        if current <= 0 and current2 >= 1 then
            return
        end

        local num3 = math.clamp(scale, -current, 1 - current2)
        local var27 = current + num3
        local var28 = current2 + num3

        var9(var27)
        var12(var28)

        callback3(var27 * num1, var28 * num1)
    end, { callback3, num1 })

    local var28 = useCallback(function()
        if var16.current ~= DragHandle.Segment then
            return
        end
        var16.current = nil
        var13.current = nil
        var14.current = nil
        callback()
    end, { callback })

    useEffect(function()
        if not bool1 then
            return
        end

        local tbl1 = {}

        if leftHandleRef.current then
            local dragStart = leftHandleRef.current.DragStart
            table.insert(tbl1, dragStart:Connect(var17))
            local dragContinue = leftHandleRef.current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var18))
            local dragEnd = leftHandleRef.current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var19))
        end

        if rightHandleRef.current then
            local dragStart = rightHandleRef.current.DragStart
            table.insert(tbl1, dragStart:Connect(var20))
            local dragContinue = rightHandleRef.current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var21))
            local dragEnd = rightHandleRef.current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var22))
        end

        if scrubberRef.current then
            local dragStart = scrubberRef.current.DragStart
            table.insert(tbl1, dragStart:Connect(var23))
            local dragContinue = scrubberRef.current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var24))
            local dragEnd = scrubberRef.current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var25))
        end

        if segmentRef.current then
            local dragStart = segmentRef.current.DragStart
            table.insert(tbl1, dragStart:Connect(var26))
            local dragContinue = segmentRef.current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var27))
            local dragEnd = segmentRef.current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var28))
        end

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, {
        bool1,
        var17,
        var18,
        var19,
        var20,
        var21,
        var22,
        var23,
        var24,
        var25,
        var26,
        var27,
        var28
    })

    return {
        dragContainerRef = dragContainerRef,
        leftHandleRef = leftHandleRef,
        rightHandleRef = rightHandleRef,
        scrubberDisplayRef = scrubberDisplayRef,
        scrubberRef = scrubberRef,
        segmentRef = segmentRef,
        leftHandlePosition = leftHandlePosition,
        rightHandlePosition = rightHandlePosition
    }
end

return useTrimDragController
