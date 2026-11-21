-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local React = require(GameTileParent.React)
local Otter = require(GameTileParent.Otter)

function ZoomAnimatedFrame(tbl1)
    local isZoomEnabled = tbl1.isZoomEnabled

    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = Otter.createSingleMotor(0)
    end

    assert(var1.current, "zoomMotorRef should always exist; assert only needed for the linter")

    local var2, var3 = React.useBinding(0)

    React.useEffect(function()
        var1.current:onStep(var3)
    end, {})

    React.useEffect(function()
        var1.current:setGoal(
            Otter.spring(if isZoomEnabled then 1 else 0, { frequency = if tbl1.reducedMotion then 200 else 6.5 })
        )
    end, { isZoomEnabled })

    return React.createElement("Frame", {
        Position = var2:map(function(arg1): UDim2
            local var4 = if arg1 > 0.9 then 1 else arg1

            return UDim2.fromOffset(-tbl1.expansionOffsetX * var4 / 2, -tbl1.expansionOffsetTop * var4)
        end),
        Size = var2:map(function(arg1): UDim2
            local var4 = if arg1 > 0.9 then 1 else arg1

            return UDim2.new(1, tbl1.expansionOffsetX * var4, 1, tbl1.expansionOffsetTop * var4 + tbl1.expansionOffsetBottom * var4)
        end),
        BackgroundTransparency = 1
    }, tbl1.children)
end

return ZoomAnimatedFrame
