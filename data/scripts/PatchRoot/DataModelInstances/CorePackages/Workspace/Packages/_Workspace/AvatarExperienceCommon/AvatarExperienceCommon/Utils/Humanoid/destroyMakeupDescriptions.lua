-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function destroyMakeupDescriptions(arg1)
    for _, child in arg1:GetChildren() do
        if child:IsA("MakeupDescription") then
            child:Destroy()
        end
    end
end

return destroyMakeupDescriptions
