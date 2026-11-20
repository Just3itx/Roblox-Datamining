-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local Duration = {}
Duration.__index = Duration

function Duration.new(tbl3)
    return (setmetatable({
        seconds = if tbl3 == nil or tbl3.seconds == nil then 0 else tbl3.seconds,
        nanos = if tbl3 == nil or tbl3.nanos == nil then 0 else tbl3.nanos
    }, Duration))
end

function Duration:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.seconds ~= nil and self.seconds ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.seconds)
    end

    if self.nanos ~= nil and self.nanos ~= 0 then
        local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, self.nanos)
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function Duration.decode(buf1: buffer)
    local var1 = Duration.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarIntI64(buf1, num1)
                var1.seconds = var4
            elseif var2 == 2 then
                local var4
                var4, num1 = proto.readVarIntI32(buf1, num1)
                var1.nanos = var4
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            local var4, var5 = proto.readVarInt(buf1, num1)

            num1 = var5 + var4
        elseif var3 == proto.wireTypes.i32 then
            local _
            _, num1 = proto.readFixed32(buf1, num1)
        elseif var3 == proto.wireTypes.i64 then
            local _
            _, num1 = proto.readFixed64(buf1, num1)
        else
            error("Unsupported wire type: " .. var3)
        end
    end

    return var1
end

local function serializeFractionalNanos(num1: number): string
    num1 *= math.sign(num1)

    local str1 = tostring(num1)
    local num2 = 9 - #str1
    local str2 = string.rep("0", num2)

    while str1:sub(-1) == "0" do
        str1 = str1:sub(1, -2)
    end

    return `.{str2}{str1}s`
end

local function deserializeFractionalNanos(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = assert(tonumber(str1), "Invalid nanos string received, couldn't turn into a number")
    for _ = #str1 + 1, 9 do
        var1 *= 10
    end

    return var1
end

function Duration:jsonEncode(): string
    assert(self.seconds == nil or self.seconds >= -315576000000 and self.seconds <= 315576000000, "Seconds out of range")

    assert(self.nanos == nil or self.nanos >= -999999999 and self.nanos <= 999999999, "Nanoseconds out of range")

    if self.nanos == nil or self.nanos == 0 or self.nanos % 1000000000 == 0 then
        return `{self.seconds}s`
    end

    local str1 = if self.seconds == 0 and math.sign(self.nanos) == -1 then "-" else ""
    return string.format("%s%d%s", str1, self.seconds or 0, (serializeFractionalNanos(self.nanos)))
end

function Duration.jsonDecode(arg1)
    local var1 = string.match(arg1, "^([%-0-9]+)s$")

    local num1 = 0
    local var2

    if var1 ~= nil then
        var2 = assert(
            tonumber(var1),
            "Invalid duration string received--was formatted as just having seconds, but wasn't a properly formatted int"
        )
    else
        local var3, var4 = string.match(arg1, "^([%-0-9]+)%.([0-9]+)s$")
        assert(var3 ~= nil, "Invalid duration string received--seconds provided are invalid")
        assert(var4 ~= nil, "Invalid duration string received--nanos provided are invalid")

        var2 = assert(tonumber(var3), "Invalid duration string received--seconds provided are invalid")
        num1 = deserializeFractionalNanos(var4) * (if var3:sub(1, 1) == "-" then -1 else 1)
    end

    if var2 > 315576000000 then
        error(`Duration seconds cannot exceed {315576000000}`)
    elseif var2 < -315576000000 then
        error(`Duration seconds cannot be less than {-315576000000}`)
    end

    return Duration.new({ seconds = var2, nanos = num1 })
end

Duration.descriptor = { name = "Duration", fullName = "google.protobuf.Duration" }

tbl1.Duration = Duration

typeRegistry.default:register(tbl1.Duration)

return {
    Duration = tbl1.Duration
}
