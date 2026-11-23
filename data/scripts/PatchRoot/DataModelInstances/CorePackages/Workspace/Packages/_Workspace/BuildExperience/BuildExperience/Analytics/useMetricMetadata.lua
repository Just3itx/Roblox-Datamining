-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local getCreatorAnalyticsStore = require(BuildExperienceParent.DataHydration.CreatorAnalytics).getCreatorAnalyticsStore

local function useMetricMetadata(current, num1: number?)
    local str1 = table.concat(current, ",")

    local var1 = getCreatorAnalyticsStore(false).getAndFetchMetricMetadata(current)
    local latestByMetric = SignalsReact.useSignalState(var1.data)
    local status = SignalsReact.useSignalState(var1.status)

    local var4 = React.useRef(current)
    var4.current = current

    local num2 = num1 or 600
    React.useEffect(function()
        local var5 = nil
        local function scheduleRefresh() -- Luacid: Inlined by compiler; 1 call site recovered
            var5 = task.delay(num2, function()
                getCreatorAnalyticsStore(false).getAndFetchMetricMetadata(var4.current)
                scheduleRefresh()
            end)
        end

        scheduleRefresh()

        return function()
            if var5 ~= nil then
                task.cancel(var5)
            end
        end
    end, { str1, num2 })

    return { latestByMetric = latestByMetric, status = status }
end

return useMetricMetadata
