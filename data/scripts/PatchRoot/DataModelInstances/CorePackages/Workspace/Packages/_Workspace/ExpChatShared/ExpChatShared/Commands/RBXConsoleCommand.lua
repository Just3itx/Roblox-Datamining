-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")

local _types = require(script.Parent.types)
return {
    name = script.Name,
    alias = { "/console" },
    clientRun = function()
        local success, result = pcall(function()
            return StarterGui:GetCore("DevConsoleVisible")
        end)
        if success then
            pcall(function()
                StarterGui:SetCore("DevConsoleVisible", not result)
            end)
        end

        return nil
    end
}
