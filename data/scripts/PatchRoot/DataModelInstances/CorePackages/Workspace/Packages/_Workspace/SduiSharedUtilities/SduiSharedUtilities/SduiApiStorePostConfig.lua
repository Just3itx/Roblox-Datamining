-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SduiApiStorePostConfigContentType = { Json = "Json", Proto = "Proto" }

local tbl2 = {
    [SduiApiStorePostConfigContentType.Json] = "application/json",
    [SduiApiStorePostConfigContentType.Proto] = "application/x-protobuf"
}

return {
    SduiApiStorePostConfigContentType = SduiApiStorePostConfigContentType,
    getBodyFromPostConfig = function(tbl3)
        if tbl3.body then
            if tbl3.contentType == SduiApiStorePostConfigContentType.Json then
                return HttpService:JSONEncode(tbl3.body)
            end

            if tbl3.contentType == SduiApiStorePostConfigContentType.Proto then
                return buffer.tostring(tbl3.protoMessage.encode(tbl3.body))
            end
        end

        return nil
    end,
    getContentTypeHeaderFromPostConfig = function(tbl3)
        return if tbl3.contentType then tbl2[tbl3.contentType] else nil
    end
}
