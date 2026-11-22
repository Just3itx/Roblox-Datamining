-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local _ViewRecycler = require(MomentsParent.ViewRecycler)

local _CommentRowTypes = require(script.Parent.Parent.Rows.CommentRowTypes)
local createCommentsListRevealTracker = require(script.Parent.createCommentsListRevealTracker)

local function useCommentsListReveal(layout, current, current2: ((...any) -> (...any))?)
    local var1 = React.useRef(current)
    var1.current = current
    local var2 = React.useRef(current2)
    var2.current = current2

    local var3 = React.useState(function()
        return createCommentsListRevealTracker({
            layout = layout,
            getItemKey = function(num1: number)
                local var3 = var1.current[num1]
                return if var3 == nil then nil else var3.key
            end,
            onReady = function()
                local current3 = var2.current
                if current3 ~= nil then
                    current3()
                end
            end
        })
    end)

    React.useEffect(function()
        local var4 = task.delay(1, var3.reveal)
        return function()
            var3.destroy()
            pcall(task.cancel, var4)
        end
    end, { var3 })

    return var3
end

return useCommentsListReveal
