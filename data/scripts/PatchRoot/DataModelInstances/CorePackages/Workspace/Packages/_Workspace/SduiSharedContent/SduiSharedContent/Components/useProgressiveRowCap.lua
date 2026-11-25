-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local React = require(SduiSharedContentParent.React)

local function useProgressiveRowCap(num1: number, num2: number?, num3: number?, num4: number?)
    local bool1 = num2 ~= nil
    local num5 = math.max(1, num3 or 1)

    local var1, var2 = React.useState(function()
        if not bool1 then
            return num1
        end
        return math.min(math.max(0, num2), num1)
    end)

    local num6 = if bool1 then math.min(var1, num1) else num1
    local bool2 = bool1 and num6 < num1

    React.useEffect(function()
        if not bool2 then
            return nil
        end
        local var3 = nil
        local function advance()
            if var3 then
                return
            end
            var2(function(num7: number): number
                return num7 + num5
            end)
        end

        if num4 and num4 > 0 then
            task.delay(num4 / 1000, advance)
        else
            task.defer(advance)
        end

        return function()
            var3 = true
        end
    end, {
        bool2,
        num5,
        var1,
        num4
    })
    return num6, bool2
end

return useProgressiveRowCap
