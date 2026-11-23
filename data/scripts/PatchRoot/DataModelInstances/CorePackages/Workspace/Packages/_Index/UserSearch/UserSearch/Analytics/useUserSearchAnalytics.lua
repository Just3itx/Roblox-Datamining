-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local React = require(UserSearchParent.React)
local Cryo = require(UserSearchParent.Cryo)

local Analytics = require(script.Parent.Analytics)

local function useUserSearchAnalytics(tbl1)
    local userSearchSessionId = tbl1 and tbl1.userSearchSessionId or HttpService:GenerateGUID(false)

    return (React.useMemo(function()
        return Analytics({ infoForAllEvents = Cryo.Dictionary.join(tbl1 or {}, { userSearchSessionId = userSearchSessionId }) })
    end, { tbl1, userSearchSessionId }))
end

return useUserSearchAnalytics
