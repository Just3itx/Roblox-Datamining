-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetTryingOnInfo = require(scriptParentParent.Actions.SetTryingOnInfo)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetTryingOnInfo.name] = function(_, arg1)
    return {
        tryingOn = arg1.tryingOn,
        assetId = arg1.assetId,
        assetTypeId = arg1.assetTypeId
    }
end

return createReducer({ tryingOn = false, assetId = nil, assetTypeId = nil }, tbl1)
