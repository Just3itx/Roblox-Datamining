-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local _Types = require(script.Parent.Parent.Types)
local finishModelSetup = require(script.Parent.finishModelSetup)

local function createUserIdModelSource(arg1)
    return function(arg2)
        local var1 = tonumber(arg1)
        if not var1 then
            return nil
        end

        local success, result = pcall(function(): Model
            return Players:CreateHumanoidModelFromUserIdAsync(var1)
        end)

        if arg2.isCancelled() then
            if success and result then
                result:Destroy()
            end
            return nil
        elseif not (success and result) then
            return nil
        else
            return finishModelSetup(result)
        end
    end
end
return createUserIdModelSource
