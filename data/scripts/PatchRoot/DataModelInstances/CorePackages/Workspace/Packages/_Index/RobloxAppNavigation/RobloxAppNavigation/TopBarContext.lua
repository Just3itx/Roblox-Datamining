-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent
return require(RobloxAppNavigationParent.React).createContext({
    render = function<T>(arg1: T): T
        return arg1
    end
})
