-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Enums = require(script.Enums)

return {
    ["jest.config"] = script["jest.config"],
    Components = require(script.Components),
    Common = require(script.Common),
    Actions = require(script.Actions),
    Enums = Enums,
    Http = require(script.Http),
    Models = require(script.Models),
    Thunks = require(script.Thunks),
    Utils = require(script.Utils),
    Reducers = require(script.Reducers),
    Analytics = require(script.Analytics),
    installReducer = require(script.Reducers.installReducer),
    RoduxKey = require(script.Common.Constants).RODUX_KEY,
    Hooks = require(script.Hooks),
    EventReceivers = require(script.EventReceivers),
    Experiments = require(script.Experiments),
    Stores = require(script.Stores),
    DesignTokenMappers = require(script.DesignTokenMappers),
    Flags = {
        FFlagEnableCrossDeviceApproverDialog = require(script.Flags.FFlagEnableCrossDeviceApproverDialog)
    }
}
