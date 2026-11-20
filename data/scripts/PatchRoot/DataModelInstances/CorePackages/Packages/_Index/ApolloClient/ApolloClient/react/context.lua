-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local ApolloContext = require(script.ApolloContext)
local ApolloConsumer = require(script.ApolloConsumer)
local ApolloProvider = require(script.ApolloProvider)
return (Object.assign({}, ApolloContext, ApolloConsumer, ApolloProvider))
