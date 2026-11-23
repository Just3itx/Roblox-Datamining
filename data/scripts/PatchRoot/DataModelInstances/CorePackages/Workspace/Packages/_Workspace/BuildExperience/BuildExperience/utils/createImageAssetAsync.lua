-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local AssetService = game:GetService("AssetService")
local Players = game:GetService("Players")

local HttpClient = require(BuildExperienceParent.HttpClient)
local Promise = require(BuildExperienceParent.Promise)

local getAssetUserAuthStore = require(BuildExperienceParent.DataHydration.AssetUserAuth).getAssetUserAuthStore

local debug2 = require(BuildExperienceParent.DataHydration.CreatorAgentChat).debug

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function cropToSquareAsync(uri: string)
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            return AssetService:CreateEditableImageAsync(Content.fromUri(uri))
        end)

        if not (success and result) then
            callback2(`Failed to create EditableImage: {tostring(result)}`)
            return
        end

        local resultSize = result.Size
        local resultSizeX = resultSize.X
        local resultSizeY = resultSize.Y
        local num1 = math.min(resultSizeX, resultSizeY)
        local x = math.floor((resultSizeX - num1) / 2)
        local y = math.floor((resultSizeY - num1) / 2)

        local buf = result:ReadPixelsBuffer(Vector2.new(x, y), Vector2.new(num1, num1))
        result:Destroy()

        local num2 = num1 * num1 * 4
        local size = num2 + 54
        local buffer2 = buffer.create(size)

        buffer.writeu8(buffer2, 0, 66)
        buffer.writeu8(buffer2, 1, 77)
        buffer.writeu32(buffer2, 2, size)
        buffer.writeu32(buffer2, 6, 0)
        buffer.writeu32(buffer2, 10, 54)

        buffer.writeu32(buffer2, 14, 40)
        buffer.writei32(buffer2, 18, num1)
        buffer.writei32(buffer2, 22, -num1)
        buffer.writeu16(buffer2, 26, 1)
        buffer.writeu16(buffer2, 28, 32)
        buffer.writeu32(buffer2, 30, 0)
        buffer.writeu32(buffer2, 34, num2)
        buffer.writeu32(buffer2, 38, 2835)
        buffer.writeu32(buffer2, 42, 2835)
        buffer.writeu32(buffer2, 46, 0)
        buffer.writeu32(buffer2, 50, 0)

        for i = 0, num1 * num1 - 1 do
            local offset = i * 4
            local offset2 = i * 4 + 54
            local num3 = buffer.readu8(buf, offset)
            local num4 = buffer.readu8(buf, offset + 1)
            local num5 = buffer.readu8(buf, offset + 2)
            local num6 = buffer.readu8(buf, offset + 3)
            buffer.writeu8(buffer2, offset2, num5)
            buffer.writeu8(buffer2, offset2 + 1, num4)
            buffer.writeu8(buffer2, offset2 + 2, num3)
            buffer.writeu8(buffer2, offset2 + 3, num6)
        end

        callback(buffer.tostring(buffer2))
    end)
end

local function createImageAssetAsync(url: string, displayName: string?, cropSquare: boolean?, tbl1)
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return Promise.reject("No local player")
    end

    local function getImageContent()
        if cropSquare then
            return cropToSquareAsync(url)
        end
        local var1 = fetch({
            method = "GET",
            url = url,
            analyticsKey = "build-experience.download-thumbnail",
            responseEncoding = "protobuf",
            decode = function(buf1: buffer): buffer
                return buf1
            end
        })
        return asPromise(var1):andThen(function(buf: buffer): string
            return buffer.tostring(buf)
        end)
    end

    debug2.log("info", "create_image_asset starting", { cropSquare = cropSquare })

    return getImageContent():andThen(function(str1: string)
        local str2 = if cropSquare then "image/bmp" else "image/png"
        local assetUserAuthStore = getAssetUserAuthStore()

        local tbl2 = {
            displayName = displayName or "Game Thumbnail"
        }

        if tbl1 and tbl1.creatorType == "Group" then
            tbl2.groupId = tostring(tbl1.creatorTargetId)
        else
            tbl2.userId = tostring(localPlayer.UserId)
        end

        return assetUserAuthStore.createImageAsset(str1, str2, tbl2)
    end):andThen(function(arg1)
        return getAssetUserAuthStore().pollUntilDone(arg1)
    end):andThen(function(arg1)
        if typeof(arg1) == "table" and arg1.status == "timed_out" then
            return Promise.reject("Operation did not complete in time")
        end
        if arg1.status == "done" then
            arg1 = arg1.operation
        end

        local var1 = arg1.response or arg1
        debug2.log("info", "create_image_asset succeeded", { assetId = var1.assetId })
        return {
            assetId = var1.assetId
        }
    end)
end
return createImageAssetAsync
