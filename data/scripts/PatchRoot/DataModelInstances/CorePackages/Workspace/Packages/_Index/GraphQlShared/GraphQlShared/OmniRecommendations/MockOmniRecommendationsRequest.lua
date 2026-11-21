-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQlSharedParent = script:FindFirstAncestor("GraphQlShared").Parent
local Promise = require(GraphQlSharedParent.Promise)

return {
    SuccessfulRequest = function(responseBody)
        return function(_, _, _, _, _)
            return Promise.resolve(
                {
                    responseCode = 200,
                    responseTimeMs = 480,
                    isJSONValid = true,
                    responseBody,
                    responseBody = responseBody
                }
            )
        end
    end
}
