-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local React = require(SduiSharedUtilitiesParent.React)

local function useLocalAnalyticsData(configKey: string, appPage: string, tbl1)
    return React.useMemo(function()
        local var1 = not tbl1 and {} or tbl1
        var1.configKey = configKey
        var1.appPage = appPage
        return var1
    end, { configKey, appPage, tbl1 })
end

return useLocalAnalyticsData
