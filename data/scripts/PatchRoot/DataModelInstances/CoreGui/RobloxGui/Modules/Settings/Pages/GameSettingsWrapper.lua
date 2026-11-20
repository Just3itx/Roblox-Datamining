-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Modules = CoreGui:WaitForChild("RobloxGui").Modules

local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)

local Flags = require(Modules.Settings.Flags)
local SettingsPageFactory = require(Modules.Settings.SettingsPageFactory)

local FFlagRefactorInExpSettingsInDevelopment = Flags.FFlagRefactorInExpSettingsInDevelopment

local Utils = nil
local Constants = nil
if FFlagRefactorInExpSettingsInDevelopment then
    local integrations = require(Modules.Settings.Integrations)
    Utils = integrations.Utils
    Constants = integrations.Constants
end
local FoundationProvider = Foundation.FoundationProvider
local Migration = BuilderIcons.Migration

local function createGameSettings()
    local var1 = SettingsPageFactory:CreateNewPage()

    var1.TabHeader.Name = Constants.GAMESETTINGS.TAB_HEADER.NAME
    local iconsCommonSettings = Migration.uiblox["icons/common/settings"]
    var1.TabHeader.TabLabel.Icon.Text = iconsCommonSettings.name
    var1.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[iconsCommonSettings.variant]
    var1.TabHeader.TabLabel.Title.Text = Constants.GAMESETTINGS.TAB_HEADER.TEXT

    var1.Page:ClearAllChildren()

    var1.PageOpen = false
    function var1.OpenSettingsPage()
        var1.PageOpen = true
    end
    function var1.CloseSettingsPage()
        var1.PageOpen = false
    end

    local element = React.createElement(
        FoundationProvider,
        {
            colorMode = Foundation.Enums.ColorMode.Dark,
            device = Utils.getDeviceType()
        },
        {}
    )

    ReactRoblox.createRoot(var1.Page):render(element)

    return var1
end

if FFlagRefactorInExpSettingsInDevelopment then
    return (createGameSettings())
end
return require(Modules.Settings.Pages.GameSettings)
