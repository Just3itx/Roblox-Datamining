-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T00:40:53Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagBuyRobuxLatencyIxpEnabled = require(script.Parent.FFlagBuyRobuxLatencyIxpEnabled)

local bool1 = game:DefineFastFlag("EnableBuyRobuxNewRouting2", false)
local bool2 = game:DefineFastFlag("EnableBuyRobuxNewRouting3", false)
return (bool1 or bool2) and FFlagBuyRobuxLatencyIxpEnabled
