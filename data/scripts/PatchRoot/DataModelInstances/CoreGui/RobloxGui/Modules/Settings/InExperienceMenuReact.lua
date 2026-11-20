-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local EventIngestService = game:GetService("EventIngestService")

local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local Analytics = require(CorePackages.Workspace.Packages.Analytics).Analytics
local EventIngest = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventIngest
local InExperienceLocales = require(CorePackages.Workspace.Packages.InExperienceLocales)
local Localization = require(CorePackages.Workspace.Packages.Localization)
local ServiceProvider = require(CorePackages.Workspace.Packages.RoactServices).RoactServices.ServiceProvider
local RoactServiceTags = require(CorePackages.Workspace.Packages.RoactServiceTags)

local scriptParent = script.Parent
local Utils = require(scriptParent.Integrations.Utils)

local AppEventIngestService = RoactServiceTags.AppEventIngestService
local RoactAnalytics = RoactServiceTags.RoactAnalytics
local LocalizationProvider = Localization.LocalizationProvider
local GetLocalizationServiceStore = Localization.GetLocalizationServiceStore
local Localization2 = InExperienceLocales.Localization

local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    colorMode = Foundation.Enums.ColorMode.Dark
}

return React.memo(function(tbl2) -- name: InExperienceMenuReact
    local localizationServiceStore = GetLocalizationServiceStore(false)
    local var1 = SignalsReact.useSignalState(localizationServiceStore.getRobloxLocaleId)
    local localization2 = Localization2.new(var1)

    return React.createElement(
        ServiceProvider,
        {
            services = {
                [AppEventIngestService] = EventIngest.new(EventIngestService),
                [RoactAnalytics] = Analytics.new()
            }
        },
        {
            LocalizationProvider = React.createElement(LocalizationProvider, {
                localization = localization2
            }, {
                FoundationProvider = React.createElement(
                    FoundationProvider,
                    {
                        colorMode = tbl2.theme or tbl1.colorMode,
                        device = Utils.getDeviceType()
                    },
                    tbl2.children
                )
            })
        }
    )
end)
