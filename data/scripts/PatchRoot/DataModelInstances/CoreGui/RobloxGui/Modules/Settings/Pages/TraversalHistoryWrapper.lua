-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local Settings = script:FindFirstAncestor("Settings")

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)

local Foundation = require(CorePackages.Packages.Foundation)
local FoundationProvider = Foundation.FoundationProvider

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider

local Constants = require(Settings.Integrations.Constants)
local TraversalHistoryPage = require(Settings.Components.Traversal.TraversalHistoryPage)
local SettingsPageFactory = require(Settings.SettingsPageFactory)
local Utils = require(Settings.Integrations.Utils)

local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)

local function createTraversalHistoryWrapper()
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    local var1 = SettingsPageFactory:CreateNewPage()

    var1.Page:ClearAllChildren()
    var1.Page.Name = "TraversalHistoryPage"
    var1.TabHeader.Name = Constants.TRAVERSAL_HISTORY.TAB_HEADER.NAME
    var1.TabHeader.TabLabel.Title.AutoLocalize = false
    var1.TabHeader.TabLabel.Title.Text = localization:Format(Constants.TRAVERSAL_HISTORY.TAB_HEADER.TEXT_KEY)

    var1.PageListLayout.Parent = nil
    var1.ShouldShowBottomBar = not isSideSheetEnabled
    var1.ShouldShowHubBar = true

    var1.Page.Size = UDim2.fromScale(1, 0)

    ReactRoblox.createRoot(var1.Page):render(
        React.createElement(
            FoundationProvider,
            {
                colorMode = Foundation.Enums.ColorMode.Dark,
                device = Utils.getDeviceType()
            },
            {
                Localization = React.createElement(
                    LocalizationProvider,
                    { localization = localization },
                    {
                        Page = React.createElement(TraversalHistoryPage)
                    }
                )
            }
        )
    )
    return var1
end

return createTraversalHistoryWrapper
