-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)

local GuiService = game:GetService("GuiService")

local useCallback = React.useCallback
local useEffect = React.useEffect
local useMemo = React.useMemo
local useRef = React.useRef
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets

local computeSeekFraction = require(MomentsCreation.Utils.computeSeekFraction)
local FFlagMomentsTTSScrubberDragInOverlay = require(MomentsCreation.Flags.FFlagMomentsTTSScrubberDragInOverlay)
local FFlagMomentsScrubberSeekOnRelease = require(MomentsCreation.Flags.FFlagMomentsScrubberSeekOnRelease)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local engineFeature = game:GetEngineFeature("UIDragDetectorFixEventPositionEnabled")

local function useTimelineSeekController(arg1, callback: ((...any) -> (...any))?, bool1: boolean, bool2: boolean)
    local containerRef = useRef(nil)
    local dragDetectorRef = useRef(nil)

    local playheadDragDetectorRef = if FFlagMomentsTTSScrubberDragInOverlay then useRef(nil) else nil

    local var4 = useRef(false)
    local var5 = useRef(false)

    local var6 = nil
    local get = nil
    local set = nil
    if FFlagMomentsScrubberSeekOnRelease then
        var6 = useRef(nil)

        local var7 = useMemo(function()
            local var1, var2 = Signals.createSignal(nil)
            return { get = var1, set = var2 }
        end, {})
        get = var7.get
        set = var7.set
    end

    local var7 = useDeviceInsets()

    local var8 = useCallback(function(num1: number)
        local current = containerRef.current
        if not current then
            return
        end
        local var8 = computeSeekFraction(num1, current.AbsolutePosition.X, current.AbsoluteSize.X)
        local var1 = var8 * arg1.getDuration(false)
        if FFlagMomentsScrubberSeekOnRelease and set and var6 then
            set(var8)
            var6.current = var1
            return
        end
        arg1.seek(var1)
        if callback then
            callback(var1)
        end
    end, { arg1, callback, set })

    local var9 = useCallback(function(vector2: Vector2)
        if engineFeature then
            return vector2.X
        end
        local vector2_2 = GuiService:GetGuiInset()
        return vector2.X - (vector2_2.X + var7.left)
    end, { var7 })

    local var10 = useCallback(function()
        if arg1.getIsPlaying(false) then
            var5.current = true
            arg1.toggle()
        end
    end, { arg1 })

    local var11 = useCallback(function(vector2: Vector2)
        var4.current = true

        if bool2 then
            return
        end
        var10()
        var8(var9(vector2))
    end, {
        var10,
        var8,
        var9,
        bool2
    })
    local var12 = useCallback(function(vector2: Vector2)
        if not var4.current then
            return
        end
        if bool2 then
            var10()
        end
        var8(var9(vector2))
    end, {
        var10,
        var8,
        var9,
        bool2
    })
    local var13 = useCallback(function()
        if not var4.current then
            return
        end
        var4.current = false
        if FFlagMomentsScrubberSeekOnRelease and var6 and set then
            local current = var6.current
            var6.current = nil
            if current ~= nil then
                arg1.seek(current)
                if callback then
                    callback(current)
                end
            end
            set(nil)
        end
        if var5.current and not arg1.getIsPlaying(false) then
            arg1.toggle()
        end
        var5.current = false
    end, { arg1, callback, set })

    useEffect(function()
        if not bool1 then
            return
        end
        local current = dragDetectorRef.current
        if current == nil then
            return
        end
        local tbl1 = { current.DragStart:Connect(var11), current.DragContinue:Connect(var12), current.DragEnd:Connect(var13) }

        if FFlagMomentsTTSScrubberDragInOverlay and playheadDragDetectorRef then
            local current2 = playheadDragDetectorRef.current
            if current2 ~= nil then
                local dragStart = current2.DragStart
                table.insert(tbl1, dragStart:Connect(var11))
                local dragContinue = current2.DragContinue
                table.insert(tbl1, dragContinue:Connect(var12))
                local dragEnd = current2.DragEnd
                table.insert(tbl1, dragEnd:Connect(var13))
            end
        end
        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, {
        bool1,
        var11,
        var12,
        var13
    })
    return {
        containerRef = containerRef,
        dragDetectorRef = dragDetectorRef,
        playheadDragDetectorRef = playheadDragDetectorRef,
        getDragFraction = get
    }
end

return useTimelineSeekController
