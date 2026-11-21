-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsCarousel = script:FindFirstAncestor("FriendsCarousel")
local dependencies = require(FriendsCarousel.dependencies)
local Roact = dependencies.Roact
local Dash = dependencies.Dash

return Roact.createContext({ fireEvent = Dash.noop })
