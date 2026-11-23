-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)

local getTFAction = require(TrustedContacts.Requests.getTFAction)
local _TFActionsEnum = require(script.Parent.TFActionsEnum)
local FFlagTFPassQRCodeSource = require(TrustedContacts.Flags.FFlagTFPassQRCodeSource)

local function useTrustedFriendAction(tbl1)
    local userId = tbl1.userId
    local tokens = tbl1.tokens
    local sentFromQrCode = if FFlagTFPassQRCodeSource then tbl1.sentFromQrCode else nil
    local var1, var2 = React.useState({ isLoading = true, enum = nil })

    local useEffect = React.useEffect

    local function func1()
        local var3 = getTFAction
        local var4 = userId
        local tbl2 = {
            friendRequestToken = tokens,
            sentFromQrCode = if FFlagTFPassQRCodeSource then sentFromQrCode else nil
        }

        var3(var4, tbl2):andThen(function(enum)
            var2({ isLoading = false, enum = enum })
        end):catch(function(_)
            var2({ isLoading = false, enum = nil })
        end)
    end

    local var3 = if FFlagTFPassQRCodeSource then sentFromQrCode else nil
    useEffect(func1, { userId, tokens, var3 })

    return var1
end

return useTrustedFriendAction
