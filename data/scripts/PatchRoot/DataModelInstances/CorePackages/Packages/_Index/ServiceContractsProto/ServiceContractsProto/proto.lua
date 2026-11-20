-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local base64 = require(script.base64)
local _message = require(script.message)
local _typeRegistry = require(script.typeRegistry)

local module = {}

local function readVarIntBytes(buf: buffer, offset: number): (number, number, number)
    local num1 = 0
    local num2 = 0
    local num3 = 0

    repeat
        local num4 = buffer.readu8(buf, offset)
        local num5 = bit32.band(num4, 0x7F)
        num2 = bit32.bor(num2, bit32.lshift(num5, num1))
        num3 = bit32.bor(num3, bit32.lshift(num5, num1 - 32))
        num1 += 7
        offset += 1
    until not bit32.btest(num4, 0x80)

    return num2, num3, offset
end

function module.readVarIntU64(buffer: buffer, num1: number): (number, number)
    local var1, var2
    var1, var2, num1 = readVarIntBytes(buffer, num1)

    return var2 * 4294967296 + var1, num1
end

function module.readVarIntU32(buffer: buffer, num1: number): (number, number)
    local var1, _
    var1, _, num1 = readVarIntBytes(buffer, num1)

    return var1, num1
end

function module.readVarIntI64(buffer: buffer, num1: number)
    local var1, var2
    var1, var2, num1 = readVarIntBytes(buffer, num1)

    if var2 < 2147483648 then
        return var2 * 4294967296 + var1, num1
    end

    local num2 = bit32.bnot(var1) + 1
    local num3 = bit32.bnot(var2)

    if num2 > 4294967295 then
        num3 += 1
        num2 = 0
    end

    return -(num3 * 4294967296 + num2), num1
end

function module.readVarIntI32(buffer: buffer, num1: number)
    local var1, _
    var1, _, num1 = readVarIntBytes(buffer, num1)

    if var1 < 2147483648 then
        return var1, num1
    end

    return var1 - 4294967296, num1
end

function module.readVarIntS64(buffer: buffer, num1: number): (number, number)
    local var1, var2
    var1, var2, num1 = readVarIntBytes(buffer, num1)

    local bool1 = bit32.btest(var1, 1)
    if bool1 then
        var1 += 1
        if var1 > 4294967295 then
            var2 += 1
            var1 = 0
        end
    end

    if var2 > 4294967295 then
        return -2 ^ 63, num1
    end

    local num2 = bit32.bor(bit32.rshift(var1, 1), bit32.lshift(bit32.band(var2, 1), 31))
    local num3 = bit32.rshift(var2, 1)

    if bool1 then
        return -(num3 * 4294967296 + num2), num1
    end

    return num3 * 4294967296 + num2, num1
end

function module.readVarIntS32(buffer: buffer, num1: number)
    local var1, _
    var1, _, num1 = readVarIntBytes(buffer, num1)

    if bit32.btest(var1, 1) then
        return -(var1 + 1) / 2, num1
    end

    return var1 / 2, num1
end

module.readVarInt = module.readVarIntI64

function module.readFloat(buf: buffer, offset: number): (number, number)
    return buffer.readf32(buf, offset), offset + 4
end

function module.readDouble(buf: buffer, offset: number): (number, number)
    return buffer.readf64(buf, offset), offset + 8
end

function module.readFixed32(buf: buffer, offset: number): (number, number)
    return buffer.readu32(buf, offset), offset + 4
end

function module.readSignedFixed32(buf: buffer, offset: number): (number, number)
    return buffer.readi32(buf, offset), offset + 4
end

function module.readFixed64(buf: buffer, offset: number): (number?, number)
    return assert(
        tonumber(
            string.format("%08x", buffer.readu32(buf, offset + 4)) .. string.format("%08x", buffer.readu32(buf, offset)),
            16
        ),
        "Couldn't parse created hex"
    ), offset + 8
end

function module.readSignedFixed64(_buffer: buffer, _: number)
    error("TODO: Read sfixed64")
end

function module.readTag(buf1: buffer, num1: number)
    local var1, var2 = module.readVarInt(buf1, num1)
    return bit32.rshift(var1, 3), bit32.band(var1, 7), var2
end

function module.readBuffer(source: buffer, num1: number)
    local var1, sourceOffset = module.readVarInt(source, num1)
    local buffer2 = buffer.create(var1)
    buffer.copy(buffer2, 0, source, sourceOffset, var1)
    return buffer2, sourceOffset + var1
end

local function reserveBuffer(buf1: buffer, count: number, num1: number): buffer
    if not (buffer.len(buf1) - count < num1) then
        return buf1
    end

    local target = buffer.create(3 ^ math.ceil(math.log(buffer.len(buf1) + num1, 3)))
    buffer.copy(target, 0, buf1, 0, count)
    return target
end

module.wireTypes = { varint = 0, i64 = 1, lengthDelimited = 2, sgroup = 3, egroup = 4, i32 = 5 }

function module.writeVarInt(buf1: buffer, offset: number, num1: number)
    if num1 >= 0 then
        repeat
            buf1 = reserveBuffer(buf1, offset, 1)
            local num2 = num1 % 128
            num1 //= 128
            if num1 ~= 0 then
                num2 += 128
            end

            buffer.writeu8(buf1, offset, num2)
            offset += 1
        until num1 == 0
    else
        local num2 = -num1
        local num3 = bit32.bnot(num2 // 4294967296)
        local num4 = bit32.bnot(num2 % 4294967296) + 1
        if num4 == 4294967296 then
            num3 += 1
            num4 = 0
        end

        buf1 = reserveBuffer(buf1, offset, 10)
        buffer.writeu8(buf1, offset, bit32.bor(0x80, bit32.band(num4, 0x7F)))
        buffer.writeu8(buf1, offset + 1, bit32.bor(0x80, bit32.band(bit32.rshift(num4, 7), 0x7F)))
        buffer.writeu8(buf1, offset + 2, bit32.bor(0x80, bit32.band(bit32.rshift(num4, 14), 0x7F)))
        buffer.writeu8(buf1, offset + 3, bit32.bor(0x80, bit32.band(bit32.rshift(num4, 21), 0x7F)))
        buffer.writeu8(buf1, offset + 4, bit32.bor(0x80, bit32.lshift(bit32.band(num3, 7), 4), bit32.rshift(num4, 28)))

        buffer.writeu8(buf1, offset + 5, bit32.bor(0x80, bit32.band(bit32.rshift(num3, 3), 0x7F)))
        buffer.writeu8(buf1, offset + 6, bit32.bor(0x80, bit32.band(bit32.rshift(num3, 10), 0x7F)))
        buffer.writeu8(buf1, offset + 7, bit32.bor(0x80, bit32.band(bit32.rshift(num3, 17), 0x7F)))
        buffer.writeu8(buf1, offset + 8, bit32.bor(0x80, bit32.band(bit32.rshift(num3, 24), 0x7F)))
        buffer.writeu8(buf1, offset + 9, bit32.rshift(num3, 31))
        offset += 10
    end

    return buf1, offset
end

function module.writeVarIntZigZag(buf1: buffer, offset: number, num1: number)
    local bool1 = num1 < 0
    num1 = math.abs(num1)

    local num2 = num1 // 4294967296
    local num3 = num1 % 4294967296

    local num4 = bit32.extract(num3, 31)
    local num5 = bit32.lshift(num3, 1)
    local num6 = bit32.bor(bit32.lshift(num2, 1), num4)

    if bool1 then
        num5 -= 1
        if num5 < 0 then
            num6 -= 1
            num5 = 4294967295
        end
    end

    repeat
        buf1 = reserveBuffer(buf1, offset, 1)
        local num7 = num5 % 128
        num5 = bit32.bor(bit32.rshift(num5, 7), bit32.lshift(bit32.band(num6, 0x7F), 25))
        num6 = bit32.rshift(num6, 7)
        local bool2 = num5 == 0 and num6 == 0

        if not bool2 then
            num7 += 128
        end

        buffer.writeu8(buf1, offset, num7)
        offset += 1
    until bool2

    return buf1, offset
end

function module.writeFloat(buf1: buffer, offset: number, num1: number): (buffer, number)
    buf1 = reserveBuffer(buf1, offset, 4)
    buffer.writef32(buf1, offset, num1)
    return buf1, offset + 4
end

function module.writeDouble(buf1: buffer, offset: number, num1: number): (buffer, number)
    buf1 = reserveBuffer(buf1, offset, 8)
    buffer.writef64(buf1, offset, num1)
    return buf1, offset + 8
end

function module.writeFixed32(buf1: buffer, offset: number, num1: number): (buffer, number)
    buf1 = reserveBuffer(buf1, offset, 4)
    buffer.writeu32(buf1, offset, num1)
    return buf1, offset + 4
end

function module.writeSignedFixed32(buf1: buffer, offset: number, num1: number): (buffer, number)
    buf1 = reserveBuffer(buf1, offset, 4)
    buffer.writei32(buf1, offset, num1)
    return buf1, offset + 4
end

function module.writeFixed64(buffer2: buffer, count: number, num1: number): (buffer, number)
    buffer2 = reserveBuffer(buffer2, count, 8)

    local str1 = string.format("%016x", num1)
    buffer.writeu32(buffer2, count, assert(tonumber(str1:sub(9, 16), 16), "Couldn't parse created hex"))
    buffer.writeu32(buffer2, count + 4, assert(tonumber(str1:sub(1, 8), 16), "Couldn't parse created hex"))

    return buffer2, count + 8
end

function module.writeSignedFixed64(_buffer: buffer, _: number, _: number)
    error("TODO: Write sfixed64")
end

function module.writeTag(buf1: buffer, num1: number, num2: number, num3: number)
    return module.writeVarInt(buf1, num1, bit32.lshift(num2, 3) + num3)
end

function module.writeBuffer(buf1: buffer, targetOffset: number, source: buffer, count: number): (buffer, number)
    buf1, targetOffset = module.writeVarInt(buf1, targetOffset, count)

    buf1 = reserveBuffer(buf1, targetOffset, count)
    buffer.copy(buf1, targetOffset, source, 0, count)

    return buf1, targetOffset + count
end

function module.writeString(buf1: buffer, num1: number, str1: string)
    return module.writeBuffer(buf1, num1, buffer.fromstring(str1), #str1)
end

module.json = {}

function module.json.serializeNumber(num1: number): number | string
    return if num1 == math.huge then "Infinity" elseif num1 == -math.huge then "-Infinity" elseif num1 == num1 then num1 else "NaN"
end

function module.json.deserializeNumber(arg1)
    if arg1 == "Infinity" then
        return math.huge
    elseif arg1 == "-Infinity" then
        return -math.huge
    elseif arg1 == "NaN" then
        return (0 / 0)
    end

    if typeof(arg1) ~= "string" then
        return arg1
    end

    local var1 = tonumber(arg1)
    assert(var1 ~= nil, "Number given that could not be parsed")
    return var1
end

function module.json.serializeBuffer(buf: buffer)
    return base64.encode(buffer.tostring(buf))
end

function module.json.deserializeBuffer(str1: string): buffer
    return buffer.fromstring(base64.decode(str1))
end

return module
