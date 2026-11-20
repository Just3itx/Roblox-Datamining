-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Constants = require(script.Constants)
local CreationFlowContext = require(script.Context.CreationFlowContext)
local CreationFlowContextProvider = require(script.Context.CreationFlowContextProvider)
local CreationFlowScreen = require(script.Components.CreationFlowScreen)
local EventNames = require(script.Analytics.EventNames)
local installReducer = require(script.Reducers.installReducer)

local CreationFlowStateUpdated = require(script.Actions.CreationFlowStateUpdated)
local SelectedCaptureUpdated = require(script.Actions.SelectedCaptureUpdated)

local CreationFlowLocalization = require(script.Enums.CreationFlowLocalization)

local CreationFlowState = require(script.Enums.CreationFlowState)

local scriptParent = script.Parent
local _MomentsCommon = require(scriptParent.MomentsCommon)

return {
    EventNames = EventNames,
    Actions = {
        CreationFlowStateUpdated = CreationFlowStateUpdated,
        SelectedCaptureUpdated = SelectedCaptureUpdated
    },
    Constants = {
        RoduxKey = Constants.RoduxKey
    },
    installReducer = installReducer,
    CreationFlowContext = CreationFlowContext,
    CreationFlowContextProvider = CreationFlowContextProvider,
    CreationFlowScreen = CreationFlowScreen,
    Enums = { CreationFlowState = CreationFlowState },
    CreationFlowLocalization = CreationFlowLocalization,
    ["jest.config"] = script["jest.config"]
}
