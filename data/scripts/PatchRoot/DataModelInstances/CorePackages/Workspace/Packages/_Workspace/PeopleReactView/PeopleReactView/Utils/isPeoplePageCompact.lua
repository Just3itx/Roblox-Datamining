-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")

local Constants = require(PeopleReactView.Constants)

return function(num1: number): boolean
    return num1 > 0 and math.round(num1) < Constants.PEOPLEPAGE.STACKED_ROW_MAX_WINDOW_WIDTH
end
