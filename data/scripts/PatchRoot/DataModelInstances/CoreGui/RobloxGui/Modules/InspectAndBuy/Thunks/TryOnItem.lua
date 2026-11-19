-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Analytics = require(scriptParentParent.Services.Analytics)
local SetTryingOnInfo = require(scriptParentParent.Actions.SetTryingOnInfo)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Analytics }

local function TryOnItem(arg1, arg2, arg3, arg4, arg5)
    return Thunk.new(script.Name, tbl1, function(arg6, arg7)
        local var1 = arg7[Analytics]
        local var2, str1

        if arg4 then
            var2 = arg5
            str1 = "Bundle"
        else
            var2 = arg2
            str1 = "Asset"
        end

        var1.reportTryOnButtonClicked(str1, var2)
        arg6:dispatch(SetTryingOnInfo(arg1, arg2, arg3))
        arg6:dispatch(SendCounter(Constants.Counters.TryOnButtonClicked))
    end)
end

return TryOnItem
