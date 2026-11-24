-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getSettingsForMessage(arg1, arg2)
    local userSpecificSettings = arg1 and arg1.UserSpecificSettings

    if not (arg2 and userSpecificSettings) then
        return arg1
    end

    if userSpecificSettings[arg2.userId] then
        return userSpecificSettings[arg2.userId]
    end

    if arg2.partOrModel and userSpecificSettings[arg2.partOrModel:GetFullName()] then
        return userSpecificSettings[arg2.partOrModel:GetFullName()]
    end

    return arg1
end

return getSettingsForMessage
