-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local Roact = dependencies.Roact
local llama = dependencies.llama

return function(arg1, tbl1)
    local var1 = Roact.PureComponent:extend("LoadingTimer")

    function var1.init(arg2)
        arg2.loadingTime = { startTime = nil, endTime = nil, thresholdCanceled = false }

        function arg2.startThresholdTimer()
            if not tbl1.loadingThreshold then
                return
            end

            delay(tbl1.loadingThreshold, function()
                if tbl1.onReachingThreshold and not arg2.thresholdCanceled and not arg2.loadingTime.endTime and arg2.loadingTime.startTime then
                    arg2.stopTimer(true)
                    tbl1.onReachingThreshold(arg2.getLoadingTime(), arg2.props)
                end
            end)
        end

        function arg2.resetTimer()
            arg2.loadingTime = { startTime = nil, endTime = nil }
        end

        function arg2.startTimer()
            arg2.loadingTime.startTime = os.clock()

            arg2.startThresholdTimer()
        end

        function arg2.stopTimer(arg3)
            if arg2.loadingTime.endTime then
                return
            end

            arg2.loadingTime.endTime = os.clock()

            if tbl1.onLoaded and not arg3 then
                tbl1.onLoaded(arg2.getLoadingTime(), arg2.props)
            end
        end

        function arg2.getLoadingTime()
            if arg2.loadingTime.endTime and arg2.loadingTime.startTime then
                return arg2.loadingTime.endTime - arg2.loadingTime.startTime
            end

            return -1
        end

        function arg2.cancelThreshold()
            arg2.thresholdCanceled = true
        end
    end

    function var1.render(arg2)
        return Roact.createElement(
            arg1,
            llama.Dictionary.join(arg2.props, {
                loadingTimerProps = {
                    startTimer = arg2.startTimer,
                    stopTimer = arg2.stopTimer,
                    resetTimer = arg2.resetTimer,
                    getLoadingTime = arg2.getLoadingTime,
                    cancelThreshold = arg2.cancelThreshold
                }
            })
        )
    end

    return var1
end
