-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local function connectImageLoaded(arg1, callback: (...any) -> (...any), arg2)
    local var1 = arg2 or RunService.Heartbeat
    local connection = nil
    connection = var1:Connect(function()
        if not arg1.Parent then
            connection:Disconnect()
        elseif arg1.IsLoaded then
            connection:Disconnect()
            callback()
        end
    end)
    return connection
end

return connectImageLoaded
