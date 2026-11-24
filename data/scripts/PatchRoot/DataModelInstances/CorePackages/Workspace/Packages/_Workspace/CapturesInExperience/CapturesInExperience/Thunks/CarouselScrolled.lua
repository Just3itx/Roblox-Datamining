-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CarouselIndexSelected = require(scriptParentParent.Actions.CarouselIndexSelected)
local Constants = require(scriptParentParent.Constants)

return function(num1: number)
    return function(arg1)
        local captures = arg1:getState()[Constants.RoduxKey].Captures

        local num2 = math.clamp(num1, 1, #captures)
        arg1:dispatch(CarouselIndexSelected(num2))
    end
end
