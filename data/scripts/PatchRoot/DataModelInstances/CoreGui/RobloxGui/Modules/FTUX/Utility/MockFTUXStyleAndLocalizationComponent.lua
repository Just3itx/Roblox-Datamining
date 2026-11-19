-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local LocalizationService = game:GetService("LocalizationService")

local renderWithCoreScriptsStyleProvider = require(script.Parent.Parent.Parent.Common.renderWithCoreScriptsStyleProvider)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider

return function(arg1)
    return Roact.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            FTUXMock = Roact.createElement("ScreenGui", {}, {
                ThemeProvider = renderWithCoreScriptsStyleProvider({ Frame = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0) }, arg1) })
            })
        }
    )
end
