-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { ar = true, fa = true, he = true, ur = true }

return {
    DEFAULT_SPEED = 25,
    DEFAULT_MAX_LOOPS = 2,
    GAP = 24,
    textDirectionFromLocale = function(str1: string): Enum.TextDirection
        local str2 = string.lower(string.match(str1, "^([^%-]+)") or str1)
        return if tbl1[str2] then Enum.TextDirection.RightToLeft else Enum.TextDirection.LeftToRight
    end,
    travelDistance = function(num1: number, num2: number): number
        if num1 <= 0 or num2 <= 0 then
            return 0
        end

        return math.max(num1 + 24, num2)
    end,
    overflows = function(num1: number, num2: number): boolean
        return num2 > 0 and num2 < num1
    end,
    advance = function(tbl2, offset: number, num1: number, num2: number, num3: number) -- name: advanceMarquee
        if tbl2.finished or offset <= 0 or num3 <= 0 then
            return {
                offset = 0,
                loopsCompleted = tbl2.loopsCompleted,
                finished = true
            }
        end

        if num1 <= 0 or num2 <= 0 then
            return tbl2
        end

        if offset <= tbl2.offset then
            return tbl2
        end

        local var1 = tbl2.offset + num1 * num2
        local loopsCompleted = tbl2.loopsCompleted
        while offset <= var1 and loopsCompleted < num3 do
            var1 -= offset
            loopsCompleted += 1
        end

        return if num3 <= loopsCompleted then {
            offset = 0,
            loopsCompleted = loopsCompleted,
            finished = true
        } else { offset = var1, loopsCompleted = loopsCompleted, finished = false }
    end,
    signedOffset = function(num1: number, textDirection): number
        return if textDirection == Enum.TextDirection.RightToLeft then num1 else -num1
    end
}
