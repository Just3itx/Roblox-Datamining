-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local useEventConnection = require(scriptParentParent.ReactUtils).useEventConnection
local isLocalUserInTextChannel = require(script.Parent.isLocalUserInTextChannel)

local function useLocalUserInTextChannel(str1: string, str2: string)
    local var1, var2 = React.useState(function()
        return isLocalUserInTextChannel(str1, str2)
    end)

    React.useEffect(function()
        var2(isLocalUserInTextChannel(str1, str2))
    end, { str1, str2 })

    local function onMembershipChanged()
        var2(isLocalUserInTextChannel(str1, str2))
    end

    useEventConnection(if str1 then str1.ChildAdded else nil, onMembershipChanged, { str1, str2 })

    useEventConnection(if str1 then str1.ChildRemoved else nil, onMembershipChanged, { str1, str2 })

    return var1
end

return useLocalUserInTextChannel
