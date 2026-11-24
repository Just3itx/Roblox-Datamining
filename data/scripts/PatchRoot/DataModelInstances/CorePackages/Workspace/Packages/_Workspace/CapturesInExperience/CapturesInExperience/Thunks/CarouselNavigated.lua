-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CarouselIndexSelected = require(scriptParentParent.Actions.CarouselIndexSelected)
local Constants = require(scriptParentParent.Constants)

return function(left)
    return function(arg1)
        local captures = arg1:getState()[Constants.RoduxKey].Captures
        local num1 = math.clamp(
            arg1:getState()[Constants.RoduxKey].Carousel.SelectedCaptureIndex + (if left == Constants.CarouselDirection.Left then -1 else 1),
            1,
            #captures
        )
        arg1:dispatch(CarouselIndexSelected(num1))
    end
end
