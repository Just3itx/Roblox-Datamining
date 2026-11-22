-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Dash = require(scriptParentParent.dependencies).Dash
local Enums = require(scriptParentParentParent.SocialLuaAnalytics).Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes

local EventNames = require(script.Parent.Enums.EventNames)
local BtnValues = require(script.Parent.Enums.BtnValues)

return {
    [EventNames.CustomizeNameModalOpened] = {
        context = Contexts.CustomizeName,
        eventType = EventTypes.PageLoad,
        formatRulesForAdditionalInfo = {
            origin = Dash.identity
        }
    },
    [EventNames.CustomizeNameClearedInput] = {
        context = Contexts.CustomizeName,
        eventType = EventTypes.CustomizeNameClearedInput,
        formatRulesForAdditionalInfo = {
            origin = Dash.identity
        }
    },
    [EventNames.CustomizeNameMaximumCharLimitTyped] = {
        context = Contexts.CustomizeName,
        eventType = EventTypes.CustomizeNameMaximumCharLimitTyped,
        formatRulesForAdditionalInfo = {
            alias = Dash.identity,
            origin = Dash.identity
        }
    },
    [EventNames.CustomizeNameModalClosed] = {
        context = Contexts.CustomizeName,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.CloseCustomizeName
        },
        formatRulesForAdditionalInfo = {
            origin = Dash.identity
        }
    },
    [EventNames.CustomizeNameSaved] = {
        context = Contexts.CustomizeName,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.SaveAlias
        },
        formatRulesForAdditionalInfo = {
            alias = Dash.identity,
            origin = Dash.identity
        }
    },
    [EventNames.CustomizeNameSaveAttemptInvalidInput] = {
        context = Contexts.CustomizeName,
        eventType = EventTypes.CustomizeNameSaveAttemptInvalidInput,
        formatRulesForAdditionalInfo = {
            alias = Dash.identity,
            origin = Dash.identity
        }
    }
}
