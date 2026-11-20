-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStartup = script:FindFirstAncestor("AppStartup")
local AppStartupParent = AppStartup.Parent
local RoactUtils = require(AppStartupParent.RoactUtils)
local _Enums = require(AppStartup.Enums)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

return function()
    return useSelector(function(arg1)
        return arg1.LaunchContext
    end)
end
