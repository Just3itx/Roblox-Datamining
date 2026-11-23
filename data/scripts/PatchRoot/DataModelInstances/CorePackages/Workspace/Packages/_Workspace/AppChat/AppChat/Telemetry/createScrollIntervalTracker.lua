-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local AppChatParent = AppChat.Parent
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local _AppChatPerfEvent = require(AppChat.Telemetry.AppChatPerfEvent)

local var1 = require(AppChat.Logger):new("ScrollIntervalTracker")
local Cryo = require(AppChatParent.Cryo)
local ScrollIntervalTracker = require(AppChatParent.ScrollIntervalTracker)
local RunService = game:GetService("RunService")

local tbl1 = {
    minDistancePx = game:DefineFastInt("AppChatScrollPerfMinDistancePx", 50),
    stableFramesRequired = game:DefineFastInt("AppChatScrollPerfMinStableFrames", 5)
}

if game:DefineFastFlag("AppChatMigrateScrollIntervalTracker2", false) then
    local function createScrollIntervalTracker(debugName, arg1, arg2, tbl2)
        local function tryStart(arg3)
            return AppChatPerfTracker.start(debugName, arg3, arg1)
        end
        local function finish(arg3)
            AppChatPerfTracker.finish(debugName, arg3)
        end
        local var2 = Cryo.Dictionary.join(tbl1, { debugName = debugName }, tbl2 or {})
        return ScrollIntervalTracker.createScrollIntervalTracker(tryStart, finish, arg1, arg2, var2)
    end

    return createScrollIntervalTracker
end

local function createScrollIntervalTracker(arg1, arg2, arg3, tbl2)
    local var2 = Cryo.Dictionary.join(tbl1, tbl2 or {})

    local bool1 = false

    local var3 = nil
    local num1 = 0

    local num2 = 0
    local var4 = nil

    local function resetStopDetection() -- Luacid: Inlined by compiler; 3 call sites recovered
        num2 = 0
        var4 = nil
    end

    local function resetStartDetection() -- Luacid: Inlined by compiler; 5 call sites recovered
        var3 = nil
        num1 = 0
    end

    local function stopInterval(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        var1:debug("Scroll: {} stopping (reason={})", arg1, str1)
        AppChatPerfTracker.finish(arg1, arg3)
        bool1 = false
        resetStopDetection()
        resetStartDetection()
    end

    local function recordCanvasPositionChanged(num3: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        num2 = 0
        var4 = num3
    end

    local function isPastMinScrollDistance(num3: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        if var3 ~= nil then
            num1 += math.abs(num3 - var3)
        end
        var3 = num3
        return num1 >= var2.minDistancePx
    end

    local function tryStartInterval(num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
        var1:debug("Scroll: {} starting", arg1)
        if not AppChatPerfTracker.start(arg1, arg3, arg2) then
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

        local canvasPositionY = arg2.CanvasPosition.Y
        if var4 == nil then
            var4 = canvasPositionY
            num2 = 0
            return
        end

        if math.abs(canvasPositionY - var4) <= 0.5 then
            num2 += 1
        else
            num2 = 0
        end
        var4 = canvasPositionY

        if num2 >= var2.stableFramesRequired then
            stopInterval("stableFrames")
        end
    end)

    return {
        onScrollTick = function()
            local canvasPositionY = arg2.CanvasPosition.Y

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
                var1:debug("Scroll: {} cleanup/unmount", arg1)
                stopInterval("cleanup")
            end
        end
    }
end

return createScrollIntervalTracker
