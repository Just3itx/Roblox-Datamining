-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    genFuzzStrings = function(tbl1)
        return coroutine.wrap(function() -- name: getFuzzStrings
            local allowedChars = tbl1.allowedChars
            local maxLength = tbl1.maxLength
            local allowedCharsLen = #allowedChars

            local num1 = 0

            for i = 1, maxLength do
                num1 += allowedCharsLen ^ i
            end

            coroutine.yield("")

            for i = 0, num1 - 1 do
                local str1 = ""

                while i >= 0 do
                    local num2 = i % allowedCharsLen
                    str1 = allowedChars[num2 + 1] .. str1
                    i = (i - num2) / allowedCharsLen - 1
                end
                coroutine.yield(str1)
            end
        end)
    end
}
