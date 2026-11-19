-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local var1 = nil
local function getClientReplicator()
    if var1 == nil then
        local var2 = game:FindService("NetworkClient")
        if var2 then
            var1 = var2:FindFirstChildOfClass("ClientReplicator")
        end
    end

    return if var1 and var1:IsDescendantOf(game) then var1 else nil
end

return getClientReplicator
