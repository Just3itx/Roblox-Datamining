-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local VirtualEvents = script:FindFirstAncestor("VirtualEvents")
local VirtualEventsParent = VirtualEvents.Parent

local NotificationsUpsell = require(VirtualEventsParent.NotificationsUpsell)
local Promise = require(VirtualEventsParent.Promise)
local UrlBuilder = require(VirtualEventsParent.UrlBuilder)
local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local _InGameRsvpPushUpsellTypes = require(VirtualEvents.Common.InGameRsvpPushUpsellTypes)
local logger = require(VirtualEvents.logger)
local FIntInGameRsvpPushUpsellTimeoutMs = require(VirtualEvents.Flags.FIntInGameRsvpPushUpsellTimeoutMs)

local PromptType = {
    OsPrompt = "PushNotificationsUpsellInGameOsPrompt",
    Settings = "PushNotificationsUpsellInGameSettings"
}

local tbl2 = { "title", "body", "confirm" }

local module = { PromptType = PromptType }

function module._sendRequest(options, callback: (...any) -> (...any))
    HttpService:RequestInternal(options):Start(function(_, arg1)
        callback(arg1)
    end)
end

function module._buildClientAttributes()
    return NotificationsUpsell.PushPermissionClientAttributes.build()
end

local function getPromptsUrl(input): string
    return `{UrlBuilder2.new({
        base = UrlBase.APIS,
        path = "modals-api/v1/prompts",
        query = { entryPoint = "InExperienceEventRsvpGoing", promptStyle = "Modal" }
    })()}&clientAttributes={HttpService:UrlEncode(HttpService:JSONEncode(input))}`
end

local function asTable(arg1): {[any]: any}? -- Luacid: Inlined by compiler; 4 call sites recovered
    return if type(arg1) == "table" then arg1 else nil
end

local function readTranslations(arg1)
    local var1 = asTable(arg1)
    local result = ({})
    local var2 = if var1 then var1.translations or var1.Translations else nil
    local var3 = asTable(var2)

    if var3 then
        for value, value2 in var3 do
            if type(value) == "string" and type(value2) == "string" then
                result[value] = value2
            end
        end
    end
    return result
end

local function parsePrompt(arg1)
    local var1 = asTable(arg1)
    local customPrompts = if var1 then var1.customPrompts else nil
    local var2 = asTable(customPrompts)

    if var2 == nil then
        return nil
    end

    for _, path in { "OsPrompt", "Settings" } do
        local promptType = PromptType[path]
        local var4 = var2[promptType]
        if var4 == nil then
            continue
        end

        local translations = readTranslations(var4)

        for _, value2 in tbl2 do
            if translations[value2] == nil or translations[value2] == "" then
                logger:warning("In-game RSVP push upsell {} has no {} translation", promptType, value2)
                return nil
            end
        end
        return { promptType = promptType, path = path, translations = translations }
    end

    return nil
end

local function request(url: string, method: string, body: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return Promise.new(function(callback, arg1)
        module._sendRequest({
            Url = url,
            Method = method,
            Headers = method == "POST" and { ["Content-Type"] = "application/json" } or {
                Accept = "application/json"
            },
            Body = body
        }, function(tbl3)
            local statusCode = tbl3.StatusCode

            if if method ~= "POST" then statusCode == 200 else typeof(statusCode) == "number" and statusCode >= 200 and statusCode < 300 then
                callback(tbl3)
                return
            end
            local var1 = arg1
            local str1 = method
            local str2 = url
            local statusCode2 = tbl3.StatusCode
            var1(`{str1} {str2} failed: {tostring(statusCode2)}`)
        end)
    end)
end

function module.fetch()
    return Promise.new(function(callback)
        local bool1 = false
        local function settle(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
            if not bool1 then
                bool1 = true
                callback(arg1)
            end
        end

        task.delay(FIntInGameRsvpPushUpsellTimeoutMs / 1000, function()
            if not bool1 then
                logger:warning("In-game RSVP push upsell request timed out after {} ms", FIntInGameRsvpPushUpsellTimeoutMs)
                settle(nil)
            end
        end)

        module._buildClientAttributes():andThen(function(tbl3)
            if next(tbl3) == nil then
                return nil
            end

            return request(getPromptsUrl(tbl3), "GET", nil):andThen(function(tbl4)
                local success, result = pcall(function()
                    return HttpService:JSONDecode(tbl4.Body)
                end)
                if not success then
                    return Promise.reject("invalid prompts response")
                end
                return (parsePrompt(result))
            end)
        end):andThen(settle, function(arg1)
            if not bool1 then
                logger:warning("In-game RSVP push upsell request failed: {}", tostring(arg1))
                settle(nil)
            end
        end)
    end)
end

local function postPromptEvent(path: string, str1: string)
    request(
        UrlBuilder2.new({ base = UrlBase.APIS, path = path })(),
        "POST",
        (HttpService:JSONEncode({ promptType = str1, promptId = str1 }))
    ):catch(
        function(arg1)
            logger:warning("In-game RSVP push upsell event failed: {}", tostring(arg1))
        end
    )
end

function module.reportImpression(str1: string)
    postPromptEvent("modals-api/v1/prompts/impression", str1)
end

function module.reportDismiss(str1: string)
    postPromptEvent("modals-api/v1/prompts/dismiss", str1)
end

return module
