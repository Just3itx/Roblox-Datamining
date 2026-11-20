-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local Wrappers = require(Foundation.Utility.Wrappers)
local CoreGui = Wrappers.Services.CoreGui
local RunService = Wrappers.Services.RunService
local Players = Wrappers.Services.Players

local isPluginSecurity = require(Foundation.Utility.isPluginSecurity)

local var1 = nil

local function getPlayerGui() -- Luacid: Inlined by compiler; 1 call site recovered
    if not (RunService:IsClient() and Players.LocalPlayer and RunService:IsRunning()) then
        return nil
    end

    return Players.LocalPlayer:WaitForChild("PlayerGui", 3)
end

local function getMainGui()
    if isPluginSecurity() then
        return CoreGui
    end

    if var1 == nil then
        var1 = getPlayerGui()
    end

    return var1
end

return getMainGui
