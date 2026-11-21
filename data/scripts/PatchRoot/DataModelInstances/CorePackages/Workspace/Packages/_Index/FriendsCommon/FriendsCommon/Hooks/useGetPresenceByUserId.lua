-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCommonParent = script:FindFirstAncestor("FriendsCommon").Parent

local React = require(FriendsCommonParent.React)
local SignalsReact = require(FriendsCommonParent.SignalsReact)
local var1 = require(FriendsCommonParent.DataHydration).Presence.PresenceStore.get()

local tbl1 = { skipFetch = true }

local function useGetPresenceByUserId(str1: string?, arg1)
    local str2 = if str1 then tostring(str1) else ""

    local var2 = React.useMemo(function()
        local var2 = if str2 == "" then tbl1 else arg1
        return var1.GetPresenceByUserId(str2, var2)
    end, { str2, arg1 })

    local bool1 = not (arg1 == nil) and arg1.forceFetch == true

    React.useEffect(function()
        if str2 ~= "" and bool1 then
            var1.RefreshPresenceByUserId(str2)
        end
    end, { str2, bool1 })

    return SignalsReact.useSignalState(var2.data), (SignalsReact.useSignalState(var2.status))
end

return useGetPresenceByUserId
