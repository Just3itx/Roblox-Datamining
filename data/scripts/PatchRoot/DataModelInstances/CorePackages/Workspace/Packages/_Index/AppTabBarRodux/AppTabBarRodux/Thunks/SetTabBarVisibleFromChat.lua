-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppTabBarRodux = script:FindFirstAncestor("AppTabBarRodux")
local AppTabBarRoduxParent = AppTabBarRodux.Parent

local ArgCheck = require(AppTabBarRoduxParent.ArgCheck)
local SetTabBarVisible = require(AppTabBarRodux.Actions.SetTabBarVisible)

return function(tabBarVisible)
    ArgCheck.isType(tabBarVisible, "boolean", "SetTabBarVisibleFromChat.isVisible")

    return function(arg1)
        if arg1:getState().TabBarVisible ~= tabBarVisible then
            arg1:dispatch(SetTabBarVisible(tabBarVisible))
        end
    end
end
