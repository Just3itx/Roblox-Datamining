-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")
local OpenCloudService = game:GetService("OpenCloudService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

function returnInvalidArgumentError(message: string)
    return {
        StatusCode = 400,
        Body = HttpService:JSONEncode({ code = "INVALID_ARGUMENT", message = message })
    }
end

function verifyPlayerOnServer(user)
    local var1 = verifyPlayer(user)
    if var1 ~= nil then
        return var1
    end

    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        if player.UserId == user.UserId then
            return nil
        end
    end

    return returnInvalidArgumentError("Player not found on server.")
end

function verifyPlayer(user)
    if typeof(user) ~= "Instance" or user.ClassName ~= "Player" then
        return returnInvalidArgumentError("user argument not a Player instance.")
    end
    return nil
end

function verifyString(arg1)
    if typeof(arg1) ~= "string" then
        return returnInvalidArgumentError("Argument not a string.")
    end
    return nil
end

function verifyNumber(maxPageSize)
    if typeof(maxPageSize) ~= "number" then
        return returnInvalidArgumentError("Argument not a number.")
    end
    return nil
end

function getUrlPrefix(): string
    return if RunService:IsStudio() then "user" else "rcc"
end

function createListInventoryItemsUrl(userId: number, maxPageSize: number?, pageToken: string?, filter: string?): string
    local str1 = ContentProvider.BaseUrl:lower()
    local var1 = string.gsub(str1, "http:", "https:")
    local var2 = string.gsub(var1, "www", "apis")
    local str2 = string.format("%s%s/cloud/v2/users/%d/inventory-items", var2, getUrlPrefix(), userId)

    if maxPageSize == nil and pageToken == nil and filter == nil then
        return str2
    end

    local tbl1 = {}

    if maxPageSize ~= nil then
        table.insert(tbl1, string.format("maxPageSize=%d", maxPageSize))
    end
    if pageToken ~= nil then
        table.insert(tbl1, string.format("pageToken=%s", pageToken))
    end
    if filter ~= nil then
        table.insert(tbl1, string.format("filter=%s", filter))
    end
    return string.format("%s?%s", str2, table.concat(tbl1, "&"))
end

function listInventoryItems(arg1)
    if arg1.user == nil then
        return returnInvalidArgumentError("user argument was not provided.")
    end

    local var1 = verifyPlayerOnServer(arg1.user)
    if var1 ~= nil then
        return var1
    end

    if arg1.maxPageSize ~= nil then
        local var2 = verifyNumber(arg1.maxPageSize)
        if var2 ~= nil then
            return var2
        end
    end

    if arg1.pageToken ~= nil then
        local var2 = verifyString(arg1.pageToken)
        if var2 ~= nil then
            return var2
        end
    end

    if arg1.filter ~= nil then
        local var2 = verifyString(arg1.filter)
        if var2 ~= nil then
            return var2
        end
    end

    return OpenCloudService:HttpRequestAsync({
        Url = createListInventoryItemsUrl(arg1.user.UserId, arg1.maxPageSize, arg1.pageToken, arg1.filter),
        Request_Type = "GET"
    })
end
OpenCloudService:RegisterOpenCloud("v2", "listInventoryItems", listInventoryItems)
OpenCloudService:RegistrationComplete()
