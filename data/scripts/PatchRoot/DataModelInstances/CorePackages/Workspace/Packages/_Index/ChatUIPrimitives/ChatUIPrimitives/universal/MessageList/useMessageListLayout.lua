-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local ViewRecycler = require(ChatUIPrimitivesParent.ViewRecycler)
local MessageInlineItemMetrics = require(script.Parent.Inline.MessageInlineItemMetrics)

local var1 = table.freeze({ accepted = false, geometryChanged = false })

local function rejectEmptyMeasurements(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = table.clone(arg1)
    function var2.updateItemMeasurement(arg2)
        if arg2.length <= 0 then
            return var1
        end
        return arg1.updateItemMeasurement(arg2)
    end
    return var2
end

local function useMessageListLayout(estimatedItemLength: number?)
    if estimatedItemLength == nil then
        estimatedItemLength = MessageInlineItemMetrics.MIN_HEIGHT
    end

    local var2 = React.useMemo(function()
        return rejectEmptyMeasurements((ViewRecycler.Layout.measured({ estimatedItemLength = estimatedItemLength })))
    end, { estimatedItemLength })
    React.useEffect(function()
        return function()
            var2.destroy()
        end
    end, { var2 })
    return var2
end

return useMessageListLayout
