-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Regex = require(AppChatParent.UrlMatching).Regex

local FFlagAppChatResolveShareLinkV2 = require(AppChat.Flags.FFlagAppChatResolveShareLinkV2)
local FFlagAppChatPlusReferralAssetCard = require(AppChat.Flags.FFlagAppChatPlusReferralAssetCard)
local FFlagAppChatEarlyTestingLinks = require(AppChat.Flags.FFlagAppChatEarlyTestingLinks)

local tbl1 = { "ExperienceDetails" }

local queryParams = FFlagAppChatResolveShareLinkV2
    and {
        { name = "code", pattern = "[a-fA-F0-9-]+" },
        {
            name = "type",
            pattern = Regex.oneOf(tbl1),
            optional = true
        },
        {
            name = "v",
            pattern = Regex.oneOf({ "v2" }),
            optional = true
        }
    }
    or {
        { name = "code", pattern = "[a-fA-F0-9]+" },
        {
            name = "type",
            pattern = Regex.oneOf(tbl1)
        }
    }

return {
    ["/games"] = {
        pathParams = {
            { name = "path", pattern = "games" },
            { name = "id", pattern = "[0-9]+" },
            { name = "name", pattern = "[a-zA-Z0-9_-]+", optional = true }
        },
        queryParams = FFlagAppChatEarlyTestingLinks and {{
            name = "isEarlyTesting",
            pattern = "true",
            optional = true
        }} or nil,
        paramCallback = function(tbl2) -- name: createGameLinkMessage
            return {
                placeId = tbl2.id,
                isEarlyTesting = if FFlagAppChatEarlyTestingLinks and tbl2.isEarlyTesting == "true" then true else nil
            }
        end
    },
    ["/share"] = {
        queryParams = queryParams,
        paramCallback = function(tbl2) -- name: createShareLinkMessage
            if not FFlagAppChatResolveShareLinkV2 then
                return {
                    shareLink = {
                        linkId = tbl2.code,
                        linkType = tbl2.type
                    }
                }
            end

            if tbl2.v == "v2" then
                return {
                    shareLink = {
                        linkId = tbl2.code,
                        version = 2
                    }
                }
            end

            if not tbl2.type then
                return nil
            end

            return {
                shareLink = {
                    linkId = tbl2.code,
                    linkType = tbl2.type,
                    version = 1
                }
            }
        end
    },
    ["/plus-referral"] = FFlagAppChatPlusReferralAssetCard and {
        queryParams = queryParams,
        paramCallback = function(tbl2): {shareLink: {linkId: any, linkType: string, version: number}}?
            return if tbl2.code and tbl2.code ~= "" then {
                shareLink = {
                    linkId = tbl2.code,
                    linkType = "PlusReferral",
                    version = 2
                }
            } else nil
        end
    } or nil
}
