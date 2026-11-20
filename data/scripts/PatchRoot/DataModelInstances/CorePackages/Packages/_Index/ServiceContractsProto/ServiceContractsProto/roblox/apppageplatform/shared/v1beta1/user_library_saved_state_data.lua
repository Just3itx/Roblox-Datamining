-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

local UserLibrarySavedStateData = {}
UserLibrarySavedStateData.__index = UserLibrarySavedStateData

function UserLibrarySavedStateData.new(tbl3)
    return (setmetatable({
        is_saved = not (tbl3 == nil or tbl3.is_saved == nil) and tbl3.is_saved,
        collection_ids = (tbl3 == nil or tbl3.collection_ids == nil) and {} or tbl3.collection_ids
    }, UserLibrarySavedStateData))
end

function UserLibrarySavedStateData:encode(): buffer
    local buffer2 = buffer.create(0)
    local num1 = 0

    if self.is_saved then
        local var1, var2 = proto.writeTag(buffer2, num1, 1, proto.wireTypes.varint)
        buffer2, num1 = proto.writeVarInt(var1, var2, if self.is_saved then 1 else 0)
    end

    if self.collection_ids ~= nil and #self.collection_ids > 0 then
        for _, collectionId in self.collection_ids do
            local var1, var2 = proto.writeTag(buffer2, num1, 2, proto.wireTypes.lengthDelimited)
            buffer2, num1 = proto.writeString(var1, var2, collectionId)
        end
    end

    local buffer3 = buffer.create(num1)
    buffer.copy(buffer3, 0, buffer2, 0, num1)
    return buffer3
end

function UserLibrarySavedStateData.decode(buf1: buffer)
    local var1 = UserLibrarySavedStateData.new()
    local num1 = 0

    while num1 < buffer.len(buf1) do
        local var2, var3
        var2, var3, num1 = proto.readTag(buf1, num1)

        if var3 == proto.wireTypes.varint then
            if var2 == 1 then
                local var4
                var4, num1 = proto.readVarInt(buf1, num1)
                var1.is_saved = var4 ~= 0
            else
                local _
                _, num1 = proto.readVarInt(buf1, num1)
            end
        elseif var3 == proto.wireTypes.lengthDelimited then
            if var2 == 2 then
                local var4
                var4, num1 = proto.readBuffer(buf1, num1)
                table.insert(var1.collection_ids, buffer.tostring(var4))
            else
                local var4, var5 = proto.readVarInt(buf1, num1)

                num1 = var5 + var4
            end
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

function UserLibrarySavedStateData:jsonEncode()
    local result = {}

    if self.is_saved then
        result.isSaved = self.is_saved
    end

    if self.collection_ids ~= nil and #self.collection_ids > 0 then
        local collectionIds = {}
        for _, collectionId in self.collection_ids do
            table.insert(collectionIds, collectionId)
        end
        result.collectionIds = collectionIds
    end

    return result
end

function UserLibrarySavedStateData:jsonDecode()
    local var1 = UserLibrarySavedStateData.new()

    if self.is_saved ~= nil then
        var1.is_saved = self.is_saved
    end

    if self.isSaved ~= nil then
        var1.is_saved = self.isSaved
    end

    if self.collection_ids ~= nil then
        local collectionIds = {}
        for _, collectionId in self.collection_ids do
            table.insert(collectionIds, collectionId)
        end

        var1.collection_ids = collectionIds
    end

    if self.collectionIds ~= nil then
        local collectionIds = {}
        for _, collectionId in self.collectionIds do
            table.insert(collectionIds, collectionId)
        end

        var1.collection_ids = collectionIds
    end

    return var1
end

UserLibrarySavedStateData.descriptor = {
    name = "UserLibrarySavedStateData",
    fullName = "roblox.apppageplatform.shared.v1beta1.UserLibrarySavedStateData"
}

tbl1.UserLibrarySavedStateData = UserLibrarySavedStateData

typeRegistry.default:register(tbl1.UserLibrarySavedStateData)

return {
    UserLibrarySavedStateData = tbl1.UserLibrarySavedStateData
}
