-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local TooltipContext = require(script.Parent.TooltipContext)

function TooltipProvider(arg1)
    local var1, var2 = React.useState(nil)

    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)

    local var5 = React.useRef(nil)

    local var6 = React.useRef({})

    local var7 = React.useCallback(function(current)
        var2(current)
        var3.current = current

        if var3.current and var4.current and var3.current.id == var4.current.id then
            var4.current = nil
        end
    end, {})

    local var8 = React.useCallback(function(id: string)
        if var3 and var3.current and var3.current.id == id then
            var7(nil)
        end
        if var4 and var4.current and var4.current.id == id then
            var4.current = nil
        end

        local var8 = nil
        for _, value in pairs(var6.current) do
            if value.id == id then
                var8 = value
                break
            end
        end

        if var8 and var8.priority and var6.current[var8.priority] then
            var6.current[var8.priority] = nil
        end
    end, { var1 })

    var5.current = React.useCallback(function()
        if var3.current or var4.current then
            return
        end

        local current = var6.current
        local tbl1 = {}

        for _, value in pairs(current) do
            table.insert(tbl1, value)
        end

        table.sort(tbl1, function(tbl2, tbl3): boolean
            return tbl2.priority > tbl3.priority
        end)

        local var9 = tbl1[1]
        if not var9 then
            return
        end

        var4.current = var9

        task.delay(var9.showDelay / 1000, function()
            var7(var9)

            task.delay(var9.dismissDelay / 1000, function()
                var8(var9.id)
                if var5.current then
                    var5.current()
                end
            end)
        end)
    end, { var1 })

    local function func1() -- Luacid: Inlined by compiler; 3 call sites recovered
        if var5.current then
            var5.current()
        end
    end

    local value = React.useMemo(function()
        return {
            registerTooltip = function(id: string, priority: number, showDelay: number, dismissDelay: number)
                if var6.current[priority] then
                    return
                end

                table.insert(
                    var6.current,
                    priority,
                    {
                        id = id,
                        priority = priority,
                        showDelay = showDelay,
                        dismissDelay = dismissDelay
                    }
                )
                func1()
            end,
            unregisterTooltip = function(str1: string)
                var8(str1)
                func1()
            end,
            dismissTooltip = function(str1: string, _: string?)
                var8(str1)
                func1()
            end,
            isCurrentTooltip = function(id: string)
                return var1 and var1.id == id
            end
        }
    end, { var1 })

    return React.createElement(TooltipContext.Provider, { value = value }, arg1.children)
end

return TooltipProvider
