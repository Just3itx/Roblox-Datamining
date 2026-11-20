-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local User = script:FindFirstAncestor("SocialLibraries").User
local presenceImageByPresence = require(User.presenceImageByPresence)
local getPresenceTextFromUser = require(User.getPresenceTextFromUser)

local getOtherParticipant = require(script.Parent.getOtherParticipant)

return function(arg1, arg2)
    if arg2.conversationType == "OneToOneConversation" then
        local otherParticipant = getOtherParticipant(arg1, arg2.participants)
        if otherParticipant then
            local user = arg1.Users[otherParticipant]
            if user then
                return {
                    image = presenceImageByPresence[user.presence],
                    text = getPresenceTextFromUser(user)
                }
            end
        end
    end

    return nil
end
