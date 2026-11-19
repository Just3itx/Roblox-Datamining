-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:40:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local tbl1 = {}

local React = require(scriptParentParentParentParent.React)
local invariant = require(scriptParentParentParent.jsutils.invariant).invariant
local getApolloContext = require(scriptParentParentParent.react.context).getApolloContext

local _core = require(scriptParentParentParent.core)

function useApolloClient()
    local client = React.useContext(getApolloContext()).client
    invariant(
        client,
        "No Apollo Client instance can be found. Please ensure that you have called `ApolloProvider` higher up in your tree."
    )

    return client
end
tbl1.useApolloClient = useApolloClient

return tbl1
