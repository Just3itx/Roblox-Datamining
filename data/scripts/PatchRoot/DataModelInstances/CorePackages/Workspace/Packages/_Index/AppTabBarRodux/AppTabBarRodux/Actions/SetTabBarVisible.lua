-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppTabBarRoduxParent = script:FindFirstAncestor("AppTabBarRodux").Parent
return require(AppTabBarRoduxParent.Rodux).makeActionCreator(script.Name, function(isVisible)
    return { isVisible = isVisible }
end)
