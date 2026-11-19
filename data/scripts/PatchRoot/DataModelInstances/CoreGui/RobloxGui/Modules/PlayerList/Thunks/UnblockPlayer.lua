-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)

local scriptParentParent = script.Parent.Parent

local SetPlayerIsBlocked = require(scriptParentParent.Actions.SetPlayerIsBlocked)

local function UnblockPlayer(arg1)
    return function(arg2)
        coroutine.wrap(function()
            if BlockingUtility:UnblockPlayerAsync(arg1) then
                arg2:dispatch(SetPlayerIsBlocked(arg1, false))
            end
        end)()
    end
end

return UnblockPlayer
