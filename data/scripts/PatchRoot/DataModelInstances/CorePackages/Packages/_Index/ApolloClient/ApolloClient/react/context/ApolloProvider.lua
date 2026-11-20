-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local _LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local React = require(scriptParentParentParentParent.React)

local getApolloContext = require(script.Parent.ApolloContext).getApolloContext
local invariant = require(scriptParentParentParent.jsutils.invariant).invariant

local _ApolloClient = require(scriptParentParentParent.core.ApolloClient)

function ApolloProvider(tbl1)
    local apolloContext = getApolloContext()
    return React.createElement(apolloContext.Consumer, nil, function(value)
        value = value == nil and {} or value

        if tbl1.client and value.client ~= tbl1.client then
            value.client = tbl1.client
        end
        invariant(
            value.client,
            "ApolloProvider was not passed a client instance. Make sure you pass in your client via the \"client\" prop."
        )

        return React.createElement(apolloContext.Provider, { value = value }, tbl1.children)
    end)
end

return {
    ApolloProvider = ApolloProvider
}
