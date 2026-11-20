-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)

local _Tokens = require(Foundation.Providers.Style.Tokens)

return {
    animate = function(tbl1, bool1: boolean, arg1, bool2: boolean)
        local startingValue = tbl1.drag:getValue()
        local var1 = if startingValue == nil then nil else 1 - startingValue

        if bool2 then
            tbl1.setPanelGoal(Otter.instant(if bool1 then 1 else 0))
            tbl1.setBackdropGoal(Otter.instant(if bool1 then 0 else 1))
        elseif bool1 then
            tbl1.setPanelGoal(
                Otter.ease(1, { easingStyle = arg1.Ease.StandardOut, duration = arg1.Time.Time_300, startingValue = startingValue })
            )
            tbl1.setBackdropGoal(Otter.ease(0, { duration = arg1.Time.Time_100, startingValue = var1 }))
        else
            tbl1.setPanelGoal(
                Otter.ease(0, { easingStyle = arg1.Ease.StandardIn, duration = arg1.Time.Time_100, startingValue = startingValue })
            )
            tbl1.setBackdropGoal(Otter.ease(1, { duration = arg1.Time.Time_100, startingValue = var1 }))
        end

        if startingValue ~= nil then
            tbl1.setDrag(nil)
        end
    end,
    hold = function(tbl1)
        tbl1.setPanelGoal(Otter.instant(tbl1.panelProgress:getValue()))
        tbl1.setBackdropGoal(Otter.instant(tbl1.backdropTransparency:getValue()))
    end,
    useDrag = function()
        local var1 = React.useState(function()
            local drag, setDrag = React.createBinding(nil)
            return { drag = drag, setDrag = setDrag }
        end)
        return var1.drag, var1.setDrag
    end
}
