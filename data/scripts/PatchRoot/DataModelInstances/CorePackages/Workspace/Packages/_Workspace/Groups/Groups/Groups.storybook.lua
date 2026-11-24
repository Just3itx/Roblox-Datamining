-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local ReactRoblox = require(GroupsParent.Dev.ReactRoblox)
local UIBlox = require(GroupsParent.UIBlox)
local Rodux = require(GroupsParent.Dev.Rodux)
local RoactRodux = require(GroupsParent.Dev.RoactRodux)

local DesignTokenProvider = require(GroupsParent.Style).DesignTokenProvider
local LocalizationProvider = require(GroupsParent.Localization).LocalizationProvider

local FoundationProvider = require(GroupsParent.Foundation).FoundationProvider

local Signal = require(GroupsParent.AppCommonLib).Signal

UIBlox.init(require(GroupsParent.Dev.RobloxAppUIBloxConfig))
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local function createStore()
    local reducer = Rodux.createReducer({}, {})
    return Rodux.Store.new(reducer, nil, { Rodux.thunkMiddleware })
end

local tbl1 = {
    Default = { themeName = "Dark", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local localization = {
    Format = function(_, str1: string): string
        return str1
    end,
    GetLocale = function(): string
        return "en-us"
    end,
    changed = Signal.new()
}

return {
    name = Groups and Groups.Name or "Groups",
    storyRoot = Groups,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local style = arg2 and tbl1[arg2.theme] or tbl1.Default
            local themeName = style.themeName

            return React.createElement(LocalizationProvider, { localization = localization }, {
                FoundationProvider = React.createElement(FoundationProvider, {
                    device = "Desktop",
                    colorMode = themeName
                }, {
                    AppStyleProvider = React.createElement(AppStyleProvider, { style = style }, {
                        StoreProvider = React.createElement(RoactRodux.StoreProvider, {
                            store = createStore()
                        }, {
                            DesignTokenProvider = React.createElement(DesignTokenProvider, { tokenMappers = {} }, { Child = React.createElement(arg1, arg2) })
                        })
                    })
                })
            })
        end
    end
}
