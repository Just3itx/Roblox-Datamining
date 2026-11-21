-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local _ViewRecycler = require(ChatUIPrimitivesParent.ViewRecycler)

local function distanceFromEnd(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteWindowSize.Y - arg1.CanvasPosition.Y
end

local function useKeepEndOnResize(arg1, tbl1)
    React.useEffect(function()
        if arg1 == nil then
            return nil
        end
        local var1 = arg1
        local absoluteWindowSizeY = var1.AbsoluteWindowSize.Y
        local bool1 = distanceFromEnd(var1) <= 1
        local var2 = nil

        local connection = var1:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if var1.AbsoluteWindowSize.Y ~= absoluteWindowSizeY or var2 ~= nil then
                return
            end
            bool1 = distanceFromEnd(var1) <= 1
        end)
        local connection2 = var1:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
            local absoluteWindowSizeY2 = var1.AbsoluteWindowSize.Y
            if absoluteWindowSizeY2 == absoluteWindowSizeY then
                return
            end
            absoluteWindowSizeY = absoluteWindowSizeY2
            if not bool1 or var2 ~= nil then
                return
            end
            var2 = task.defer(function()
                var2 = nil
                local current = tbl1.current
                if current ~= nil then
                    current.scrollToEnd()
                end
            end)
        end)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
            if var2 ~= nil then
                task.cancel(var2)
            end
        end
    end, { arg1, tbl1 })
end

return useKeepEndOnResize
