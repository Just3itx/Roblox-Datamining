-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local Url = require(TrustedContactsParent.Http).Url

local myHttpRequest = require(TrustedContacts.Networking.myHttpRequest)

return function(arg1)
    local str1 = string.format("%s/users/%s/send-trusted-friend-request", Url.FRIEND_URL, tostring(arg1))

    return myHttpRequest(str1, "POST", { postBody = {} })
end
