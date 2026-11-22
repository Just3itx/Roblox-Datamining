-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)
local Roact = dependencies.Roact
local Dash = dependencies.Dash

return Roact.createContext({ fireEvent = Dash.noop })
