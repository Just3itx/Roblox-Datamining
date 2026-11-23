-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Dash = require(scriptParentParent.Dash)
local Roact = require(scriptParentParent.Roact)
local SocialTestHelpers = require(scriptParentParent.Dev.SocialTestHelpers)
local UIBlox = require(scriptParentParent.UIBlox)
local RobloxAppUIBloxConfig = require(scriptParentParent.Dev.RobloxAppUIBloxConfig)

local CapturesContext = require(scriptParent.Context.CapturesContext)
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
    name = "CapturesInExperience",
    storyRoot = scriptParent,
    roact = Roact,
    mapDefinition = function(arg1)
        local controls = Dash.join(tbl2, arg1.controls)
        return Dash.join(arg1, { controls = controls })
    end,
    mapStory = function(arg1)
        return function(arg2)
            return Roact.createElement(CapturesContext.Provider, {
                value = {
                    fireAnalyticsEvent = Dash.noop
                }
            }, {
                Element = Roact.createElement(
                    AppStyleProvider,
                    {
                        style = arg2 and tbl1[arg2.theme] or tbl1.Default
                    },
                    {
                        Child = mockLocale(arg1, arg2)
                    }
                )
            })
        end
    end
}
