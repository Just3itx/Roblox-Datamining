-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)

local scriptParentParent = script.Parent.Parent
local ShowToast = require(scriptParentParent.Actions.ShowToast)

local function BlockPlayer(arg1, arg2, arg3)
    return function(arg4)
        coroutine.wrap(function()
            if BlockingUtility:BlockPlayerAsync(arg1) then
                arg4:dispatch(ShowToast(arg2, arg3))
            end
        end)()
    end
end

return BlockPlayer
