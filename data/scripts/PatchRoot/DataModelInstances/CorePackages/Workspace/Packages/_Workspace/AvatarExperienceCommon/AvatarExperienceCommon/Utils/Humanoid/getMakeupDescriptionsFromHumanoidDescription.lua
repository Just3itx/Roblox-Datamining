-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getMakeupDescriptionsFromHumanoidDescription(arg1)
    local makeupDescriptionsFromHumanoidDescription = {}
    for _, child in arg1:GetChildren() do
        if child:IsA("MakeupDescription") then
            table.insert(makeupDescriptionsFromHumanoidDescription, child)
        end
    end
    return makeupDescriptionsFromHumanoidDescription
end

return getMakeupDescriptionsFromHumanoidDescription
