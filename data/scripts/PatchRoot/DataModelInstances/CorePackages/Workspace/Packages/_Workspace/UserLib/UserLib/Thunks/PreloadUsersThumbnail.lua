-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local UserLibParent = UserLib.Parent

local Cryo = require(UserLibParent.Cryo)

local PromiseUtilities = require(UserLibParent.AppCommonLib).Utils.PromiseUtilities
local _Utils = require(UserLib.Utils)

local Promise = require(UserLibParent.Promise)

local Constants = require(UserLib.Utils.Constants)
local getRbxthumbWithTypeSizeAndOptions = require(UserLib.Utils).getRbxthumbWithTypeSizeAndOptions

local function subdivideEntries(tbl1, num1: number)
    local result = {}
    for i = 1, #tbl1, num1 do
        table.insert(result, (Cryo.List.getRange(tbl1, i, i + num1 - 1)))
    end
    return result
end

local function makePreloadAsyncPromise(tbl1, tbl2, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (Promise.new(function(callback, _)
        local tbl3 = {}
        local tbl4 = ({})
        for _, value in tbl1 do
            tbl4[value] = {}
            for _, value2 in tbl2 do
                tbl4[value][value2.thumbnailType] = tbl4[value][value2.thumbnailType] or {}

                local var1 = Constants.RbxThumbnailSizeToNumberSize[value2.thumbnailSize]

                local var2 = Constants.RbxAvatarThumbnailTypeFromEnumToRbxthumbType[value2.thumbnailType]
                local rbxthumbWithTypeSizeAndOptions = getRbxthumbWithTypeSizeAndOptions(value, var2, var1)
                tbl4[value][value2.thumbnailType][value2.thumbnailSize] = rbxthumbWithTypeSizeAndOptions
                table.insert(tbl3, rbxthumbWithTypeSizeAndOptions)
            end
        end

        (arg1 or game:GetService("ContentProvider")):PreloadAsync(tbl3)

        callback()
    end))
end
return function(tbl1, tbl2, arg1)
    return function(_)
        local tbl3 = {}

        local tbl4 = subdivideEntries(tbl1, 100)

        for _, value in pairs(tbl4) do
            table.insert(tbl3, (makePreloadAsyncPromise(value, tbl2, arg1)))
        end
        return PromiseUtilities.Batch(tbl3)
    end
end
