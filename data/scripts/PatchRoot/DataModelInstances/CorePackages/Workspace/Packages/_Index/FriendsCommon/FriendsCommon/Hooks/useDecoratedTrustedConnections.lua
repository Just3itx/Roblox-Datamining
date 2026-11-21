-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCommonParent = script:FindFirstAncestor("FriendsCommon").Parent

local React = require(FriendsCommonParent.React)
local Cryo = require(FriendsCommonParent.Cryo)
local SignalsReact = require(FriendsCommonParent.SignalsReact)
local FFlagConnectionManagementChips = require(FriendsCommonParent.SharedFlags).FFlagConnectionManagementChips
local DataHydration = require(FriendsCommonParent.DataHydration)
local _GraphQLServer = require(FriendsCommonParent.GraphQLServer)
local var1 = if FFlagConnectionManagementChips then DataHydration.TrustedConnections.TrustedConnectionsStore.get() else nil

local function useDecoratedTrustedConnections(tbl1)
    if not FFlagConnectionManagementChips then
        return
    end

    local userTrustedConnections = var1.getUserTrustedConnections()
    local var2 = SignalsReact.useSignalState(userTrustedConnections.data)

    local var3 = React.useMemo(function()
        if not tbl1 then
            return {}
        end

        local result = {}
        for _, value in tbl1 do
            result[value.id] = true
        end
        return result
    end, { tbl1 })

    local var4 = React.useMemo(function()
        if not var2 then
            return {}
        end

        local result = {}
        for _, value in var2 do
            result[value.id] = true
        end
        return result
    end, { var2 })

    return (React.useMemo(function()
        if not var2 then
            return {}
        end

        local var5 = Cryo.List.filter(tbl1 or {}, function(arg1): boolean
            return var4[arg1.id] == true
        end)

        local var6 = Cryo.List.filter(var2, function(arg1): boolean
            return var3[arg1.id] ~= true
        end)

        return Cryo.List.join(var5, var6)
    end, { var4, var2, var3 }))
end

return useDecoratedTrustedConnections
