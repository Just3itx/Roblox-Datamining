-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local common = require(script.common)
local displayOptions = require(script.displayOptions)
local feedbackFlowState = require(script.feedbackFlowState)

local FetchingStatus = require(CorePackages.Workspace.Packages.Http).Reducers.FetchingStatus

return (Rodux.combineReducers({
    common = common,
    displayOptions = displayOptions,
    feedbackFlowState = feedbackFlowState,
    FetchingStatus = FetchingStatus
}))
