-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")
local OpenCloudService = game:GetService("OpenCloudService")
local RunService = game:GetService("RunService")

function InvalidArgumentError(message: string)
    return {
        StatusCode = 400,
        Body = HttpService:JSONEncode({ code = "INVALID_ARGUMENT", message = message })
    }
end

function verifyTable(arg1, arg2)
    if arg1 == nil then
        return nil
    elseif typeof(arg1) ~= "table" then
        return InvalidArgumentError(`Argument not a table: {arg2}.`)
    end

    return nil
end

function verifyNumber(arg1, arg2)
    if arg1 == nil then
        return nil
    elseif typeof(arg1) ~= "number" then
        return InvalidArgumentError(`Argument not a number: {arg2}.`)
    end

    return nil
end

function verifyString(arg1, arg2)
    if arg1 == nil then
        return nil
    elseif typeof(arg1) ~= "string" then
        return InvalidArgumentError(`Argument not a string: {arg2}.`)
    end

    return nil
end

function verifyEnum(arg1, arg2)
    if arg1 == nil then
        return nil
    elseif typeof(arg1) ~= "number" and typeof(arg1) ~= "string" then
        return InvalidArgumentError(`Argument not an enum: {arg2}.`)
    end

    return nil
end

function getApisUrl()
    local str1 = ContentProvider.BaseUrl:lower()
    local var1 = string.gsub(str1, "http:", "https:")
    return string.gsub(var1, "www", "apis")
end

function getUrlPrefix(arg1): string
    return if arg1 == nil or arg1["x-api-key"] == nil then if RunService:IsStudio() then "user" else "rcc" else ""
end

function verifyGetUniverseRequest(arg1, arg2)
    if arg1 == nil then
        return nil
    end

    local var1 = verifyTable(arg1, arg2)
    if var1 ~= nil then
        return var1
    end

    if arg1.path == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg2}.path.`)
    end
    local var2 = verifyString(arg1.path, `{arg2}.path`)
    return if var2 == nil then nil else var2
end

function getUniverseUrl(arg1, headers)
    if arg1.path == nil then
        return InvalidArgumentError("URL parameter provided was nil: getUniverseRequest.path.")
    end
    if string.match(arg1.path, "^universes/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: getUniverseRequest.path.")
    end

    return string.format("%s%s/cloud/v2/%s", getApisUrl(), getUrlPrefix(headers), tostring(arg1.path))
end

function getUniverse(arg1, headers)
    if arg1 == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyGetUniverseRequest(arg1, "getUniverseRequest")
    if var1 ~= nil then
        return var1
    end

    local url = getUniverseUrl(arg1, headers)
    if typeof(url) ~= "string" then
        return url
    end

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "GET", Headers = headers })
end

OpenCloudService:RegisterOpenCloud("v2", "GetUniverse", getUniverse)

function verifyTranslateTextRequest(input, arg1)
    if input == nil then
        return nil
    end

    local var1 = verifyTable(input, arg1)
    if var1 ~= nil then
        return var1
    end

    if input.path == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg1}.path.`)
    end
    local var2 = verifyString(input.path, `{arg1}.path`)
    if var2 ~= nil then
        return var2
    end

    if input.text == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg1}.text.`)
    end
    local var3 = verifyString(input.text, `{arg1}.text`)
    if var3 ~= nil then
        return var3
    end

    local var4 = verifyString(input.sourceLanguageCode, `{arg1}.sourceLanguageCode`)
    if var4 ~= nil then
        return var4
    end

    for value, value2 in input.targetLanguageCodes do
        local var5 = verifyString(value2, `{arg1}.targetLanguageCodes[{value}]`)
        if var5 ~= nil then
            return var5
        end
    end

    return nil
end

function translateTextUrl(input)
    if input.path == nil then
        return InvalidArgumentError("URL parameter provided was nil: translateTextRequest.path.")
    end
    if string.match(input.path, "^universes/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: translateTextRequest.path.")
    end

    return string.format("%s%s/cloud/v2/%s:translateText", getApisUrl(), getUrlPrefix(), tostring(input.path))
end

function translateText(input)
    if input == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyTranslateTextRequest(input, "translateTextRequest")
    if var1 ~= nil then
        return var1
    end

    local url = translateTextUrl(input)
    if typeof(url) ~= "string" then
        return url
    end

    local body = HttpService:JSONEncode(input)

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "POST", Body = body })
end

OpenCloudService:RegisterOpenCloud("v2", "TranslateText", translateText)

function verifyGenerateSpeechRequest(input, arg1)
    if input == nil then
        return nil
    end

    local var1 = verifyTable(input, arg1)
    if var1 ~= nil then
        return var1
    end

    if input.path == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg1}.path.`)
    end
    local var2 = verifyString(input.path, `{arg1}.path`)
    if var2 ~= nil then
        return var2
    end

    if input.text == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg1}.text.`)
    end
    local var3 = verifyString(input.text, `{arg1}.text`)
    if var3 ~= nil then
        return var3
    end

    local var4 = verifyGeneratedSpeechStyle(input.speechStyle, `{arg1}.speechStyle`)
    return if var4 == nil then nil else var4
end

function verifyGeneratedSpeechStyle(speechStyle, arg1)
    if speechStyle == nil then
        return nil
    end

    local var1 = verifyTable(speechStyle, arg1)
    if var1 ~= nil then
        return var1
    end

    local var2 = verifyString(speechStyle.voiceId, `{arg1}.voiceId`)
    if var2 ~= nil then
        return var2
    end

    local var3 = verifyNumber(speechStyle.pitch, `{arg1}.pitch`)
    if var3 ~= nil then
        return var3
    end

    local var4 = verifyNumber(speechStyle.speed, `{arg1}.speed`)
    return if var4 == nil then nil else var4
end

function generateSpeechUrl(input)
    if input.path == nil then
        return InvalidArgumentError("URL parameter provided was nil: generateSpeechRequest.path.")
    end
    if string.match(input.path, "^universes/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: generateSpeechRequest.path.")
    end

    return string.format("%s%s/cloud/v2/%s:generateSpeech", getApisUrl(), getUrlPrefix(), tostring(input.path))
end

function generateSpeech(input)
    if input == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyGenerateSpeechRequest(input, "generateSpeechRequest")
    if var1 ~= nil then
        return var1
    end

    local url = generateSpeechUrl(input)
    if typeof(url) ~= "string" then
        return url
    end

    local body = HttpService:JSONEncode(input)

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "POST", Body = body })
end

OpenCloudService:RegisterOpenCloud("v2", "GenerateSpeech", generateSpeech)

function verifyGenerateTextRequest(input, arg1)
    if input == nil then
        return nil
    end

    local var1 = verifyTable(input, arg1)
    if var1 ~= nil then
        return var1
    end

    if input.path == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg1}.path.`)
    end
    local var2 = verifyString(input.path, `{arg1}.path`)
    if var2 ~= nil then
        return var2
    end

    local var3 = verifyString(input.userPrompt, `{arg1}.userPrompt`)
    if var3 ~= nil then
        return var3
    end

    local var4 = verifyString(input.systemPrompt, `{arg1}.systemPrompt`)
    if var4 ~= nil then
        return var4
    end

    local var5 = verifyNumber(input.temperature, `{arg1}.temperature`)
    if var5 ~= nil then
        return var5
    end

    local var6 = verifyNumber(input.topP, `{arg1}.topP`)
    if var6 ~= nil then
        return var6
    end

    local var7 = verifyNumber(input.maxTokens, `{arg1}.maxTokens`)
    if var7 ~= nil then
        return var7
    end

    local var8 = verifyNumber(input.seed, `{arg1}.seed`)
    if var8 ~= nil then
        return var8
    end

    local var9 = verifyString(input.contextToken, `{arg1}.contextToken`)
    if var9 ~= nil then
        return var9
    end

    local var10 = verifyString(input.model, `{arg1}.model`)
    return if var10 == nil then nil else var10
end

function generateTextUrl(input)
    if input.path == nil then
        return InvalidArgumentError("URL parameter provided was nil: generateTextRequest.path.")
    end
    if string.match(input.path, "^universes/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: generateTextRequest.path.")
    end

    return string.format("%s%s/cloud/v2/%s:generateText", getApisUrl(), getUrlPrefix(), tostring(input.path))
end

function generateText(input)
    if input == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyGenerateTextRequest(input, "generateTextRequest")
    if var1 ~= nil then
        return var1
    end

    local url = generateTextUrl(input)
    if typeof(url) ~= "string" then
        return url
    end

    local body = HttpService:JSONEncode(input)

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "POST", Body = body })
end

OpenCloudService:RegisterOpenCloud("v2", "GenerateText", generateText)

function verifyGetPlaceRequest(arg1, arg2)
    if arg1 == nil then
        return nil
    end

    local var1 = verifyTable(arg1, arg2)
    if var1 ~= nil then
        return var1
    end

    if arg1.path == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg2}.path.`)
    end
    local var2 = verifyString(arg1.path, `{arg2}.path`)
    return if var2 == nil then nil else var2
end

function getPlaceUrl(arg1, headers)
    if arg1.path == nil then
        return InvalidArgumentError("URL parameter provided was nil: getPlaceRequest.path.")
    end
    if string.match(arg1.path, "^universes/([^/]+)/places/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: getPlaceRequest.path.")
    end

    return string.format("%s%s/cloud/v2/%s", getApisUrl(), getUrlPrefix(headers), tostring(arg1.path))
end

function getPlace(arg1, headers)
    if arg1 == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyGetPlaceRequest(arg1, "getPlaceRequest")
    if var1 ~= nil then
        return var1
    end

    local url = getPlaceUrl(arg1, headers)
    if typeof(url) ~= "string" then
        return url
    end

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "GET", Headers = headers })
end

OpenCloudService:RegisterOpenCloud("v2", "GetPlace", getPlace)

function verifyGetGroupRequest(arg1, arg2)
    if arg1 == nil then
        return nil
    end

    local var1 = verifyTable(arg1, arg2)
    if var1 ~= nil then
        return var1
    end

    if arg1.path == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg2}.path.`)
    end
    local var2 = verifyString(arg1.path, `{arg2}.path`)
    return if var2 == nil then nil else var2
end

function getGroupUrl(arg1, headers)
    if arg1.path == nil then
        return InvalidArgumentError("URL parameter provided was nil: getGroupRequest.path.")
    end
    if string.match(arg1.path, "^groups/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: getGroupRequest.path.")
    end

    return string.format("%s%s/cloud/v2/%s", getApisUrl(), getUrlPrefix(headers), tostring(arg1.path))
end

function getGroup(arg1, headers)
    if arg1 == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyGetGroupRequest(arg1, "getGroupRequest")
    if var1 ~= nil then
        return var1
    end

    local url = getGroupUrl(arg1, headers)
    if typeof(url) ~= "string" then
        return url
    end

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "GET", Headers = headers })
end

OpenCloudService:RegisterOpenCloud("v2", "GetGroup", getGroup)

function verifyListInventoryItemsRequest(arg1, arg2)
    if arg1 == nil then
        return nil
    end

    local var1 = verifyTable(arg1, arg2)
    if var1 ~= nil then
        return var1
    end

    if arg1.parent == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg2}.parent.`)
    end
    local var2 = verifyString(arg1.parent, `{arg2}.parent`)
    if var2 ~= nil then
        return var2
    end

    local var3 = verifyNumber(arg1.maxPageSize, `{arg2}.maxPageSize`)
    if var3 ~= nil then
        return var3
    end

    local var4 = verifyString(arg1.pageToken, `{arg2}.pageToken`)
    if var4 ~= nil then
        return var4
    end

    local var5 = verifyString(arg1.filter, `{arg2}.filter`)
    return if var5 == nil then nil else var5
end

function listInventoryItemsUrl(arg1, headers)
    if arg1.parent == nil then
        return InvalidArgumentError("URL parameter provided was nil: listInventoryItemsRequest.parent.")
    end
    if string.match(arg1.parent, "^users/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: listInventoryItemsRequest.parent.")
    end

    local var1 = string.format("%s%s/cloud/v2/%s/inventory-items", getApisUrl(), getUrlPrefix(headers), tostring(arg1.parent))

    if arg1.maxPageSize == nil and arg1.pageToken == nil and arg1.filter == nil then
        return var1
    end

    local tbl1 = {}
    if arg1.maxPageSize ~= nil then
        table.insert(tbl1, string.format("maxPageSize=%s", tostring(arg1.maxPageSize)))
    end
    if arg1.pageToken ~= nil then
        table.insert(tbl1, string.format("pageToken=%s", tostring(arg1.pageToken)))
    end
    if arg1.filter ~= nil then
        table.insert(tbl1, string.format("filter=%s", tostring(arg1.filter)))
    end

    return string.format("%s?%s", var1, table.concat(tbl1, "&"))
end

function listInventoryItems(arg1, headers)
    if arg1 == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyListInventoryItemsRequest(arg1, "listInventoryItemsRequest")
    if var1 ~= nil then
        return var1
    end

    local url = listInventoryItemsUrl(arg1, headers)
    if typeof(url) ~= "string" then
        return url
    end

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "GET", Headers = headers })
end

OpenCloudService:RegisterOpenCloud("v2", "ListInventoryItems", listInventoryItems)

function verifyListGroupMembershipsRequest(arg1, arg2)
    if arg1 == nil then
        return nil
    end

    local var1 = verifyTable(arg1, arg2)
    if var1 ~= nil then
        return var1
    end

    if arg1.parent == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg2}.parent.`)
    end
    local var2 = verifyString(arg1.parent, `{arg2}.parent`)
    if var2 ~= nil then
        return var2
    end

    local var3 = verifyNumber(arg1.maxPageSize, `{arg2}.maxPageSize`)
    if var3 ~= nil then
        return var3
    end

    local var4 = verifyString(arg1.pageToken, `{arg2}.pageToken`)
    if var4 ~= nil then
        return var4
    end

    local var5 = verifyString(arg1.filter, `{arg2}.filter`)
    return if var5 == nil then nil else var5
end

function listGroupMembershipsUrl(arg1, headers)
    if arg1.parent == nil then
        return InvalidArgumentError("URL parameter provided was nil: listGroupMembershipsRequest.parent.")
    end
    if string.match(arg1.parent, "^groups/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: listGroupMembershipsRequest.parent.")
    end

    local var1 = string.format("%s%s/cloud/v2/%s/memberships", getApisUrl(), getUrlPrefix(headers), tostring(arg1.parent))

    if arg1.maxPageSize == nil and arg1.pageToken == nil and arg1.filter == nil then
        return var1
    end

    local tbl1 = {}
    if arg1.maxPageSize ~= nil then
        table.insert(tbl1, string.format("maxPageSize=%s", tostring(arg1.maxPageSize)))
    end
    if arg1.pageToken ~= nil then
        table.insert(tbl1, string.format("pageToken=%s", tostring(arg1.pageToken)))
    end
    if arg1.filter ~= nil then
        table.insert(tbl1, string.format("filter=%s", tostring(arg1.filter)))
    end

    return string.format("%s?%s", var1, table.concat(tbl1, "&"))
end

function listGroupMemberships(arg1, headers)
    if arg1 == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyListGroupMembershipsRequest(arg1, "listGroupMembershipsRequest")
    if var1 ~= nil then
        return var1
    end

    local url = listGroupMembershipsUrl(arg1, headers)
    if typeof(url) ~= "string" then
        return url
    end

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "GET", Headers = headers })
end

OpenCloudService:RegisterOpenCloud("v2", "ListGroupMemberships", listGroupMemberships)

function verifyGetOperationRequest(arg1, arg2)
    if arg1 == nil then
        return nil
    end

    local var1 = verifyTable(arg1, arg2)
    if var1 ~= nil then
        return var1
    end

    if arg1.path == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg2}.path.`)
    end
    local var2 = verifyString(arg1.path, `{arg2}.path`)
    return if var2 == nil then nil else var2
end

function getOperationUrl(arg1, headers)
    if arg1.path == nil then
        return InvalidArgumentError("URL parameter provided was nil: getOperationRequest.path.")
    end
    if string.match(arg1.path, "^users/([^/]+)/operations/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: getOperationRequest.path.")
    end

    return string.format("%s%s/cloud/v2/%s", getApisUrl(), getUrlPrefix(headers), tostring(arg1.path))
end

function getOperation(arg1, headers)
    if arg1 == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyGetOperationRequest(arg1, "getOperationRequest")
    if var1 ~= nil then
        return var1
    end

    local url = getOperationUrl(arg1, headers)
    if typeof(url) ~= "string" then
        return url
    end

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "GET", Headers = headers })
end

OpenCloudService:RegisterOpenCloud("v2", "GetOperation", getOperation)

function verifyGenerateUserThumbnailRequest(arg1, arg2)
    if arg1 == nil then
        return nil
    end

    local var1 = verifyTable(arg1, arg2)
    if var1 ~= nil then
        return var1
    end

    if arg1.path == nil then
        return InvalidArgumentError(`Required argument was not provided: {arg2}.path.`)
    end
    local var2 = verifyString(arg1.path, `{arg2}.path`)
    if var2 ~= nil then
        return var2
    end

    local var3 = verifyNumber(arg1.size, `{arg2}.size`)
    if var3 ~= nil then
        return var3
    end

    local var4 = verifyEnum(arg1.format, `{arg2}.format`)
    if var4 ~= nil then
        return var4
    end

    local var5 = verifyEnum(arg1.shape, `{arg2}.shape`)
    return if var5 == nil then nil else var5
end

function generateUserThumbnailUrl(arg1, headers)
    if arg1.path == nil then
        return InvalidArgumentError("URL parameter provided was nil: generateUserThumbnailRequest.path.")
    end
    if string.match(arg1.path, "^users/([^/]+)$") == nil then
        return InvalidArgumentError("URL parameter was not formatted correctly: generateUserThumbnailRequest.path.")
    end

    local var1 = string.format("%s%s/cloud/v2/%s:generateThumbnail", getApisUrl(), getUrlPrefix(headers), tostring(arg1.path))

    if arg1.size == nil and arg1.format == nil and arg1.shape == nil then
        return var1
    end

    local tbl1 = {}
    if arg1.size ~= nil then
        table.insert(tbl1, string.format("size=%s", tostring(arg1.size)))
    end
    if arg1.format ~= nil then
        table.insert(tbl1, string.format("format=%s", tostring(arg1.format)))
    end
    if arg1.shape ~= nil then
        table.insert(tbl1, string.format("shape=%s", tostring(arg1.shape)))
    end

    return string.format("%s?%s", var1, table.concat(tbl1, "&"))
end

function generateUserThumbnail(arg1, headers)
    if arg1 == nil then
        return InvalidArgumentError("Request provided was nil.")
    end

    local var1 = verifyGenerateUserThumbnailRequest(arg1, "generateUserThumbnailRequest")
    if var1 ~= nil then
        return var1
    end

    local url = generateUserThumbnailUrl(arg1, headers)
    if typeof(url) ~= "string" then
        return url
    end

    return OpenCloudService:HttpRequestAsync({ Url = url, Request_Type = "GET", Headers = headers })
end

OpenCloudService:RegisterOpenCloud("v2", "GenerateUserThumbnail", generateUserThumbnail)

OpenCloudService:RegistrationComplete()
