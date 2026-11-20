-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local getApolloContext = require(script.Parent.ApolloContext).getApolloContext
local invariant = require(scriptParentParentParent.jsutils.invariant).invariant

local _ApolloClient = require(scriptParentParentParent.core.ApolloClient)

function ApolloConsumer(tbl1)
    local apolloContext = getApolloContext()
    return React.createElement(apolloContext.Consumer, nil, function(arg1)
        invariant(
            arg1 and arg1.client,
            "Could not find \"client\" in the context of ApolloConsumer. Wrap the root component in an <ApolloProvider>."
        )

        return tbl1.children(arg1.client)
    end)
end

return {
    ApolloConsumer = ApolloConsumer
}
