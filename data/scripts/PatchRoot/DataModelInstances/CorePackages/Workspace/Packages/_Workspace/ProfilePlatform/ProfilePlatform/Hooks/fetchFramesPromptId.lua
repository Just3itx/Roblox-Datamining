-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local HttpService = game:GetService("HttpService")
local Promise = require(ProfilePlatformParent.Promise)
local UrlBuilder = require(ProfilePlatformParent.UrlBuilder).UrlBuilder
local UrlBase = require(ProfilePlatformParent.UrlBuilder).UrlBase

local Url = UrlBuilder.new({ base = UrlBase.APIS, path = "modals-api/v1/prompts", query = { entryPoint = "SelfUserProfileOpen" } })()

local function fetchFramesPromptId()
    return Promise.new(function(callback, callback2)
        HttpService:RequestInternal({ Url = Url, Method = "GET" }):Start(function(arg1, arg2)
            if not arg1 or not arg2 or arg2.StatusCode ~= 200 then
                callback2()
                return
            end
            local body = arg2.Body
            if typeof(body) == "string" then
                local success, result = pcall(function()
                    return HttpService:JSONDecode(body)
                end)
                if not success then
                    callback2()
                    return
                end
                body = result
            end
            local var2 = body and (body.pageEntries or body.page_entries)
            if not var2 then
                callback2()
                return
            end
            for _, value in var2 do
                local var3 = value.pageEntry or value.page_entry
                if (var3 and (var3.robloxComponent or var3.roblox_component)) ~= "ProfileCompletionCardCarousel" then
                    continue
                end

                local identifier = var3.identifier
                if identifier and identifier ~= "" then
                    callback(identifier)
                    return
                end
            end

            callback2()
        end)
    end)
end

return fetchFramesPromptId
