-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStartup = script:FindFirstAncestor("AppStartup")
local AppStartupParent = AppStartup.Parent
local makeActionCreator = require(AppStartupParent.Rodux).makeActionCreator
local _Enums = require(AppStartup.Enums)

return makeActionCreator(script.Name, function(launchContext)
    return { launchContext = launchContext }
end)
