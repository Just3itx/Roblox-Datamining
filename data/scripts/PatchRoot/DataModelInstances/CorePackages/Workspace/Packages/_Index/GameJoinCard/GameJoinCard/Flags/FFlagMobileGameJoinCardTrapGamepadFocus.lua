-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local FFlagMobileGameJoinCardGamepadSupport = require(GameJoinCardParent.SharedFlags).FFlagMobileGameJoinCardGamepadSupport

return game:DefineFastFlag("MobileGameJoinCardTrapGamepadFocus", false) and FFlagMobileGameJoinCardGamepadSupport
