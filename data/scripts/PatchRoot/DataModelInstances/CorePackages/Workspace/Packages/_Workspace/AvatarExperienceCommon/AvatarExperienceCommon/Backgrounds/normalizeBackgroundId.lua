-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NO_BACKGROUND_ASSET_ID = require(script.Parent.constants).NO_BACKGROUND_ASSET_ID

local function normalizeBackgroundId(num1: number?): number?
    return if num1 == nil or num1 == NO_BACKGROUND_ASSET_ID then nil else num1
end

return normalizeBackgroundId
