-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getLinkedPlatformAccountName(arg1)
    local platformAccountName = arg1.getPlatformAccountName()
    return if platformAccountName and arg1.getUseSingleSignOn() then platformAccountName else nil
end

return getLinkedPlatformAccountName
