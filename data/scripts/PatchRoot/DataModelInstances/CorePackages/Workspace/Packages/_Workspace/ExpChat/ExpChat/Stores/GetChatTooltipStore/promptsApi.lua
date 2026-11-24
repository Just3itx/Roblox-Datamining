-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local UrlBuilder = require(ExpChatParent.UrlBuilder)
local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)

local FFlagExpChatUseUnifiedTooltipStore = ExpChatShared.Flags.FFlagExpChatUseUnifiedTooltipStore
local bool1 = game:DefineFastFlag("ExpChatUseTooltipPromptStyle", false)

local Url = UrlBuilder2.new({
    base = UrlBase.APIS,
    path = "modals-api/v1/prompts",
    query = {
        entryPoint = "InExperienceChatWindowOpen",
        promptStyle = if bool1 then "Tooltip" else "Modal"
    }
})()

local var2 = UrlBuilder2.new({ base = UrlBase.APIS, path = "modals-api/v1/prompts/impression" })()

local var4 = nil

return {
    fetchAllTooltipEligibility = function(callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
        if not FFlagExpChatUseUnifiedTooltipStore then
            return
        end

        if var4 ~= nil then
            if callback then
                callback({ customPrompts = var4 })
            end

            return
        end

        HttpService:RequestInternal({ Url = Url, Method = "GET", Headers = { Accept = "application/json" } }):Start(function(_, arg1)
            if arg1.StatusCode ~= 200 then
                var4 = {}
                var1:error("ChatTooltip eligibility request failed: {} {}", tostring(arg1.StatusCode), arg1.StatusMessage or "")

                if callback2 then
                    callback2()
                end

                return
            end

            local success, result = pcall(function()
                return HttpService:JSONDecode(arg1.Body)
            end)

            if success and result then
                local customPrompts = result.customPrompts
                local var3 = type(customPrompts) ~= "table" and {} or customPrompts

                var4 = var3

                if callback then
                    callback({ customPrompts = var3 })
                end
            else
                var4 = {}
                var1:error("Failed to decode ChatTooltip eligibility response")
                if callback2 then
                    callback2()
                end
            end
        end)
    end,
    reportImpression = function(str1: string)
        if not FFlagExpChatUseUnifiedTooltipStore then
            return
        end

        local body = HttpService:JSONEncode({ promptType = str1, promptId = str1 })

        HttpService:RequestInternal(
            {
                Url = var2,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = body
            }
        ):Start(
            function(_, arg1)
                if arg1.StatusCode == 200 then
                    var1:debug("ChatTooltip impression reported: {}", str1)
                    return
                end
                var1:error("ChatTooltip impression failed for {}: {} {}", str1, tostring(arg1.StatusCode), arg1.StatusMessage or "")
            end
        )
    end
}
