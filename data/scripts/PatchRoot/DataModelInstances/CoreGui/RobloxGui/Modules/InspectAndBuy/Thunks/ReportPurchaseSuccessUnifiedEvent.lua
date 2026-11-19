-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Analytics = require(scriptParentParent.Services.Analytics)
local GetPurchaseAnalyticsOptions = require(scriptParentParent.Selectors.GetPurchaseAnalyticsOptions)

local tbl1 = { Analytics }

local function ReportPurchaseSuccessUnifiedEvent(arg1, arg2, num1: number?)
    return Thunk.new(script.Name, tbl1, function(arg3, arg4)
        arg4[Analytics].reportPurchaseSuccessUnifiedEvent(
            arg2,
            arg1,
            GetPurchaseAnalyticsOptions(arg3:getState(), arg1, arg2, num1)
        )
    end)
end

return ReportPurchaseSuccessUnifiedEvent
