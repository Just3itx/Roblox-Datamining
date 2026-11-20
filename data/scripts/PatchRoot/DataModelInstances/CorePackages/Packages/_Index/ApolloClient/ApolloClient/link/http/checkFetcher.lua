-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean

local module = {}

local InvariantError = require(scriptParentParentParent.jsutils.invariant).InvariantError

function module.checkFetcher(func1: ((...any) -> (...any))?)
    if not Boolean.toJSBoolean(func1) and typeof(_G.fetch) == "nil" then
        error(
            InvariantError.new(
                "\n\"fetch\" has not been found globally and no fetcher has been configured. To fix this, install a fetch package (like https://www.npmjs.com/package/cross-fetch), instantiate the fetcher, and pass it into your HttpLink constructor. For example:\n\nimport fetch from 'cross-fetch';\nimport { ApolloClient, HttpLink } from '@apollo/client';\nconst client = new ApolloClient({\n  link: new HttpLink({ uri: '/graphql', fetch })\n});\n    "
            )
        )
    end
end

return module
