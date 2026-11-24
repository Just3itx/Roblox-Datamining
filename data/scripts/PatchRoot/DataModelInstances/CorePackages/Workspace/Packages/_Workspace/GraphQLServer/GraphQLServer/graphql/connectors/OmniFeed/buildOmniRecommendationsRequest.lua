-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local MakeOmniRecommendationsRequest = require(GraphQLServerParent.GraphQlShared).MakeOmniRecommendationsRequest
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

local _Fetch = require(GraphQLServerParent.Fetch)

local function makeNetworkImpl(func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(str1: string, _: string, tbl1)
        return func1(str1, {
            body = tbl1.postBody,
            method = "POST",
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        })
    end
end

return function(arg1)
    local networkImpl = makeNetworkImpl(arg1)

    return function(arg2, arg3, arg4, arg5)
        return MakeOmniRecommendationsRequest(networkImpl, arg2, arg3, arg4, arg5)
    end
end
