-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppTabBarRodux = script:FindFirstAncestor("AppTabBarRodux")
local SetTabBarVisible = require(AppTabBarRodux.Actions.SetTabBarVisible)

return function(bool1: boolean?, arg1)
    if bool1 == nil then
        bool1 = false
    end

    if arg1.type == SetTabBarVisible.name then
        bool1 = arg1.isVisible
    end

    return bool1
end
