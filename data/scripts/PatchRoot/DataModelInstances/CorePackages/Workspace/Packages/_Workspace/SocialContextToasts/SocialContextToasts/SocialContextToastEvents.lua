-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialContextToastsParent = script:FindFirstAncestor("SocialContextToasts").Parent

local t = require(SocialContextToastsParent.t)
local mutedError = require(SocialContextToastsParent.Loggers).mutedError

local var1 = t.strictInterface(
    {
        toastType = t.string,
        friendId = t.string,
        universeId = t.string,
        placeId = t.string,
        actionType = t.string
    }
)
return function(arg1, arg2)
    local var2, var3 = var1(arg2)
    if not var2 then
        mutedError(var3)
    end

    arg1:sendEventDeferred("SocialContextToast", "socialContextToastEvent", arg2)
end
