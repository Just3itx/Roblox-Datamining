-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local t = require(CorePackages.Packages.t)

return t.union(t.instanceIsA("Player"), t.interface({ UserId = t.integer, Name = t.string, DisplayName = t.string }))
