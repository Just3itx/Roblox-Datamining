-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleServiceParent = script:FindFirstAncestor("PeopleService").Parent

local Promise = require(PeopleServiceParent.Promise)

local function onPersonBlockButtonActivated(player, arg1, num1: number, source: string, _, arg2)
    arg1:trackBlockUserButtonClick(player.UserId, num1, source)
    local modalProps = {
        player = player,
        closeModal = function() end,
        analytics = {
            action = function(_, _: string, str1: string, _)
                if str1 == "blockUser" then
                    arg1:trackBlockUser(player.UserId, num1, source)
                elseif str1 == "unblockUser" then
                    arg1:trackUnblockUser(player.UserId, num1, source)
                elseif str1 == "blockUserButtonClick" then
                    arg1:trackBlockUserButtonClick(player.UserId, num1, source)
                end
            end
        },
        source = source,
        onBlockingSuccess = if arg2 then arg2.onBlockingSuccess or nil else nil
    }

    local var1 = nil

    return {
        modalProps = modalProps,
        promise = Promise.new(function(arg3)
            var1 = arg3
        end),
        resolvePromise = var1,
        useToastFlow = true
    }
end

return onPersonBlockButtonActivated
