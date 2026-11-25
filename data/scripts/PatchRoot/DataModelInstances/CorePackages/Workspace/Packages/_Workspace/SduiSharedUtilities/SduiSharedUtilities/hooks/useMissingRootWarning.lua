-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local React = require(SduiSharedUtilitiesParent.React)
local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)
local SduiPageAnalytics = require(SduiSharedUtilities.SduiPageAnalytics)
local SduiRetryPolicy = require(SduiSharedUtilities.SduiRetryPolicy)

local function useMissingRootWarning(str1: string, current)
    local var1 = React.useRef(current)
    var1.current = current
    local bool1 = current ~= nil
    React.useEffect(function()
        if bool1 then
            return
        end

        local var2 = nil
        var2 = task.delay(SduiRetryPolicy.getFetchTimeoutSec() + 2, function()
            var2 = nil
            if var1.current == nil then
                local sduiApiStore = getSduiApiStore()
                SduiPageAnalytics.sendMissingRoot(str1, sduiApiStore.getData(str1).status(false), sduiApiStore.isInFlight(str1))
            end
        end)

        return function()
            if var2 then
                task.cancel(var2)
                var2 = nil
            end
        end
    end, { str1, bool1 })
end

return useMissingRootWarning
