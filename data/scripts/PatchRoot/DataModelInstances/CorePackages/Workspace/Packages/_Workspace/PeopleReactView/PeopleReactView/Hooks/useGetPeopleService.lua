-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local React = require(PeopleReactViewParent.React)
local PeopleService = require(PeopleReactViewParent.PeopleService)

local function useGetPeopleService(str1: string)
    return (React.useMemo(function()
        return PeopleService.getService(str1)
    end, {}))
end

return useGetPeopleService
