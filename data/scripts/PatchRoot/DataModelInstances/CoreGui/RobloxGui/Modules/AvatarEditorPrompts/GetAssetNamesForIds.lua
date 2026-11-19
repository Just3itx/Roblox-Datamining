-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local AvatarEditorService = game:GetService("AvatarEditorService")

local Promise = require(CorePackages.Packages.Promise)

return function(itemIds)
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            return AvatarEditorService:GetBatchItemDetailsAsync(itemIds, Enum.AvatarItemType.Asset)
        end)

        if not success then
            callback2()

            return
        end

        local tbl1 = {}

        for _, value in ipairs(result) do
            tbl1[value.Id] = value.Name
        end

        callback(tbl1)
    end)
end
