-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function dispatchEnhancedVideoConfig(arg1)
    task.spawn(function()
        local enhancedVideoConfig = ReplicatedStorage:WaitForChild("EnhancedVideoConfig", 60)
        if not (enhancedVideoConfig and enhancedVideoConfig:IsA("BindableEvent")) then
            return
        end
        enhancedVideoConfig:Fire(arg1)
    end)
end

return dispatchEnhancedVideoConfig
