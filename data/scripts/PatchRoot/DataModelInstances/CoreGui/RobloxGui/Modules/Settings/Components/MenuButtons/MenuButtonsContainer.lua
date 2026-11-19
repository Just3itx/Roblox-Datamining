-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")

local React = require(CorePackages.Packages.React)
local _Signals = require(CorePackages.Packages.Signals)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider

local Foundation = require(CorePackages.Packages.Foundation)
local FoundationProvider = Foundation.FoundationProvider

local MenuButtons = require(script.Parent.MenuButtons)

local function Container(tbl1)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    return React.createElement(LocalizationProvider, { localization = localization }, {
        FoundationProvider = React.createElement(
            FoundationProvider,
            {
                colorMode = Foundation.Enums.ColorMode.Dark
            },
            {
                MenuButtons = React.createElement(MenuButtons, tbl1)
            }
        )
    })
end
return Container
