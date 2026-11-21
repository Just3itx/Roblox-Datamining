-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoverabilityModal = script:FindFirstAncestor("DiscoverabilityModal")
local DiscoverabilityModalParent = DiscoverabilityModal.Parent
local dependencies = require(DiscoverabilityModal.dependencies)
local Roact = dependencies.Roact
local Dash = dependencies.Dash
local UIBlox = dependencies.UIBlox
local RobloxAppUIBloxConfig = require(DiscoverabilityModalParent.Dev.RobloxAppUIBloxConfig)

local mockLocale = require(DiscoverabilityModalParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale

UIBlox.init(RobloxAppUIBloxConfig)

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local tbl2 = { language = "en-us" }

return {
    name = "DiscoverabilityModal",
    storyRoot = DiscoverabilityModal,
    roact = Roact,
    mapDefinition = function(arg1)
        local controls = Dash.join(tbl2, arg1.controls or {})
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
