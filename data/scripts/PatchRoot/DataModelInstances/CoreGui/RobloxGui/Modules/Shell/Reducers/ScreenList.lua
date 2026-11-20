-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Actions = game:GetService("CoreGui").RobloxGui.Modules.Shell.Actions

local InsertScreen = require(Actions.InsertScreen)
local RemoveScreen = require(Actions.RemoveScreen)

local CorePackages = game:GetService("CorePackages")
local Immutable = require(CorePackages.Workspace.Packages.AppCommonLib).Immutable

return function(tbl1, arg1)
    tbl1 = tbl1 or {}
    assert(tbl1, "")

    if arg1.type == InsertScreen.name then
        local var1 = Immutable.Append(tbl1, arg1.item)

        table.sort(var1, function(arg2, arg3): boolean
            if arg2.priority == arg3.priority then
                return arg2.createdAt > arg3.createdAt
            end

            return arg2.priority > arg3.priority
        end)

        return var1
    elseif arg1.type == RemoveScreen.name then
        return Immutable.RemoveValueFromList(tbl1, arg1.item)
    else
        return tbl1
    end
end
