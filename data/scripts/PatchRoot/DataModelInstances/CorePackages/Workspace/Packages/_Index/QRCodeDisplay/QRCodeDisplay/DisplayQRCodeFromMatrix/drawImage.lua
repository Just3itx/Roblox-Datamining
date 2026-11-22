-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, num1: number, tbl1, color3: Color3, num2: number): buffer
    local r = color3.R
    local g = color3.G
    local b = color3.B
    local num3 = 1 - num2

    local buffer2 = buffer.create(num1 * num1 * 4)
    local offset = 0
    for i = 1, num1 do
        for j = 1, num1 do
            local num4 = math.floor((j - 1) / num1 * #tbl1) + 1

            if tbl1[math.floor((i - 1) / num1 * #tbl1) + 1][num4] > 0 then
                buffer.writeu8(buffer2, offset, r * 255)
                buffer.writeu8(buffer2, offset + 1, g * 255)
                buffer.writeu8(buffer2, offset + 2, b * 255)
                buffer.writeu8(buffer2, offset + 3, num3 * 255)
            else
                buffer.writeu8(buffer2, offset, 255)
                buffer.writeu8(buffer2, offset + 1, 255)
                buffer.writeu8(buffer2, offset + 2, 255)
                buffer.writeu8(buffer2, offset + 3, 0)
            end
            offset += 4
        end
    end

    arg1:WritePixelsBuffer(Vector2.new(0, 0), Vector2.new(num1, num1), buffer2)

    return buffer2
end
