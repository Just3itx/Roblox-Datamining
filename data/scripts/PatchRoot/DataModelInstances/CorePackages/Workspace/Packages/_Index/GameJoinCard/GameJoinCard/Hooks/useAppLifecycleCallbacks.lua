-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")

local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)

local function useAppLifecycleCallbacks(func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?, tbl1)
    local var1 = tbl1 or AppLifecycleObserverService

    React.useEffect(function()
        if func1 == nil then
            return nil
        end
        local connection = var1.OnHide:Connect(func1)
        return function()
            connection:Disconnect()
        end
    end, { func1, var1 })

    React.useEffect(function()
        if func2 == nil then
            return nil
        end
        local connection = var1.OnUnhide:Connect(func2)
        return function()
            connection:Disconnect()
        end
    end, { func2, var1 })
end

return useAppLifecycleCallbacks
