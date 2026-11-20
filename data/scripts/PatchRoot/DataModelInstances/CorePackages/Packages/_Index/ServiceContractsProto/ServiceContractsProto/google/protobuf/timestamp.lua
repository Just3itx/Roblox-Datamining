-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local Timestamp = {}
Timestamp.__index = Timestamp

function Timestamp.new(tbl3)
    return (setmetatable({
        seconds = if tbl3 == nil or tbl3.seconds == nil then 0 else tbl3.seconds,
        nanos = if tbl3 == nil or tbl3.nanos == nil then 0 else tbl3.nanos
    }, Timestamp))
end

function Timestamp:encode(): buffer
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

function Timestamp.decode(buf1: buffer)
    local var1 = Timestamp.new()
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

local function serializeFractionalNanos(nanos: number): string
    if nanos % 1000000 == 0 then
        return string.format(".%03d", nanos)
    elseif nanos % 1000 == 0 then
        return string.format(".%06d", nanos)
    end
    return string.format(".%09d", nanos)
end

local function deserializeFractionalNanos(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = assert(tonumber(str1), "Invalid nanos string received, couldn't turn into a number")
    for i = #str1 + 1, 9 do
        var1 += 10 ^ (i - 1)
    end

    return var1
end

function Timestamp:jsonEncode(): string
    if self.seconds > 253402300799 then
        error("Invalid timestamp provided: years after 9999 are not supported")
    end

    if self.seconds < -62135596800 then
        error("Invalid timestamp provided: years before 0001 are not supported")
    end

    local var1 = os.date("!*t", self.seconds or 0)
    if var1 == nil then
        error("Invalid timestamp provided: exceeded supported timestamp range on this platform")
    end

    return string.format(
        "%04d-%02d-%02dT%02d:%02d:%02d%sZ",
        var1.year,
        var1.month,
        var1.day,
        var1.hour,
        var1.min,
        var1.sec,
        if self.nanos == 0 then "" else serializeFractionalNanos(self.nanos)
    )
end

function Timestamp.jsonDecode(arg1)
    local var1, var2, var3, var4, var5, var6, var7 = string.match(arg1, "^([0-9]+)-([0-9]+)-([0-9]+)T([0-9]+):([0-9]+):([0-9]+)(.*)Z$")

    if var1 == nil or var2 == nil or var3 == nil or var4 == nil or var5 == nil or var6 == nil or var7 == nil then
        error("Invalid timestamp provided")
    end

    local var8

    if #var7 == 0 then
        var8 = 0
    else
        local var9 = string.match(var7, "^%.([0-9]+)$")
        if var9 == nil then
            error("Invalid nanoseconds provided in timestamp: `" .. var7 .. "`")
        end

        var8 = deserializeFractionalNanos(var9)
    end

    local seconds = os.time({
        year = assert(tonumber(var1), "Invalid formatted year"),
        month = assert(tonumber(var2), "Invalid formatted month"),
        day = assert(tonumber(var3), "Invalid formatted day"),
        hour = assert(tonumber(var4), "Invalid formatted hour"),
        min = assert(tonumber(var5), "Invalid formatted min"),
        sec = assert(tonumber(var6), "Invalid formatted sec")
    })

    return Timestamp.new({ seconds = seconds, nanos = var8 })
end

Timestamp.descriptor = { name = "Timestamp", fullName = "google.protobuf.Timestamp" }

tbl1.Timestamp = Timestamp

typeRegistry.default:register(tbl1.Timestamp)

return {
    Timestamp = tbl1.Timestamp
}
