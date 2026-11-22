-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local MomentsCommon = require(MomentsParent.MomentsCommon)

local _FeedTypes = require(script.Parent.FeedTypes)
local swipeLatencyMachine = require(script.Parent.swipeLatencyMachine)

local Analytics = MomentsCommon.Analytics

local tbl1 = { video = "video", screenshot = "screenshot", unknown = "unknown" }

local num1 = game:DefineFastInt("MomentsSwipeLatencyCapMs", 15000)

local function fireSwipeLatency(num2: number, num3: number, arg1)
    Analytics.fireAnalyticsEvent(
        Analytics.EventNames.MomentsSwipeLatency,
        {
            mediaWaitMs = tostring(num2),
            totalLatencyMs = tostring(num3),
            captureType = tbl1[arg1.captureType] or "unknown"
        }
    )
end

local function useSwipeLatency(tbl2)
    local getIsSettled = tbl2.getIsSettled
    local getHasPresentedFrame = tbl2.getHasPresentedFrame
    local getTargetHasPresentedFrame = tbl2.getTargetHasPresentedFrame
    local getCaptureType = tbl2.getCaptureType

    local var1 = React.useRef(tbl2.onMeasurement or fireSwipeLatency)
    var1.current = tbl2.onMeasurement or fireSwipeLatency

    local var2 = React.useMemo(function()
        local now = tbl2.now or function(): number
            return os.clock() * 1000
        end
        return swipeLatencyMachine({
            now = now,
            capMs = tbl2.capMs or num1,
            onMeasurement = function(arg1, arg2, arg3)
                var1.current(arg1, arg2, arg3)
            end
        })
    end, {})

    local var3 = React.useCallback(function(_: number, _: number, arg1)
        var2.start(getIsSettled(false), getTargetHasPresentedFrame(arg1), { captureType = getCaptureType(arg1) })
    end, {
        var2,
        getIsSettled,
        getTargetHasPresentedFrame,
        getCaptureType
    })
    React.useEffect(function()
        return (Signals.createEffect(function(arg1)
            var2.update(getIsSettled(arg1), getHasPresentedFrame(arg1))
        end))
    end, { getIsSettled, getHasPresentedFrame, var2 })

    return var3
end

return useSwipeLatency
