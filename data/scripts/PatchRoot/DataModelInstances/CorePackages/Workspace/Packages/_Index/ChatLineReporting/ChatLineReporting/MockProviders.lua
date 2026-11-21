-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReportingParent = script:FindFirstAncestor("ChatLineReporting").Parent
local React = require(ChatLineReportingParent.React)
local ProviderContainer = require(ChatLineReportingParent.RoactUtils).Components.ProviderContainer
local StyleProviderWithDefaultTheme = require(ChatLineReportingParent.Style).StyleProviderWithDefaultTheme
local LocalizationProvider = require(ChatLineReportingParent.Localization).LocalizationProvider
local LayerCollectorProvider = require(ChatLineReportingParent.UIBlox).Core.Layout.LayerCollector.LayerCollectorProvider

local function MockProviders(tbl1)
    local providers = {}

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

    return React.createElement(ProviderContainer, { providers = providers }, tbl1.children)
end

return MockProviders
