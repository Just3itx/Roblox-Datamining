-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)

local NetworkingShareLinks = require(AppChat.Http.NetworkingShareLinks)
local var1 = require(AppChat.Logger):new(script.Name)

local function createShareLinkStore()
    local var2, var3 = Signals.createSignal({})

    local tbl1 = ({})

    return {
        getShareLinkMetadataTable = function(arg1)
            return var2(arg1)
        end,
        getShareLinkMetadataComputed = function(str1: string)
            if not tbl1[str1] then
                tbl1[str1] = Signals.createComputed(function(arg1)
                    return var2(arg1)[str1]
                end)
            end
            return tbl1[str1]
        end,
        fetchShareLinkMetadata = function(arg1, linkId: string, linkType: string)
            arg1(NetworkingShareLinks.GetMetadata.API({ linkId = linkId, linkType = linkType })):andThen(function(arg2)
                local responseBody = arg2.responseBody
                if not responseBody.data then
                    return
                end

                local var4 = HttpService:JSONDecode(responseBody.data)
                if not var4.universeId then
                    var1:warning("Invalid share link metadata: ", var4)
                end
                var3(function(arg3)
                    local var5 = table.clone(arg3)
                    var5[linkId] = var4
                    return var5
                end)
            end):catch(function(arg2)
                var1:warning("Error fetching share link metadata: ", arg2)
            end)
        end
    }
end

return createShareLinkStore
