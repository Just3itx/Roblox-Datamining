-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Promise = require(AuthCommonParent.Promise)

local GetGameMedia = require(AuthCommon.Http.Requests.GetGameMedia)

function FetchGameMedia(arg1, str1: string)
    assert(typeof(str1) == "string", "universeId must be a string")
    assert(#str1 > 0, "universeId must be a non-empty string")

    return GetGameMedia(arg1, str1):andThen(function(arg2)
        if not (arg2 and arg2.responseBody) then
            return Promise.reject()
        end

        local data = arg2.responseBody.data
        if data == nil then
            return Promise.reject()
        end

        local tbl1 = {}
        for _, value in ipairs(data) do
            table.insert(tbl1, { id = value.id, assetTypeId = value.assetTypeId, imageId = value.imageId })
        end
        return Promise.resolve(tbl1)
    end)
end

return FetchGameMedia
