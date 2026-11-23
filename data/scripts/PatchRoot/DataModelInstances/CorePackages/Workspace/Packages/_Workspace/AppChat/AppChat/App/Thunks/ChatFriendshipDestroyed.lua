-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local AppCommonLib = require(AppChatParent.AppCommonLib)
local UserLib = require(AppChatParent.UserLib)

local Immutable = AppCommonLib.Immutable
local UpdateUsers = UserLib.Thunks.UpdateUsers

local GetConversationMetadata = AppChatNetworking.rodux.GetConversationMetadata

return function(arg1)
    return function(arg2)
        local user = arg2:getState().Users[arg1]
        if not user then
            return
        end

        local var1 = Immutable.Set(user, "isFriend", false)
        arg2:dispatch(UpdateUsers({ var1 }))
        arg2:dispatch(GetConversationMetadata.API())
    end
end
