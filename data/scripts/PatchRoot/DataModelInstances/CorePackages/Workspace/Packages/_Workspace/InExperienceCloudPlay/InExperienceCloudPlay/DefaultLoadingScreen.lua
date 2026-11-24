-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReplicatedFirst = game:GetService("ReplicatedFirst")

return {
    isRemoved = function(): boolean
        return ReplicatedFirst:IsDefaultLoadingGuiRemoved()
    end,
    subscribeRemoved = function(func1: (...any) -> (...any))
        local connection = ReplicatedFirst.DefaultLoadingGuiRemoved:Connect(func1)
        return function()
            connection:Disconnect()
        end
    end
}
