-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function readFrameLength(str1: string, num1: number)
    local num2 = 0
    local num3 = 1

    local num4 = num1 + 5 - 1
    local num5 = #str1

    for i = num1, math.min(num4, num5) do
        local var1 = string.byte(str1, i)

        num2 += var1 % 128 * num3

        if var1 < 128 then
            return num2, i - num1 + 1
        end

        num3 *= 128
    end

    if #str1 - num1 + 1 >= 5 then
        error("Frame length varint exceeds maximum size")
    end

    return nil, 0
end

return {
    isEmptyResponseBody = function(arg1): boolean
        return arg1 == nil or (if typeof(arg1) == "string" then arg1 == "" else typeof(arg1) == "buffer" and buffer.len(arg1) == 0)
    end,
    extractFrames = function(str1: string)
        local num1 = 1
        local tbl1 = {}

        while num1 <= #str1 do
            local var1, num2 = readFrameLength(str1, num1)
            if var1 == nil then
                break
            end

            if var1 == 0 then
                error("Frame length of zero is not a valid frame")
            end

            if var1 > 52428800 then
                error(`Frame length {var1} exceeds maximum supported size`)
            end

            local num3 = num1 + num2
            local var2 = num3 + var1 - 1
            if #str1 < var2 then
                break
            end

            table.insert(tbl1, string.sub(str1, num3, var2))
            num1 = var2 + 1
        end

        return tbl1, string.sub(str1, num1)
    end
}
