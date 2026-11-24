-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CaptureService = game:GetService("CaptureService")

local scriptParentParent = script.Parent.Parent

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local _Types = require(scriptParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

function formatBytes(num1: number): string
    local tbl1 = {
        "Bytes",
        "KB",
        "MB",
        "GB",
        "TB"
    }

    local num2 = math.floor(math.log(num1) / 6.931471805599453)
    local num3 = num1 / math.pow(1024, num2)
    local str1

    if num2 <= 2 then
        num3 = math.round(num3)
        str1 = "%d%s"
    else
        str1 = "%.2f%s"
    end

    if not tbl1[num2 + 1] then
        return ""
    end

    return string.format(str1, num3, tbl1[num2 + 1])
end

local function getCaptureStorageUsage(tbl1)
    if #tbl1 == 0 then
        return
    end

    local pathArr = {}
    if not FFlagEnableCapturesGalleryRetrievalCoreScript then
        for _, value in ipairs(tbl1) do
            if not FFlagUseRbxstorageInGallery or value.type ~= CaptureType.Video then
                table.insert(pathArr, value.filePath)
            end
        end
    end

    local _success, result = pcall(function(): number
        return CaptureService:GetCaptureStorageSizeAsync(pathArr)
    end)

    return formatBytes(result)
end

return getCaptureStorageUsage
