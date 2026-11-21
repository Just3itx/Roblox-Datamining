-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local dependencies = require(ContactImporter.dependencies)
local useDispatch = dependencies.useDispatch
local ShareLinksNetworking = dependencies.ShareLinksNetworking
local ShareLinksRodux = dependencies.ShareLinksRodux
local TextKeys = require(ContactImporter.Common.TextKeys)
local useLocalization = dependencies.useLocalization
local RoduxContacts = dependencies.RoduxContacts
local React = dependencies.React
local Promise = dependencies.Promise
local useAnalytics = require(ContactImporter.Analytics.useAnalytics)
local EventNames = require(ContactImporter.Analytics.Enums.EventNames)

local function func1(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(message)
        return tbl1.smsProtocol:supportsSMS():andThen(function(arg1)
            if arg1 then
                return tbl1.smsProtocol:sendSMS({ address = tbl1.address, message = message })
            end
            return Promise.reject()
        end)
    end
end

return function(tbl1)
    local var1 = useDispatch()
    local isLoading, var3 = React.useState(false)
    local function func2()
        var3(false)
    end
    local var4 = useAnalytics()
    local linkId = nil

    local function func3()
        var4.fireAnalyticsEvent(EventNames.InviteContact, { offNetworkFriendRequestLinkId = linkId })

        var3(false)
    end

    local var5 = useLocalization({ rootMessage = TextKeys.SMS_DEFAULT_MESSAGE })

    local function func4(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
        return function(tbl3)
            local shortUrl = tbl3.responseBody.shortUrl

            linkId = tbl3.responseBody.linkId
            return shortUrl .. "\n\n" .. tbl2.rootMessage
        end
    end

    return {
        sendInvite = function()
            var3(true)
            return var1(ShareLinksNetworking.GenerateLink.API({ linkType = ShareLinksRodux.Enums.LinkType.FriendInvite.rawValue() })):andThen(
                (func4(var5))
            ):andThen(
                (func1(tbl1))
            ):andThen(
                var1(RoduxContacts.Actions.RequestSent({ id = tbl1.deviceContactId }))
            ):andThen(
                func3
            ):catch(
                func2
            )
        end,
        isLoading = isLoading
    }
end
