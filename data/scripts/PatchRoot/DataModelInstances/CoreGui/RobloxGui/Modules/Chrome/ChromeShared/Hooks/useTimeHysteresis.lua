-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

return function(current: number, num1: number, num2: number?, bool1: boolean?, _: number?)
    num2 = num2 or num1

    local var1, var2 = React.useState(bool1 or false)
    local var3, var4 = React.useState(false)
    local var5 = React.useRef(bool1 or 0)
    local var6 = React.useRef(false)

    React.useEffect(function()
        local startTime = tick()
        local var7 = nil
        local bool2 = false

        local function func1(arg1, bool3: boolean, current2: number) -- Luacid: Inlined by compiler; 2 call sites recovered
            if arg1 > 0 then
                var7 = task.delay(arg1, function()
                    bool2 = true
                    var7 = nil
                    var5.current = current2
                    var4(bool3)
                end)

                return
            end
            if var3 ~= bool3 then
                bool2 = true
                var4(bool3)
            end
        end

        if var1 then
            func1(num1 - var5.current, true, num1)
        else
            func1(var5.current - current, false, current)
        end

        local var8 = var1
        return function()
            if not bool2 then
                if var7 then
                    task.cancel(var7)
                end
                if not var6.current then
                    local var9 = tick() - startTime
                    if not var8 then
                        var9 *= -1
                    end
                    local var10 = var5
                    var10.current = math.clamp(var5.current + var9, 0, num2)
                end
            end
            var6.current = false
        end
    end, {
        var1,
        var3,
        current,
        num1,
        num2
    })
    return var3, (React.useCallback(function(bool2: boolean, current2: boolean?)
        var6.current = current2
        if current2 then
            if bool2 then
                var5.current = num2
            else
                var5.current = 0
            end
        end
        var2(bool2)
    end, { var2 }))
end
