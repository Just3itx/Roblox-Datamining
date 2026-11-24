-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Promise = require(GenericAbuseReportingParent.Promise)
local Url = require(GenericAbuseReportingParent.Http).Url

local bool1 = game:DefineFastFlag("RemoveDuplicatesPlaceMediaAssets", false)

return function(arg1, str1: string)
    local tbl1 = {}
    local tbl2 = ({})

    return arg1(string.format("%sv2/games/%s/media", Url.GAME_URL, str1), "GET"):andThen(function(arg2)
        if not arg2 or not arg2.responseBody or not arg2.responseBody.data then
            return
        end

        for _, value in ipairs(arg2.responseBody.data) do
            if not value.imageId then
                continue
            end

            if bool1 then
                local str2 = tostring(value.imageId)
                if not tbl2[str2] then
                    tbl2[str2] = true
                    table.insert(tbl1, str2)
                end
            else
                table.insert(tbl1, tostring(value.imageId))
            end
        end
    end):finally(function()
        return Promise.resolve(tbl1)
    end)
end
