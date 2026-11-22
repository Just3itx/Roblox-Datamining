-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerContextualMenu = script:FindFirstAncestor("PlayerContextualMenu")

local PlayerContextualMenuParent = PlayerContextualMenu.Parent

local Dash = require(PlayerContextualMenuParent.Dash)
local Roact = require(PlayerContextualMenuParent.Dev.Roact)
local SocialTestHelpers = require(PlayerContextualMenuParent.Dev.SocialTestHelpers)
local UIBlox = require(PlayerContextualMenuParent.UIBlox)

local RobloxAppUIBloxConfig = require(PlayerContextualMenuParent.Dev.RobloxAppUIBloxConfig)

local mockLocale = SocialTestHelpers.StoryHelpers.mockLocale

UIBlox.init(RobloxAppUIBloxConfig)

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

Roact.setGlobalConfig({ elementTracing = true })

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local tbl2 = { language = "en-us" }

return {
    name = "PlayerContextualMenu",
    storyRoot = PlayerContextualMenu,
    roact = Roact,
    mapDefinition = function(arg1)
        local controls = Dash.join(tbl2, arg1.controls)
        return Dash.join(arg1, { controls = controls })
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
