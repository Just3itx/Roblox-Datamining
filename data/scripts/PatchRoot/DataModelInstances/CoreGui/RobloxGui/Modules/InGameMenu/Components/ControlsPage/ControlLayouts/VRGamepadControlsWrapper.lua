-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local Modules = CoreGui:WaitForChild("RobloxGui").Modules

local VRGamepadControls = script.Parent.VRGamepadControls
local HelpPage = require(CorePackages.Workspace.Packages.HelpPage)
local Foundation = require(CorePackages.Packages.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider
local React = require(CorePackages.Packages.React)
local localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization.new(LocalizationService.RobloxLocaleId)
local ControlLayoutContainer = require(script.Parent.Parent.ControlLayoutContainer)

local HelpReactView = HelpPage.HelpReactView
local FFlagHelpPageMountVR = HelpPage.Flags.FFlagHelpPageMountVR

local Utils = if FFlagHelpPageMountVR then require(Modules.Settings.Integrations).Utils else nil

if not FFlagHelpPageMountVR then
    return require(VRGamepadControls)
end

return React.memo(function() -- name: VRGamepadControlsWrapper
    return React.createElement(
        ControlLayoutContainer,
        { titleText = "CoreScripts.InGameMenu.Controls.VrControllerTitle" },
        {
            Inner = React.createElement(LocalizationProvider, { localization = localization }, {
                FoundationProvider = React.createElement(
                    FoundationProvider,
                    {
                        colorMode = Foundation.Enums.ColorMode.Dark,
                        device = Utils.getDeviceType()
                    },
                    {
                        HelpReactView = React.createElement(HelpReactView)
                    }
                )
            })
        }
    )
end)
