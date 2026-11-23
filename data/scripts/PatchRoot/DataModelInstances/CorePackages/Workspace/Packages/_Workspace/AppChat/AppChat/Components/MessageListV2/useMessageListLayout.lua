-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local ViewRecycler = require(AppChatParent.ViewRecycler)

local FIntAppChatMessageListV2EstimatedRowHeight = require(AppChat.Flags.FIntAppChatMessageListV2EstimatedRowHeight)

local var1 = table.freeze({ accepted = false, geometryChanged = false })

local function rejectEmptyMeasurements(arg1, callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = table.clone(arg1)
    function var2.updateItemMeasurement(arg2)
        if arg2.length <= 0 then
            return var1
        end
        local var3 = arg1.updateItemMeasurement(arg2)
        callback()
        return var3
    end
    return var2
end

local function useMessageListLayout(current: ((...any) -> (...any))?)
    local var2 = React.useRef(current)
    var2.current = current
    local var3 = React.useState(function()
        local bool1 = false

        return rejectEmptyMeasurements(
            ViewRecycler.Layout.measured({ estimatedItemLength = FIntAppChatMessageListV2EstimatedRowHeight }),
            function()
                if bool1 then
                    return
                end
                bool1 = true

                task.defer(function()
                    local current2 = var2.current
                    if current2 ~= nil then
                        current2()
                    end
                end)
            end
        )
    end)
    React.useEffect(function()
        return function()
            var2.current = nil
            var3.destroy()
        end
    end, { var3 })
    return var3
end

return useMessageListLayout
