-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local React = require(MomentsCreationParent.React)
local ReactOtter = require(MomentsCreationParent.ReactOtter)

local useAnimatedBinding = ReactOtter.useAnimatedBinding
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef

local SegmentSelectorWidth = require(MomentsCreation.Constants).AudioWaveform.SegmentSelectorWidth

local function useMusicEditorController(bool1: boolean, callback: (...any) -> (...any), callback2: (...any) -> (...any), callback3: (...any) -> (...any), arg1, num1: number)
    local waveformRef = useRef(nil)
    local waveformDisplayRef = useRef(nil)
    local waveformPosition, var4 = useAnimatedBinding(0)
    local var5 = useRef(nil)

    local var6 = useCallback(function()
        var5.current = waveformPosition:getValue()
        callback2()
    end, { callback2 })

    local var7 = useCallback(function()
        local current = waveformRef.current
        local current2 = waveformDisplayRef.current
        if current == nil or current2 == nil then
            return
        end

        local current3 = var5.current or 0
        local var7 = current.DragUDim2.X.Offset / SegmentSelectorWidth
        local var8 = current2.AbsoluteSize.X / SegmentSelectorWidth

        if 1 - var8 > 0 then
            return
        end

        local num2 = math.clamp(current3 + var7, 1 - var8, 0)
        callback3(num1 * (-num2 / var8))
        var4(ReactOtter.instant(num2))
    end, { num1, callback3 })

    local var8 = useCallback(function()
        var5.current = nil
        callback()
    end, { callback })

    useEffect(function()
        if not bool1 then
            return
        end

        local tbl1 = {}
        local current = waveformRef.current
        if current ~= nil then
            local dragStart = current.DragStart
            table.insert(tbl1, dragStart:Connect(var6))
            local dragContinue = current.DragContinue
            table.insert(tbl1, dragContinue:Connect(var7))
            local dragEnd = current.DragEnd
            table.insert(tbl1, dragEnd:Connect(var8))
        end

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, {
        bool1,
        var6,
        var7,
        var8
    })
    useEffect(function()
        local current = waveformDisplayRef.current
        if current == nil or num1 <= 0 then
            return
        end

        local var9 = current.AbsoluteSize.X / SegmentSelectorWidth
        var4(ReactOtter.instant(-arg1.startTime / num1 * var9))
    end, { arg1.startTime, num1 })

    return {
        waveformRef = waveformRef,
        waveformPosition = waveformPosition,
        waveformDisplayRef = waveformDisplayRef
    }
end

return useMusicEditorController
