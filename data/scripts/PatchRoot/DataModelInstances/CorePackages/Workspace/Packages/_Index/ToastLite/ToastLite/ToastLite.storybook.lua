-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ToastLite = script:FindFirstAncestor("ToastLite")
local ToastLiteParent = ToastLite.Parent

local React = require(ToastLiteParent.React)
local UIBlox = require(ToastLiteParent.UIBlox)

local ReactRoblox = require(ToastLiteParent.Dev.ReactRoblox)
local RobloxAppUIBloxConfig = require(ToastLiteParent.Dev.RobloxAppUIBloxConfig)

UIBlox.init(RobloxAppUIBloxConfig)

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local tbl1 = {
    Default = { themeName = "Dark", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

return {
    name = "ToastLite",
    storyRoot = ToastLite,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(
                AppStyleProvider,
                {
                    style = arg2 and tbl1[arg2.theme] or tbl1.Default
                },
                {
                    Child = React.createElement(arg1, arg2)
                }
            )
        end
    end
}
