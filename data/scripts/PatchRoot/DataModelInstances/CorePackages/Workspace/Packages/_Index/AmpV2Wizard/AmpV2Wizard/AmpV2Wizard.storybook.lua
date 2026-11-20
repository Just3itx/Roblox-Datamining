-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2WizardParent = script:FindFirstAncestor("AmpV2Wizard").Parent

local Foundation = require(AmpV2WizardParent.Foundation)
local React = require(AmpV2WizardParent.React)
local ReactRoblox = require(AmpV2WizardParent.ReactRoblox)
local UIBlox = require(AmpV2WizardParent.UIBlox)
UIBlox.init(require(AmpV2WizardParent.Dev.RobloxAppUIBloxConfig))
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local RoactAppPolicy = require(AmpV2WizardParent.UniversalAppPolicy).RoactAppPolicy
local AppFeaturePolicies = require(AmpV2WizardParent.UniversalAppPolicy).AppFeaturePolicies

local Rodux = require(AmpV2WizardParent.Dev.Rodux)
local RoactRodux = require(AmpV2WizardParent.Dev.RoactRodux)
local LocalizationProvider = require(AmpV2WizardParent.Localization).LocalizationProvider
local Localization = require(AmpV2WizardParent.Dev.AppLocales).Localization

local FoundationProvider = Foundation.FoundationProvider

local store = Rodux.Store.new(function()
    return {
        ScreenSize = Vector2.new(390, 844)
    }
end, {
    ScreenSize = Vector2.new(390, 844)
}, { Rodux.thunkMiddleware })

local localization = Localization.new("en-us")

local tbl1 = {
    Default = Foundation.Enums.ColorMode.Dark,
    Light = Foundation.Enums.ColorMode.Light,
    Dark = Foundation.Enums.ColorMode.Dark
}

local tbl2 = {
    Default = "Desktop",
    Desktop = "Desktop",
    Tablet = "Tablet",
    Phone = "Phone",
    Console = "Console"
}

return {
    name = script.Parent.Name,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(
                RoactAppPolicy.Provider,
                {
                    policy = { AppFeaturePolicies },
                    policyData = { hasWebViewSupportForFAE = true }
                },
                {
                    Store = React.createElement(RoactRodux.StoreProvider, { store = store }, {
                        Localization = React.createElement(LocalizationProvider, {
                            localization = localization
                        }, {
                            Foundation = React.createElement(
                                FoundationProvider,
                                {
                                    colorMode = arg2 and tbl1[arg2.theme] or tbl1.Default,
                                    device = arg2 and tbl2[arg2.platform] or "Desktop"
                                },
                                {
                                    AppStyle = React.createElement(
                                        AppStyleProvider,
                                        {
                                            style = {
                                                themeName = arg2 and tbl1[arg2.theme] or tbl1.Default,
                                                fontName = "Gotham"
                                            }
                                        },
                                        {
                                            Story = React.createElement(arg1, arg2)
                                        }
                                    )
                                }
                            )
                        })
                    })
                }
            )
        end
    end,
    storyRoots = { script.Parent }
}
