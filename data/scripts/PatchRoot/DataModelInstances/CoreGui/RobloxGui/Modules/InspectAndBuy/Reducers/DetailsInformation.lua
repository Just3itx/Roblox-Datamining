-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetDetailsInformation = require(scriptParentParent.Actions.SetDetailsInformation)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetDetailsInformation.name] = function(_, arg1)
    return {
        viewingDetails = arg1.viewingDetails,
        assetId = arg1.assetId
    }
end

return createReducer({ viewingDetails = false, assetId = nil }, tbl1)
