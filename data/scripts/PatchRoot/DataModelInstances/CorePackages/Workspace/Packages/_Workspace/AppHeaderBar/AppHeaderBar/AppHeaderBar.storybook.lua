-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppHeaderBar = script:FindFirstAncestor("AppHeaderBar")
local AppHeaderBarParent = AppHeaderBar.Parent
local RoactCompat = require(AppHeaderBarParent.Dev.RoactCompat)
local React = require(AppHeaderBarParent.React)
local RobloxAppUIBloxConfig = require(AppHeaderBarParent.Dev.RobloxAppUIBloxConfig)
local UIBlox = require(AppHeaderBarParent.UIBlox)

UIBlox.init(RobloxAppUIBloxConfig)

local ColorMode = require(AppHeaderBarParent.Foundation).Enums.ColorMode

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Constants = UIBlox.App.Style.Constants
local Light = ColorMode.Light
local Dark = ColorMode.Dark
local Gotham = Constants.FontName.Gotham

RoactCompat.setGlobalConfig({ elementTracing = true })

local tbl1 = {
    Default = { themeName = Light, fontName = Gotham },
    Light = { themeName = Light, fontName = Gotham },
    Dark = { themeName = Dark, fontName = Gotham }
}

local tbl2 = {
    Console = Constants.DeviceType.Console,
    Desktop = Constants.DeviceType.Desktop
}

return {
    name = "AppHeaderBar",
    storyRoots = { AppHeaderBar },
    roact = RoactCompat,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = tbl1[arg2.theme]
            return React.createElement(AppStyleProvider, {
                style = {
                    themeName = var1.themeName,
                    fontName = var1.fontName,
                    deviceType = tbl2[arg2.platform],
                    settings = arg2.settings
                }
            }, {
                Child = React.createElement(arg1, arg2)
            })
        end
    end
}
