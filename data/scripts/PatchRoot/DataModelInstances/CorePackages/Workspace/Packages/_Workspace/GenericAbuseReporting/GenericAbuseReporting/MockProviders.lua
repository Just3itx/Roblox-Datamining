-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local AppFeaturePolicies = require(GenericAbuseReportingParent.UniversalAppPolicy).AppFeaturePolicies
local React = require(GenericAbuseReportingParent.React)
local ProviderContainer = require(GenericAbuseReportingParent.RoactUtils).Components.ProviderContainer
local StyleProviderWithDefaultTheme = require(GenericAbuseReportingParent.Style).StyleProviderWithDefaultTheme
local LocalizationProvider = require(GenericAbuseReportingParent.Localization).LocalizationProvider
local RoactAppPolicy = require(GenericAbuseReportingParent.UniversalAppPolicy).RoactAppPolicy
local RoactNavigation = require(GenericAbuseReportingParent.RoactNavigation)
local RoactRodux = require(GenericAbuseReportingParent.RoactRodux)
local Rodux = require(GenericAbuseReportingParent.Rodux)
local LayerCollectorProvider = require(GenericAbuseReportingParent.UIBlox).Core.Layout.LayerCollector.LayerCollectorProvider

local value = {
    state = {
        params = {},
        routeName = "",
        key = ""
    },
    dispatch = function() end,
    goBack = function() end,
    addListener = function()
        return {
            remove = function() end
        }
    end,
    isFocused = function() end,
    setParams = function() end,
    getParam = function() end,
    replace = function() end,
    push = function() end
}

local function reducer<T>(arg1: T): T
    return arg1
end

local function MockProviders(tbl2)
    local providers = {}

    local store = Rodux.Store.new(reducer, {}, { Rodux.thunkMiddleware })

    table.insert(providers, { class = StyleProviderWithDefaultTheme, props = { withDarkTheme = true } })

    table.insert(providers, {
        class = LocalizationProvider,
        props = {
            localization = {
                Format = function(_, str1: string): string
                    return str1
                end
            }
        }
    })

    table.insert(providers, { class = LayerCollectorProvider, props = {} })

    table.insert(providers, { class = RoactNavigation.Provider, props = { value = value } })

    table.insert(providers, { class = RoactRodux.StoreProvider, props = { store = store } })

    table.insert(providers, { class = RoactAppPolicy.Provider, props = { policy = { AppFeaturePolicies } } })

    return React.createElement(ProviderContainer, { providers = providers }, tbl2.children)
end

return MockProviders
