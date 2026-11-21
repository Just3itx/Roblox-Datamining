-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local Context = dependencies.SocialLibraries.Context
local React = dependencies.React

local Context2 = require(script.Context)

return {
    Context = Context2,
    Provider = Context2.Provider,
    Consumer = Context2.Consumer,
    with = Context.getWith(Context2),
    connect = Context.getConnect(Context2),
    useContext = function()
        return (React.useContext(Context2))
    end
}
