-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent
local React = require(RobloxAppNavigationParent.React)
local AppPage = require(RobloxAppNavigationParent.RobloxAppEnums).AppPage

return React.createContext(AppPage.None)
