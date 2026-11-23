-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local AppChatNetworking = require(AppChat.Parent.AppChatNetworking)
local Logger = require(AppChat.Logger)

return function(arg1)
    return function(arg2)
        arg2:dispatch(AppChatNetworking.rodux.UpdateTypingStatus.API(arg1)):catch(function(arg3)
            Logger:error(`AppChatNetworking failure in updateTypingStatus, Status: {tostring(arg3)}`)
        end)
    end
end
