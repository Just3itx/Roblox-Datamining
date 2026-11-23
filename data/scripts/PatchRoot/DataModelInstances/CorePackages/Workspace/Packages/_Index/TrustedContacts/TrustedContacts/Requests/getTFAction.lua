-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local HttpService = game:GetService("HttpService")
local Http = require(TrustedContactsParent.Http)
local myHttpRequest = require(TrustedContacts.Networking.myHttpRequest)
local _TFActionsEnum = require(TrustedContacts.TrustedFriendActions.TFActionsEnum)
local FFlagTFPassQRCodeSource = require(TrustedContacts.Flags.FFlagTFPassQRCodeSource)

return function(profileId, tbl1)
    local str1 = string.format("%s/profile-platform-api/v1/profiles/get", Http.Url.APIS_URL)
    local var1 = nil
    local var2 = nil

    if FFlagTFPassQRCodeSource then
        local input = {
            friendRequestToken = if tbl1 then tbl1.friendRequestToken or nil else nil,
            isQrCodeFlow = if tbl1 and tbl1.sentFromQrCode then true else nil
        }
        if next(input) then
            var1 = HttpService:JSONEncode(input)
        end
    elseif tbl1 and tbl1.friendRequestToken and type(tbl1.friendRequestToken) == "table" then
        var2 = table.concat(tbl1.friendRequestToken, ",")
    else
        var2 = nil
    end

    local tbl2 = { postBody = 0 }
    local postBody = { profileType = "User", profileId = profileId, components = 0 }

    local tbl4 = { component = "TrustedFriendActions", context = 0 }

    if FFlagTFPassQRCodeSource then
        var2 = var1
    end

    tbl4.context = var2
    postBody.components = { tbl4 }
    tbl2.postBody = postBody

    return myHttpRequest(str1, "POST", tbl2):andThen(function(arg1)
        return arg1
            and arg1.responseBody
            and arg1.responseBody.components
            and arg1.responseBody.components.TrustedFriendActions
            and arg1.responseBody.components.TrustedFriendActions.action
            or nil
    end)
end
