-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local LocalizationService = game:GetService("LocalizationService")
local Modules = RobloxGui.Modules

local HelpPage = require(CorePackages.Workspace.Packages.HelpPage)
local HelpReactView = HelpPage.HelpReactView
local SettingsPageFactory = require(Modules.Settings.SettingsPageFactory)
local localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization.new(LocalizationService.RobloxLocaleId)
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local Foundation = require(CorePackages.Packages.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local uiblox = BuilderIcons.Migration.uiblox
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local FFlagRefactorHelpPage = HelpPage.Flags.FFlagRefactorHelpPage
local FFlagRenameHelpToControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagRenameHelpToControls

local Constants = nil
local Utils = nil
if FFlagRefactorHelpPage then
    Utils = require(Modules.Settings.Integrations).Utils
    Constants = HelpPage.Constants
end

local root = nil
local var2, var3 = Signals.createSignal(false)

local function func1()
    if not SignalsReact.useSignalState(var2) then
        return nil
    end

    return (React.createElement(
        FoundationProvider,
        {
            colorMode = Foundation.Enums.ColorMode.Dark,
            device = Utils.getDeviceType()
        },
        {
            Child = React.createElement(
                LocalizationProvider,
                { localization = localization },
                {
                    Root = React.createElement(HelpReactView)
                }
            )
        }
    ))
end

local function createReactTree(page) -- Luacid: Inlined by compiler; 1 call site recovered
    if root then
        return
    end

    root = ReactRoblox.createRoot(page)
    if root then
        root:render(React.createElement(func1))
    end
end

local function createHelpPage()
    local var4 = SettingsPageFactory:CreateNewPage()

    var4.TabHeader.Name = Constants.HELP_PAGE.TAB_HEADER.NAME
    var4.Page.Name = "Help"
    if FFlagRenameHelpToControls then
        var4.TabHeader.TabLabel.Icon.Text = IconName.Controller
        var4.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[IconVariant.Regular]
    else
        local var5 = uiblox[Constants.HELP_PAGE.TAB_HEADER.ICON]
        var4.TabHeader.TabLabel.Icon.Text = var5.name
        var4.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[var5.variant]
    end
    var4.TabHeader.TabLabel.Title.Text = localization:Format(Constants.HELP_PAGE.TAB_HEADER.TEXT)

    var4.Page:ClearAllChildren()

    var4.Displayed.Event:Connect(function()
        createReactTree(var4.Page)
        var3(true)

        if var4.HubRef.VersionContainer then
            var4.HubRef.VersionContainer.Visible = true
        end
    end)

    var4.Hidden.Event:Connect(function()
        var3(false)

        if var4.HubRef.VersionContainer then
            var4.HubRef.VersionContainer.Visible = false
        end
    end)

    var4.Page.Size = UDim2.fromScale(1, 0)
    var4.Page.AutomaticSize = Enum.AutomaticSize.Y

    return var4
end

if FFlagRefactorHelpPage then
    return (createHelpPage())
end
return require(Modules.Settings.Pages.Help)
