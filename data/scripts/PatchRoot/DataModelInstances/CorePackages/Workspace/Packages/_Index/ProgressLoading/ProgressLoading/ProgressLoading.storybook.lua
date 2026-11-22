-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local Foundation = require(ProgressLoadingParent.Foundation)
local React = require(ProgressLoadingParent.React)
local ReactRoblox = require(ProgressLoadingParent.ReactRoblox)

local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Default = Foundation.Enums.ColorMode.Dark,
    Light = Foundation.Enums.ColorMode.Light,
    Dark = Foundation.Enums.ColorMode.Dark
}

local tbl2 = { Default = "Desktop", Desktop = "Desktop", Console = "Console" }

return {
    name = "ProgressLoading",
    storyRoot = ProgressLoading,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(
                FoundationProvider,
                {
                    colorMode = arg2 and tbl1[arg2.theme] or tbl1.Default,
                    device = arg2 and tbl2[arg2.platform] or "Desktop"
                },
                {
                    Story = React.createElement(arg1, arg2)
                }
            )
        end
    end
}
