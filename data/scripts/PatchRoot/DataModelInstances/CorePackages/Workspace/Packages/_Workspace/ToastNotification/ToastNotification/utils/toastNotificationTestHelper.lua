-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)

local Rodux = require(scriptParentParentParent.Rodux)
local RoactRodux = require(scriptParentParentParent.RoactRodux)
local RoactServices = require(scriptParentParentParent.RoactServices).RoactServices
local LocalizationProvider = require(scriptParentParentParent.Localization).LocalizationProvider
local Localization = require(scriptParentParentParent.RobloxAppLocales).Localization

local Foundation = require(scriptParentParentParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode

local AppStyleProvider = require(scriptParentParentParent.Style).AppStyleProvider
local Constants = require(scriptParentParentParent.Style).Constants

local style = {
    themeName = ColorMode.Dark,
    fontName = Constants.FontName.Gotham,
    Tokens = {
        Global = { Size_350 = 28, Size_500 = 40 }
    }
}

local tbl2 = {
    ScreenSize = Vector2.new(500, 500),
    SetAlias = {
        Aliases = {
            byUserId = { ["1"] = "foo" }
        }
    }
}

local function func1(arg1, arg2)
    return Rodux.Store.new(arg2 or function<T>(arg3: T): T
        return arg3
    end, arg1 or {}, { Rodux.thunkMiddleware })
end

local localization = Localization.new("en-us")

return {
    mockServices = function(arg1)
        local tbl3 = {
            storeProvider = React.createElement(RoactRodux.StoreProvider, {
                store = func1(tbl2)
            }, {
                foundationProvider = React.createElement(FoundationProvider, {
                    colorMode = ColorMode.Dark
                }, {
                    styleProvider = React.createElement(
                        AppStyleProvider,
                        { style = style },
                        {
                            localizationProvider = React.createElement(LocalizationProvider, { localization = localization }, arg1)
                        }
                    )
                })
            })
        }
        return (React.createElement(RoactServices.ServiceProvider, {}, tbl3))
    end
}
