-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local Logger = require(FriendsLanding.Logger)
local dependencies = require(FriendsLanding.dependencies)
local AppStyleProvider = dependencies.UIBlox.App.Style.AppStyleProvider
local Roact = dependencies.Roact
local UniversalAppPolicy = dependencies.UniversalAppPolicy
local llama = dependencies.llama

local FriendsLandingParent = FriendsLanding.Parent
local mockLocale = require(FriendsLandingParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale

local Foundation = require(FriendsLandingParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode

local logger = dependencies.Lumberyak.Logger.new()

logger:addSink({
    maxLevel = logger.Levels.fromString("info"),
    log = function(_, arg1, _)
        print(arg1)
    end
})

Logger:setParent(logger)

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local tbl2 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local tbl3 = { language = "en-us" }

return {
    mapDefinition = function(arg1)
        local controls = llama.Dictionary.join(tbl3, arg1.controls or {})
        return llama.Dictionary.join(arg1, { controls = controls })
    end,
    roact = Roact,
    mapStory = function(arg1)
        return function(arg2)
            local style = arg2 and tbl1[arg2.theme] or tbl1.Default

            return Roact.createElement(FoundationProvider, {
                colorMode = tbl2[style.themeName]
            }, {
                AppStyle = Roact.createElement(AppStyleProvider, { style = style }, {
                    Roact.createElement(UniversalAppPolicy.Provider, {
                        policy = {
                            function()
                                return {
                                    getShowDisplayName = function()
                                        return arg2.controls.getShowDisplayName
                                    end
                                }
                            end
                        }
                    }, {
                        Child = mockLocale(arg1, arg2)
                    })
                })
            })
        end
    end
}
