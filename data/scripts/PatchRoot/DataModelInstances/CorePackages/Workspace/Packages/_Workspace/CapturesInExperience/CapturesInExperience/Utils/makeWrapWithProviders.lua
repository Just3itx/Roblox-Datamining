-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Foundation = require(scriptParentParentParent.Foundation)
local Localization = require(scriptParentParentParent.RobloxAppLocales).Localization
local LocalizationProvider = require(scriptParentParentParent.Localization).LocalizationProvider
local React = require(scriptParentParentParent.React)
local Roact = require(scriptParentParentParent.Roact)
local RoactRodux = require(scriptParentParentParent.RoactRodux)
local Style = require(scriptParentParentParent.Style)

local FoundationProvider = Foundation.FoundationProvider
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme

local CapturesContext = require(scriptParentParent.Context.CapturesContext)
local CapturesPolicy = require(scriptParentParent.App.CapturesPolicy)
local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.Types)

local function makeWrapWithProviders(store, arg1)
    local function func1(str1: string?, tbl1)
        if not str1 then
            return tbl1
        end

        return React.createElement("Folder", { Name = str1 }, tbl1)
    end

    return function(target, value, tbl1, str1: string?, tbl2)
        local var1 = (not tbl2 or tbl2.withFoundationProvider ~= false)
            and {
                FoundationProvider = React.createElement(FoundationProvider, { colorMode = Foundation.Enums.ColorMode.Dark }, { tbl1 })
            }
            or tbl1

        return Roact.mount(
            React.createElement(RoactRodux.StoreProvider, { store = store }, {
                PolicyProvider = Roact.createElement(CapturesPolicy.Provider, {
                    policy = { CapturesPolicy.Mapper }
                }, {
                    StyleProvider = React.createElement(StyleProviderWithDefaultTheme, {
                        withDarkTheme = true
                    }, {
                        LocalizationProvider = Roact.createElement(
                            LocalizationProvider,
                            {
                                localization = Localization.new(arg1.LocalizationService.RobloxLocaleId)
                            },
                            {
                                ContextProvider = Roact.createElement(
                                    CapturesContext.Provider,
                                    { value = value },
                                    {
                                        Portal = Roact.createElement(Roact.Portal, { target = target }, func1(str1, var1))
                                    }
                                )
                            }
                        )
                    })
                })
            }),
            nil,
            Constants.ReactName
        )
    end
end

return makeWrapWithProviders
