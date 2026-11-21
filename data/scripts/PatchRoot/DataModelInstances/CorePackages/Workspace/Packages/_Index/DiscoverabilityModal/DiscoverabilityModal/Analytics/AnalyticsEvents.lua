-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local EventNames = require(script.Parent.Enums.EventNames)

local SocialLuaAnalytics = dependencies.SocialLuaAnalytics
local Dash = dependencies.Dash

local Enums = SocialLuaAnalytics.Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes
local BtnValues = require(script.Parent.Enums.BtnValues)

return {
    [EventNames.DiscoverabilityModalLoad] = {
        context = Contexts.ContactImport,
        eventType = EventTypes.DiscoverabilityModalLoad,
        formatRulesForAdditionalInfo = {
            version = Dash.identity,
            wordingVersion = Dash.identity
        }
    },
    [EventNames.DiscoverabilityModalContinue] = {
        context = Contexts.ContactImport,
        eventType = EventTypes.DiscoverabilityModalClick,
        additionalInfo = {
            btn = BtnValues.ContactImporter
        },
        formatRulesForAdditionalInfo = {
            selected = Dash.identity
        }
    },
    [EventNames.DiscoverabilityModalClose] = {
        context = Contexts.ContactImport,
        eventType = EventTypes.DiscoverabilityModalClick,
        additionalInfo = {
            btn = BtnValues.Close
        },
        formatRulesForAdditionalInfo = {
            selected = Dash.identity
        }
    },
    [EventNames.DiscoverabilityModalRadioButtonClick] = {
        context = Contexts.ContactImport,
        eventType = EventTypes.DiscoverabilityModalRadioButtonClick,
        formatRulesForAdditionalInfo = {
            selected = Dash.identity
        }
    }
}
