-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserBlockingRoduxParent = script:FindFirstAncestor("UserBlockingRodux").Parent
local Rodux = require(UserBlockingRoduxParent.Rodux)

return {
    mockBlockUserById = "BLOCK_USER_BY_ID_SUCCEEDED_ACTION",
    mockUnblockUserById = "UNBLOCK_USER_BY_ID_SUCCEEDED_ACTION",
    mockIsBlockedById = "IS_BLOCKED_BY_ID_SUCCEEDED_ACTION",
    mockBlockUserByIdAction = Rodux.makeActionCreator("BLOCK_USER_BY_ID_SUCCEEDED_ACTION", function(arg1)
        return {
            responseBody = {},
            namedIds = {
                users = arg1.userId
            }
        }
    end),
    mockUnblockUserByIdAction = Rodux.makeActionCreator("UNBLOCK_USER_BY_ID_SUCCEEDED_ACTION", function(arg1)
        return {
            responseBody = {},
            namedIds = {
                users = arg1.userId
            }
        }
    end),
    mockIsBlockedByIdAction = Rodux.makeActionCreator("IS_BLOCKED_BY_ID_SUCCEEDED_ACTION", function(arg1)
        return {
            responseBody = true,
            namedIds = {
                users = arg1.userId
            }
        }
    end)
}
