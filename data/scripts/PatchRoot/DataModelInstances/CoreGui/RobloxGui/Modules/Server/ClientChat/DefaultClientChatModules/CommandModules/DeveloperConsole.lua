-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")
local Util = require(script.Parent:WaitForChild("Util"))

function ProcessMessage(arg1, _, _): boolean
    if string.sub(arg1, 1, 8):lower() ~= "/console" and string.sub(arg1, 1, 11):lower() ~= "/newconsole" then
        return false
    end

    local success, result = pcall(function()
        return StarterGui:GetCore("DevConsoleVisible")
    end)

    if success then
        local success2, result2 = pcall(function()
            StarterGui:SetCore("DevConsoleVisible", not result)
        end)

        if not success2 and result2 then
            print("Error making developer console visible: " .. result2)
        end
    end
    return true
end

return {
    [Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR,
    [Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage
}
