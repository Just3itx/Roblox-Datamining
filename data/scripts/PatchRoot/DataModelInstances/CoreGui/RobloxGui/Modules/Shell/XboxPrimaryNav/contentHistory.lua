-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Shell = game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("Modules"):FindFirstChild("Shell")
local GetFFlagXboxFixPrimaryNavABEvents = require(Shell.Flags.GetFFlagXboxFixPrimaryNavABEvents)

local function contentHistory()
    local module = {}

    local var1 = nil

    function module.setLastSelectedContent(_, arg1)
        var1 = arg1
    end

    function module.getLastContentName(_)
        local success, result = pcall(function()
            if GetFFlagXboxFixPrimaryNavABEvents() then
                return var1:GetId()
            end
            return var1:GetName()
        end)

        if success then
            return result
        end
    end

    return module
end

return (contentHistory())
