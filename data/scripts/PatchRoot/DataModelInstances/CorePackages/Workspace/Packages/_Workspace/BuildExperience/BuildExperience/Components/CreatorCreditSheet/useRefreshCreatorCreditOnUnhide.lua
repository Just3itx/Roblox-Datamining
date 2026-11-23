-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")

local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local function useRefreshCreatorCreditOnUnhide<T>(func1: ((...any) -> (...any))?, tbl1)
    React.useEffect(function()
        if func1 == nil then
            return function() end
        end
        local connection = (tbl1 or AppLifecycleObserverService).OnUnhide:Connect(func1)
        return function()
            connection:Disconnect()
        end
    end, { tbl1, func1 })
end

return useRefreshCreatorCreditOnUnhide
