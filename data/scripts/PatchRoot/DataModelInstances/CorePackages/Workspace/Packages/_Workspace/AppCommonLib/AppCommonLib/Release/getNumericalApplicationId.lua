-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
game:DefineFastFlag("EnableContactInvitesForNonPhoneVerifiedForAll", false)
game:DefineFastInt("EnableContactInvitesForNonPhoneVerifiedRollout", 0)

return function(tbl1)
    local item = (tbl1 or AppStorageService):GetItem("AppInstallationId")

    local str1 = typeof(item)

    if str1 == "number" then
        return item
    end

    if str1 ~= "string" then
        return nil
    end

    if string.len(item) <= 0 then
        return nil
    end

    return tonumber(string.sub(item, -2))
end
