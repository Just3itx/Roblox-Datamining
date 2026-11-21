-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent

local UIBlox = require(FriendsMenuParent.UIBlox)

UIBlox.init(require(FriendsMenuParent.Dev.RobloxAppUIBloxConfig))

local mockLocale = require(FriendsMenuParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale

local Cryo = require(FriendsMenuParent.Cryo)
local Roact = require(FriendsMenuParent.Dev.Roact)

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local tbl2 = { language = "en-us" }

return {
    name = "FriendsMenu",
    storyRoot = FriendsMenu,
    roact = Roact,
    mapDefinition = function(arg1)
        local controls = Cryo.Dictionary.join(tbl2, arg1.controls or {})
        return Cryo.Dictionary.join(arg1, { controls = controls })
    end,
    mapStory = function(arg1)
        return function(arg2)
            return Roact.createElement(
                AppStyleProvider,
                {
                    style = arg2 and tbl1[arg2.theme] or tbl1.Default
                },
                {
                    Child = mockLocale(arg1, arg2)
                }
            )
        end
    end
}
