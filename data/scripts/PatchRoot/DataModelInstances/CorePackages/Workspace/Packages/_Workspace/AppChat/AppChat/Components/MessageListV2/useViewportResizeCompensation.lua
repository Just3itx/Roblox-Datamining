-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local _ViewRecycler = require(AppChatParent.ViewRecycler)

local function restoreDistanceFromEnd(current, current2: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if current == nil or current2 == nil then
        return
    end
    local distanceFromEnd = current.getScrollState().distanceFromEnd
    if math.abs(distanceFromEnd - current2) <= 1 then
        return
    end

    if current2 <= 1 then
        current.scrollToEnd()
    else
        current.scrollBy(distanceFromEnd - current2)
    end
end

local function useViewportResizeCompensation(tbl1, arg1)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)

    local var4 = React.useRef(false)

    React.useEffect(function()
        if arg1 == nil then
            return nil
        end
        local var5 = arg1
        local connection = var5:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
            local var6 = var4
            var6.current = not (var2.current == nil) and var5.AbsoluteWindowSize.Y ~= var2.current
        end)

        return function()
            connection:Disconnect()
        end
    end, { arg1 })

    return React.useMemo(function()
        return {
            onScrolled = function(current: number)
                local current2 = var1.current

                if current2 ~= nil and current2.AbsoluteWindowSize.Y == var2.current then
                    var3.current = current
                end
            end,
            onContentLengthChanged = function()
                local current = tbl1.current
                if current == nil then
                    return
                end
                local scrollState = current.getScrollState()
                if scrollState.viewportLength == var2.current and not var4.current then
                    var3.current = scrollState.distanceFromEnd
                end
            end,
            onViewportChanged = function(current: number)
                local current2 = var2.current
                var2.current = current
                var4.current = false
                local current3 = tbl1.current
                if current2 ~= nil and current2 ~= current then
                    restoreDistanceFromEnd(current3, var3.current)
                end
                if current3 ~= nil then
                    var3.current = current3.getScrollState().distanceFromEnd
                end
            end,
            onScrollingFrameChanged = function(current)
                if var1.current ~= nil and current ~= var1.current then
                    var2.current = nil
                    var3.current = nil
                    var4.current = false
                end
                var1.current = current
            end
        }
    end, {})
end

return useViewportResizeCompensation
