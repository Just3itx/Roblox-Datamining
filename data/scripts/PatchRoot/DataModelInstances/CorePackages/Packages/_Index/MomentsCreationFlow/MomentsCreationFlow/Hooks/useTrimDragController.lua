-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)
local ReactOtter = require(MomentsCreationFlowParent.ReactOtter)

local useAnimatedBinding = ReactOtter.useAnimatedBinding
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef

local validateRefs = require(MomentsCreationFlow.Utils.validateRefs)

local DragHandle = require(MomentsCreationFlow.Enums.DragHandle)

local function useTrimDragController(bool1: boolean, callback: (...any) -> (...any), callback2: (...any) -> (...any), callback3: (...any) -> (...any), callback4: (...any) -> (...any), arg1, num1: number)
    local dragContainerRef = useRef(nil)
    local leftHandleRef = useRef(nil)
    local rightHandleRef = useRef(nil)
    local segmentRef = useRef(nil)
    local scrubberDisplayRef = useRef(nil)
    local scrubberRef = useRef(nil)

    local leftHandlePosition, var8 = useAnimatedBinding(arg1 and arg1.startTime / num1 or 0)

    local rightHandlePosition, var10 = useAnimatedBinding(arg1 and arg1.endTime / num1 or 1)

    local var11 = useRef(nil)
    local var12 = useRef(nil)
    local var13 = useRef(nil)

    local var14 = useRef(nil)

    local var15 = useCallback(function()
        if not validateRefs({ leftHandleRef }) or var14.current then
            return
        end
        assert(leftHandleRef.current ~= nil, "Left handle ref is nil")

        var14.current = DragHandle.LeftHandle
        var11.current = leftHandlePosition:getValue()
        callback2(DragHandle.LeftHandle)
    end, { callback2 })

    local var16 = useCallback(function()
        if not validateRefs({ var11, leftHandleRef }) then
            return
        end
        assert(var11.current ~= nil, "Left handle initial position ref is nil")
        assert(leftHandleRef.current ~= nil, "Left handle ref is nil")

        local current = leftHandleRef.current
        local num2 = math.clamp(
            var11.current + current.DragUDim2.X.Scale,
            0,
            rightHandlePosition:getValue() - MomentsCommon.Constants.MinimumVideoLength / num1
        )
        var8(ReactOtter.instant(num2))
    end, { num1 })

    local var17 = useCallback(function()
        if var14.current ~= DragHandle.LeftHandle then
            return
        end

        callback3(leftHandlePosition:getValue() * num1, nil)
        var14.current = nil
        var11.current = nil
        callback()
    end, { callback, callback3, num1 })

    local var18 = useCallback(function()
        if not validateRefs({ rightHandleRef }) or var14.current then
            return
        end
        assert(rightHandleRef.current ~= nil, "Right handle ref is nil")

        var14.current = DragHandle.RightHandle
        var12.current = rightHandlePosition:getValue()
        callback2(DragHandle.RightHandle)
    end, { callback2 })

    local var19 = useCallback(function()
        if not validateRefs({ var12, rightHandleRef }) then
            return
        end
        assert(rightHandleRef.current ~= nil, "Right handle ref is nil")

        local current = rightHandleRef.current
        local num2 = math.clamp(
            var12.current + current.DragUDim2.X.Scale,
            leftHandlePosition:getValue() + MomentsCommon.Constants.MinimumVideoLength / num1,
            1
        )
        var10(ReactOtter.instant(num2))
    end, { num1 })

    local var20 = useCallback(function()
        if var14.current ~= DragHandle.RightHandle then
            return
        end

        callback3(nil, rightHandlePosition:getValue() * num1)
        var14.current = nil
        var12.current = nil
        callback()
    end, { callback, callback3, num1 })

    local var21 = useCallback(function()
        if not validateRefs({ scrubberRef, scrubberDisplayRef }) or var14.current then
            return
        end
        assert(scrubberRef.current ~= nil, "Scrubber ref is nil")
        assert(scrubberDisplayRef.current ~= nil, "Scrubber display ref is nil")

        var14.current = DragHandle.Scrubber
        var13.current = scrubberDisplayRef.current.Position.X.Scale
        callback2(DragHandle.Scrubber)
    end, { callback2 })

    local var22 = useCallback(function()
        if not validateRefs({ var13, scrubberRef }) then
            return
        end
        assert(var13.current ~= nil, "Scrubber initial position ref is nil")
        assert(scrubberRef.current ~= nil, "Scrubber ref is nil")

        local current = scrubberRef.current
        local num2 = math.clamp(var13.current + current.DragUDim2.X.Scale, 0, 1)
        callback4(num2)
    end, { callback4 })

    local var23 = useCallback(function()
        if var14.current ~= DragHandle.Scrubber then
            return
        end

        var14.current = nil
        var13.current = nil
        callback()
    end, { callback })

    local var24 = useCallback(function()
        if not validateRefs({ segmentRef }) or var14.current then
            return
        end
        assert(segmentRef.current ~= nil, "Selected outline ref is nil")

        var14.current = DragHandle.Segment
        var11.current = leftHandlePosition:getValue()
        var12.current = rightHandlePosition:getValue()
        callback2(DragHandle.Segment)
    end, { callback2 })

    local var25 = useCallback(function()
        if not validateRefs({ segmentRef, var11, leftHandleRef, var12, rightHandleRef }) then
            return
        end
        assert(segmentRef.current ~= nil, "Selected outline ref is nil")
        assert(var11.current ~= nil, "Left handle initial position ref is nil")
        assert(leftHandleRef.current ~= nil, "Left handle ref is nil")
        assert(var12.current ~= nil, "Right handle initial position ref is nil")
        assert(rightHandleRef.current ~= nil, "Right handle ref is nil")

        local scale = segmentRef.current.DragUDim2.X.Scale

        local current = var11.current
        local current2 = var12.current

        if current <= 0 and current2 >= 1 then
            return
        end

        local num2 = math.clamp(scale, -current, 1 - current2)
        local var25 = current + num2
        local var26 = current2 + num2

        var8(ReactOtter.instant(var25))
        var10(ReactOtter.instant(var26))

        callback3(var25 * num1, var26 * num1)
    end, { callback3, num1 })

    local var26 = useCallback(function()
        if var14.current ~= DragHandle.Segment then
            return
        end
        var14.current = nil
        var11.current = nil
        var12.current = nil
        callback()
    end, { callback })

    useEffect(function()
        if not bool1 then
            return
        end

        local tbl1 = {}

        if leftHandleRef.current then
            local dragStart = leftHandleRef.current.DragStart
            table.insert(tbl1, dragStart:Connect(var15))
            local dragContinue = leftHandleRef.current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var16))
            local dragEnd = leftHandleRef.current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var17))
        end

        if rightHandleRef.current then
            local dragStart = rightHandleRef.current.DragStart
            table.insert(tbl1, dragStart:Connect(var18))
            local dragContinue = rightHandleRef.current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var19))
            local dragEnd = rightHandleRef.current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var20))
        end

        if scrubberRef.current then
            local dragStart = scrubberRef.current.DragStart
            table.insert(tbl1, dragStart:Connect(var21))
            local dragContinue = scrubberRef.current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var22))
            local dragEnd = scrubberRef.current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var23))
        end

        if segmentRef.current then
            local dragStart = segmentRef.current.DragStart
            table.insert(tbl1, dragStart:Connect(var24))
            local dragContinue = segmentRef.current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var25))
            local dragEnd = segmentRef.current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var26))
        end

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, {
        bool1,
        var15,
        var16,
        var17,
        var18,
        var19,
        var20,
        var21,
        var22,
        var23,
        var24,
        var25,
        var26
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
