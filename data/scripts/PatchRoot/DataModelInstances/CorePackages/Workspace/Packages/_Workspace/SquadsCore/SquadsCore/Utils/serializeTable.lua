-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local HttpService = game:GetService("HttpService")

local FFlagDebugSquadLogsEnabled = require(SquadsCoreParent.SharedFlags).FFlagDebugSquadLogsEnabled

return function(input)
    if FFlagDebugSquadLogsEnabled then
        return HttpService:JSONEncode(input)
    end

    return input
end
