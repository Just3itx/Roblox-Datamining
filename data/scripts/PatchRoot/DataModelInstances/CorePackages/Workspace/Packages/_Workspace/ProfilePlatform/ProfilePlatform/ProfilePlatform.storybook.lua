-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Roact = require(ProfilePlatformParent.Dev.Roact)

local RoactRodux = require(ProfilePlatformParent.RoactRodux)
local Rodux = require(ProfilePlatformParent.Rodux)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local Cryo = require(ProfilePlatformParent.Cryo)
local mockLocale = require(ProfilePlatformParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale
local RobloxAppUIBloxConfig = require(ProfilePlatformParent.Dev.RobloxAppUIBloxConfig)

UIBlox.init(RobloxAppUIBloxConfig)

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

Roact.setGlobalConfig({ elementTracing = true })

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local tbl2 = { language = "en-us" }

local function func1(arg1)
    return Rodux.Store.new(function()
        return Cryo.Dictionary.join(arg1, { ScreenSize = Vector2.new(600, 600) })
    end, {}, { Rodux.thunkMiddleware })
end

return {
    name = "ProfilePlatform",
    storyRoot = ProfilePlatform,
    roact = Roact,
    roactRodux = RoactRodux,
    mapDefinition = function(arg1)
        local controls = Cryo.Dictionary.join(tbl2, arg1.controls or {})
        return Cryo.Dictionary.join(arg1, { controls = controls })
    end,
    mapStory = function(arg1)
        return function(arg2)
            local state = arg2.definition.state or {}
            return Roact.createElement(AppStyleProvider, {
                style = arg2 and tbl1[arg2.theme] or tbl1.Default
            }, {
                storeProvider = Roact.createElement(RoactRodux.StoreProvider, { store = func1(state) }, { Child = mockLocale(arg1, arg2) })
            })
        end
    end
}
