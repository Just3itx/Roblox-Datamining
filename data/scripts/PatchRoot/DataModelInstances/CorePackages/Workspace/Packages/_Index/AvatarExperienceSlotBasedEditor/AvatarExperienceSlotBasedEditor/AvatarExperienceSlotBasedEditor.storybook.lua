-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditor = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor")

local AvatarExperienceSlotBasedEditorParent = AvatarExperienceSlotBasedEditor.Parent
local React = require(AvatarExperienceSlotBasedEditorParent.React)
local ReactRoblox = require(AvatarExperienceSlotBasedEditorParent.ReactRoblox)
local UIBlox = require(AvatarExperienceSlotBasedEditorParent.UIBlox)
local DesignTokenProvider = require(AvatarExperienceSlotBasedEditorParent.Style).DesignTokenProvider
local LocalizationProvider = require(AvatarExperienceSlotBasedEditorParent.Localization).LocalizationProvider
local Localization = require(AvatarExperienceSlotBasedEditorParent.Dev.AppLocales).Localization
local RoactRodux = require(AvatarExperienceSlotBasedEditorParent.RoactRodux)
local Rodux = require(AvatarExperienceSlotBasedEditorParent.Rodux)
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device

UIBlox.init(require(AvatarExperienceSlotBasedEditorParent.Dev.RobloxAppUIBloxConfig))

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local function createStore()
    local reducer = Rodux.createReducer({}, {})
    return Rodux.Store.new(reducer, nil, { Rodux.makeThunkMiddleware({}) })
end

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local tbl2 = {
    Console = Device.Console,
    Desktop = Device.Desktop
}

local tbl3 = {
    Default = { themeName = "Dark", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

return {
    name = "AvatarExperienceSlotBasedEditor",
    storyRoot = AvatarExperienceSlotBasedEditor,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = tbl1[arg2.theme]

            return React.createElement(LocalizationProvider, {
                localization = Localization.new("en-us")
            }, {
                AppStyleProvider = React.createElement(AppStyleProvider, {
                    style = arg2 and tbl3[arg2.theme] or tbl3.Default
                }, {
                    StoreProvider = React.createElement(RoactRodux.StoreProvider, {
                        store = createStore()
                    }, {
                        DesignTokenProvider = React.createElement(DesignTokenProvider, {
                            tokenMappers = {}
                        }, {
                            FoundationProvider = React.createElement(
                                FoundationProvider,
                                {
                                    colorMode = colorMode,
                                    device = tbl2[arg2.platform],
                                    preferences = arg2.settings
                                },
                                {
                                    Child = React.createElement(arg1, arg2)
                                }
                            )
                        })
                    })
                })
            })
        end
    end
}
