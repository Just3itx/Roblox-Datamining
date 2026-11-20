-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppPageShell = script:FindFirstAncestor("AppPageShell")
local AppPageShellParent = AppPageShell.Parent

local _AppCommonLib = require(AppPageShellParent.AppCommonLib)
local React = require(AppPageShellParent.React)

local _PageTypes = require(AppPageShell.PageTypes)
local _createPageScrollStore = require(AppPageShell.createPageScrollStore)

return React.createContext(
    {
        scrollViewPositionChangedSignal = nil,
        verticalScrollingFrameRef = nil,
        impressionsParentScrollingFrameRef = nil
    }
)
