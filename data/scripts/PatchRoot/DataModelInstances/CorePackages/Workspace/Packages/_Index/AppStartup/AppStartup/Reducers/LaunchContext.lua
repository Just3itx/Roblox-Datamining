-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStartup = script:FindFirstAncestor("AppStartup")
local AppStartupParent = AppStartup.Parent
local SetLaunchContext = require(AppStartup.Actions.SetLaunchContext)
local Rodux = require(AppStartupParent.Rodux)
local _Enums = require(AppStartup.Enums)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetLaunchContext.name] = function(_, tbl2)
    return tbl2.launchContext
end

return createReducer(nil, tbl1)
