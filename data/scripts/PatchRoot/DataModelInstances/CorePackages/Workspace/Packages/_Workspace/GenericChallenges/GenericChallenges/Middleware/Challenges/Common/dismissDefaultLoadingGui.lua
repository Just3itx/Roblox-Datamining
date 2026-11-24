-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function defaultHasJoinConnected(): boolean
    return game:FindService("NetworkClient") ~= nil
end

return function(tbl1, func1: ((...any) -> (...any))?)
    if (func1 or defaultHasJoinConnected)() then
        return
    end

    local ReplicatedFirst = game:GetService("ReplicatedFirst")
    local var1 = tbl1 or ReplicatedFirst
    if var1:IsDefaultLoadingGuiRemoved() then
        return
    end
    var1:SetDefaultLoadingGuiRemoved()
end
