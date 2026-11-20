-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppPageShell = script:FindFirstAncestor("AppPageShell")

local AppPageShellParent = AppPageShell.Parent
local React = require(AppPageShellParent.React)
local Foundation = require(AppPageShellParent.Foundation)
local ReactRoblox = require(AppPageShellParent.Dev.ReactRoblox)

local FoundationProvider = Foundation.FoundationProvider

return {
    name = AppPageShell.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(FoundationProvider, { theme = arg2.theme, device = arg2.platform }, React.createElement(arg1, arg2))
        end
    end,
    storyRoots = { AppPageShell }
}
