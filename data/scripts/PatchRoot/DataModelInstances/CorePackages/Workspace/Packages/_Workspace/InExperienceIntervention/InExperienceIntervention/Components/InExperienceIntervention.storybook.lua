-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceInterventionParent = script:FindFirstAncestor("InExperienceIntervention").Parent
local UIBlox = require(InExperienceInterventionParent.UIBlox)
local RobloxAppUIBloxConfig = require(InExperienceInterventionParent.Dev.RobloxAppUIBloxConfig)

UIBlox.init(RobloxAppUIBloxConfig)

local React = require(InExperienceInterventionParent.React)
local Roact = require(InExperienceInterventionParent.Roact)
local Cryo = require(InExperienceInterventionParent.Cryo)

local ProviderContainer = require(InExperienceInterventionParent.RoactUtils).Components.ProviderContainer
local StyleProviderWithDefaultTheme = require(InExperienceInterventionParent.Style).StyleProviderWithDefaultTheme
local LocalizationProvider = require(InExperienceInterventionParent.Localization).LocalizationProvider
local FoundationProvider = require(InExperienceInterventionParent.Foundation).FoundationProvider
local LayerCollectorProvider = UIBlox.Core.Layout.LayerCollector.LayerCollectorProvider
local Signal = require(InExperienceInterventionParent.AppCommonLib).Signal

local function MockProviders(arg1)
    local providers = {}

    table.insert(providers, { class = FoundationProvider, props = {} })

    table.insert(
        providers,
        {
            class = StyleProviderWithDefaultTheme,
            props = { withDarkTheme = true, withUiModeSupport = false }
        }
    )

    table.insert(providers, {
        class = LocalizationProvider,
        props = {
            localization = {
                Format = function(_, str1: string): string
                    return str1
                end,
                changed = Signal.new()
            }
        }
    })

    table.insert(providers, { class = LayerCollectorProvider, props = {} })

    return React.createElement(ProviderContainer, { providers = providers }, arg1.children)
end

return {
    roact = Roact,
    mapStory = function(arg1)
        return function(arg2)
            local var1 = not (arg2 and arg2.definition) and {} or arg2.definition.props or {}

            return Roact.createElement(MockProviders, {}, { story = Roact.createElement(arg1, Cryo.Dictionary.union(var1, arg2)) })
        end
    end
}
