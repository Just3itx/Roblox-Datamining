-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")

local scriptParentParent = script.Parent.Parent

local SetRespawnBehavior = require(scriptParentParent.Actions.SetRespawnBehavior)

local function registerSetCores(arg1)
    StarterGui:RegisterSetCore("ResetButtonCallback", function(arg2)
        local bool1 = true
        local var1 = nil

        if typeof(arg2) == "boolean" then
            bool1 = arg2
            var1 = nil
        elseif typeof(arg2) == "Instance" and arg2:IsA("BindableEvent") then
            var1 = arg2
            bool1 = true
        else
            error("ResetButtonCallback must be set to a BindableEvent or a boolean", 0)
        end

        arg1:dispatch(SetRespawnBehavior(bool1, var1))
    end)
end

return registerSetCores
