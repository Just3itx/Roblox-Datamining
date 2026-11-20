-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local Dash = require(MomentsCreationFlowParent.Dash)
return require(MomentsCreationFlowParent.React).createContext({
    captures = {},
    capturesPagesIsFinished = Dash.noop,
    createMoment = Dash.noop,
    exitCreationFlow = Dash.noop,
    fetchAdditionalCaptures = Dash.noop,
    fetchInitialCaptures = Dash.noop,
    fireEvent = Dash.noop,
    getLocalization = Dash.noop,
    getUserConfiguration = Dash.noop,
    isTextFiltered = Dash.noop,
    setScreenOrientation = Dash.noop
})
