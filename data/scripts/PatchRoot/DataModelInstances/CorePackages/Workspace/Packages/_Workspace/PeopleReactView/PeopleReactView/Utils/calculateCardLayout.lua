-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")

local Constants = require(PeopleReactView.Constants)

return function(num1: number, num2: number, num3: number): (number, number)
    local num4 = math.clamp(
        math.floor(num2 / num1),
        Constants.PEOPLEPAGE.PEOPLE_CARDS.MIN_CARD_COLUMNS,
        Constants.PEOPLEPAGE.PEOPLE_CARDS.MAX_CARD_COLUMNS
    )
    local num5 = math.ceil(num3 * (num4 - 1) / num4)
    return math.floor(num2 / num4) - num5, num4
end
