-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local ServerUtil = require(RobloxGui.Modules.Server.ServerUtil)

return function()
    if game:GetService("StarterPlayer"):FindFirstChild("PlayerSettings") ~= nil then
        return
    end

    local playerSettings = Instance.new("ModuleScript")
    playerSettings.Name = "PlayerSettings"
    if ServerUtil.getFFlagServerCoreScriptSourceCode() then
        playerSettings.Source = ServerUtil.getSourceForServerScript(script.Parent.DefaultServerPlayerModules:WaitForChild("PlayerSettings"))
    else
        playerSettings.Source = script.Parent.DefaultServerPlayerModules:WaitForChild("PlayerSettings").Source
    end
    playerSettings.Parent = game:GetService("StarterPlayer")
    playerSettings.Archivable = false
end
