-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent

local React = require(SocialLuaAnalyticsParent.React)

local useLoadingTimers = require(script.Parent.useLoadingTimers)

local function useFetchTimeLogging(tbl1)
    local var1 = useLoadingTimers({})
    local var2 = React.useRef("")

    local loading = tbl1.loading
    local error = tbl1.error

    React.useEffect(function()
        if loading then
            var2.current = var1.start(tbl1.timerKey)
        end

        if loading or var2.current ~= tbl1.timerKey then
            return
        end

        local var3 = var1.stop(tbl1.timerKey)
        var2.current = ""
        if error then
            tbl1.onError(var3, tbl1.timerKey)
            return
        end
        tbl1.onSuccess(var3, tbl1.timerKey)
    end, { tbl1.timerKey, loading, error })
end

return useFetchTimeLogging
