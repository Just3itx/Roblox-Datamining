-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local Actions = script.Parent.Parent.Actions
local SetScreenSize = require(Actions.SetScreenSize)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[SetScreenSize.name] = function(_, arg1)
    return {
        X = arg1.sizeX,
        Y = arg1.sizeY
    }
end

return (createReducer({ X = 1000, Y = 1000 }, tbl1))
