-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}

local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

tbl1.default = require(script.Parent.Parent.utils).mergeResolvers({
    require(script.Parent.UserResolver).default,
    require(script.Parent.PlayerResolver).default,
    require(script.Parent.OmniFeed).default,
    require(script.Parent.ScalarResolver).default,
    require(script.Parent.VirtualEventResolver),
    require(script.Parent.ExperienceResolver),
    require(script.Parent.ProfileInsightsResolver),
    require(script.Parent.AmpUpsellResolver).default,
    require(script.Parent.UserProfileResolver),
    require(script.Parent.FriendsResolver),
    (require(script.Parent.ShareLinkResolver))
})
return tbl1
