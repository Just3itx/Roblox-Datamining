-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Http = require(AppChatParent.Http)
local HttpClient = require(AppChatParent.HttpClient)
local _ShareLinksNetworking = require(AppChatParent.ShareLinksNetworking)

local FFlagAppChatPlusReferralAssetCard = require(AppChat.Flags.FFlagAppChatPlusReferralAssetCard)

local url = Http.Url.APIS_URL .. "deeplinks/v2/resolve"

local function decodeResolvedShareLink(arg1)
    if type(arg1) ~= "table"
        or type(arg1.linkType) ~= "string"
        or type(arg1.targetId) ~= "string"
        or type(arg1.status) ~= "string"
    then
        error("Malformed deeplinks/v2/resolve response")
    end

    if FFlagAppChatPlusReferralAssetCard then
        if arg1.customData ~= nil and type(arg1.customData) ~= "string" then
            error("Malformed deeplinks/v2/resolve response")
        end
        arg1.customData = arg1.customData or ""
        return arg1
    end

    if type(arg1.customData) ~= "string" then
        error("Malformed deeplinks/v2/resolve response")
    end

    return arg1
end

local function fetchResolvedShareLink(linkId: string, network)
    return HttpClient.fetch({
        method = "POST",
        url = url,
        body = { linkId = linkId },
        analyticsKey = "app-chat.resolve-share-link-v2",
        network = network,
        decode = decodeResolvedShareLink
    })
end

return fetchResolvedShareLink
