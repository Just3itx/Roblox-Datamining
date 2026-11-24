-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local UrlBuilder = require(ExpChatParent.UrlBuilder)
local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local var1 = require(ExpChatParent.ExpChatShared).Logger:new("ExpChat/" .. script.Name)

local Url = UrlBuilder2.new({
    base = UrlBase.APIS,
    path = "modals-api/v1/prompts",
    query = { entryPoint = "InExperienceChatWindowOpen", promptStyle = "Modal" }
})()

local var2 = UrlBuilder2.new({ base = UrlBase.APIS, path = "modals-api/v1/prompts/impression" })()

local var4 = nil

return {
    fetchEligibility = function(callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?) -- name: fetchGlobalChatTooltipEligibility
        if var4 ~= nil then
            if callback then
                callback({ shouldShowTooltip = var4 })
            end
            return
        end

        HttpService:RequestInternal({ Url = Url, Method = "GET", Headers = { Accept = "application/json" } }):Start(function(_, arg1)
            if arg1.StatusCode ~= 200 then
                var4 = false
                var1:error("GlobalChatTooltip eligibility request failed: {} {}", tostring(arg1.StatusCode), arg1.StatusMessage or "")

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
                local shouldShowTooltip = not (customPrompts == nil or type(customPrompts) ~= "table") and customPrompts.GlobalChatTooltip ~= nil
                var4 = shouldShowTooltip

                if callback then
                    callback({ shouldShowTooltip = shouldShowTooltip })
                end
            else
                var4 = false
                var1:error("Failed to decode GlobalChatTooltip eligibility response")
                if callback2 then
                    callback2()
                end
            end
        end)
    end,
    reportImpression = function()
        local body = HttpService:JSONEncode({ promptType = "GlobalChatTooltip", promptId = "GlobalChatTooltip" })

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
                    var1:debug("GlobalChatTooltip impression reported")
                    return
                end
                var1:error("GlobalChatTooltip impression failed: {} {}", tostring(arg1.StatusCode), arg1.StatusMessage or "")
            end
        )
    end
}
