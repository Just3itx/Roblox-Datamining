-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local React = require(ShareSheetParent.React)

local _RecipientKind = require(script.Parent.RecipientKind)
local UserProfile = require(ShareSheetParent.DataHydration.UserProfile)
local useExternalChatUserEligibility = require(ShareSheetParent.AppChat.useExternalChatUserEligibility)

return {
    create = function(userId: string)
        return {
            kind = "user",
            id = `user:{userId}`,
            userId = userId
        }
    end,
    kind = {
        useEligibility = function(arg1)
            local var1 = useExternalChatUserEligibility({ isActive = arg1.isActive and #arg1.recipients > 0 })

            return React.useMemo(function()
                return {
                    isLoading = var1.isLoading,
                    isEligible = function()
                        return var1.isEligible
                    end
                }
            end, { var1 })
        end,
        canSend = function(arg1, arg2)
            return arg1.canSendToUser(arg2.userId)
        end,
        send = function(arg1, arg2, arg3)
            return arg1.sendToUser(arg2.userId, arg3)
        end,
        getName = function(arg1, arg2)
            local var1 = UserProfile.getAndFetchUserInfo(arg1.userId).info(arg2)
            return if var1 then var1.displayName else ""
        end,
        getParticipantIds = function(arg1)
            return { arg1.userId }
        end
    }
}
