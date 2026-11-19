-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")

local Roact = require(CorePackages.Packages.Roact)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider

local FTUXPanel = require(script.Components.FTUXPanel)
local GetFeatures = require(script.Features.GetFeatures)

local _PlatformEnum = require(script.Enums.PlatformEnum)

return {
    mountFtuxMenu = function(platform)
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        local element = Roact.createElement(
            LocalizationProvider,
            {
                localization = Localization.new(LocalizationService.RobloxLocaleId)
            },
            {
                FTUXMenu = Roact.createElement("ScreenGui", {}, {
                    ThemeProvider = renderWithCoreScriptsStyleProvider({ FtuxPanel = Roact.createElement(FTUXPanel, { platform = platform }, {}) })
                })
            }
        )

        GetFeatures(platform)
        Roact.mount(element, CoreGui, "FTUXMenu")
    end
}
