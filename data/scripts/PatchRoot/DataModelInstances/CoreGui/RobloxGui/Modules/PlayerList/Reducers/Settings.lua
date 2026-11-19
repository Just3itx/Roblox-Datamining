-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local Actions = script.Parent.Parent.Actions
local SetSettings = require(Actions.SetSettings)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[SetSettings.name] = function(_, arg1)
    return {
        preferredTransparency = arg1.preferredTransparency,
        reducedMotion = arg1.reducedMotion
    }
end

return (createReducer({ preferredTransparency = 1, reducedMotion = false }, tbl1))
