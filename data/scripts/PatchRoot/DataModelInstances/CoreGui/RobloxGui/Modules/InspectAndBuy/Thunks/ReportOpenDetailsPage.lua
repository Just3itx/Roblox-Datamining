-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Analytics = require(scriptParentParent.Services.Analytics)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Analytics }

local function ReportOpenDetailsPage(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Analytics]
        local var2, str1

        if arg1 and arg1.parentBundleId ~= nil then
            var2 = UtilityFunctions.getBundleId(arg1)
            str1 = "Bundle"
        else
            var2 = arg1.assetId
            str1 = "Asset"
        end

        var1.reportItemDetailPageOpened(str1, var2)
        arg2:dispatch(SendCounter(Constants.Counters.ItemDetailPageOpened))
    end)
end

return ReportOpenDetailsPage
