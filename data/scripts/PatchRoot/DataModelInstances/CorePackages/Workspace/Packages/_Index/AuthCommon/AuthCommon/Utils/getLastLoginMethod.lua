-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)

local function getLastLoginMethod(userIdentifier: string)
    for _, value in (AppStorageUtilities.getPreviousAccountsList()) do
        if value.userIdentifier == userIdentifier then
            return value.loginMethod
        end
    end
    return nil
end

return getLastLoginMethod
