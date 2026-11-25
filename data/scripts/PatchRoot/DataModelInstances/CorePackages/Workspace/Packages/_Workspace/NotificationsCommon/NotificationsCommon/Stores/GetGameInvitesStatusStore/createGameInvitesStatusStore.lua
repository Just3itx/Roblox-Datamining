-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsCommonParent = script:FindFirstAncestor("NotificationsCommon").Parent

local _Signals = require(NotificationsCommonParent.Signals)
local createSessionScopedSignal = require(NotificationsCommonParent.SignalsUtils).createSessionScopedSignal

return function()
    local getGameInvitesStatus, var2 = createSessionScopedSignal({})

    return {
        getGameInvitesStatus = getGameInvitesStatus,
        receivedUserInviteStatus = function(arg1, str1: string)
            local str2 = tostring(arg1)
            var2(function(tbl1)
                local var3 = table.clone(tbl1)
                var3[str2] = str1
                return var3
            end)
        end,
        reset = function()
            var2({})
        end
    }
end
