-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local useGetPeopleService = require(PeopleReactView.Hooks.useGetPeopleService)

local function useInExperienceCombinedName(num1: number, str1: string)
    local var1 = useGetPeopleService("PeopleListStore")

    local var2 = React.useMemo(function()
        return var1.getProfile(num1)
    end, { num1 })

    return SignalsReact.useSignalBinding(var2):map(function(arg1)
        return if arg1 and string.len(arg1) > 0 then arg1 else str1
    end)
end

return useInExperienceCombinedName
