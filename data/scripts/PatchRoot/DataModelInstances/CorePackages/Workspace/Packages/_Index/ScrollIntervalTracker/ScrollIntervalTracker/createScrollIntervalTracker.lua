-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ScrollIntervalTracker = script:FindFirstAncestor("ScrollIntervalTracker")
local ScrollIntervalTrackerParent = ScrollIntervalTracker.Parent

local Logger = require(ScrollIntervalTracker.Logger)
local Cryo = require(ScrollIntervalTrackerParent.Cryo)

local RunService = game:GetService("RunService")

local tbl1 = { minDistancePx = 50, stableFramesRequired = 5 }

local function createScrollIntervalTracker(func1: (...any) -> (...any), callback: (...any) -> (...any), arg1, arg2, tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2 or {})

    local bool1 = false

    local var2 = nil
    local num1 = 0

    local num2 = 0
    local var3 = nil

    local function resetStopDetection() -- Luacid: Inlined by compiler; 3 call sites recovered
        num2 = 0
        var3 = nil
    end

    local function resetStartDetection() -- Luacid: Inlined by compiler; 5 call sites recovered
        var2 = nil
        num1 = 0
    end

    local function stopInterval(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        Logger:debug("Scroll {} stopping (reason={})", var1.debugName, str1)
        callback(arg2)
        bool1 = false
        resetStopDetection()
        resetStartDetection()
    end

    local function recordCanvasPositionChanged(num3: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        num2 = 0
        var3 = num3
    end

    local function isPastMinScrollDistance(num3: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        if var2 ~= nil then
            num1 += math.abs(num3 - var2)
        end
        var2 = num3
        return num1 >= var1.minDistancePx
    end

    local function tryStartInterval(num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
        Logger:debug("Scroll {} starting", var1.debugName)
        if not func1(arg2) then
            return
        end

        bool1 = true
        resetStartDetection()
        recordCanvasPositionChanged(num3)
    end

    local connection = RunService.RenderStepped:Connect(function()
        if not bool1 then
            return
        end

        local canvasPositionY = arg1.CanvasPosition.Y
        if var3 == nil then
            var3 = canvasPositionY
            num2 = 0
            return
        end

        if math.abs(canvasPositionY - var3) <= 0.5 then
            num2 += 1
        else
            num2 = 0
        end
        var3 = canvasPositionY

        if num2 >= var1.stableFramesRequired then
            stopInterval("stableFrames")
        end
    end)

    return {
        onScrollTick = function()
            local canvasPositionY = arg1.CanvasPosition.Y

            if bool1 then
                recordCanvasPositionChanged(canvasPositionY)
                return
            end

            if not isPastMinScrollDistance(canvasPositionY) then
                return
            end

            tryStartInterval(canvasPositionY)
        end,
        cleanup = function()
            if connection then
                connection:Disconnect()
            end

            if bool1 then
                Logger:debug("Scroll {} cleanup/unmount", var1.debugName)
                stopInterval("cleanup")
            end
        end
    }
end

return createScrollIntervalTracker
