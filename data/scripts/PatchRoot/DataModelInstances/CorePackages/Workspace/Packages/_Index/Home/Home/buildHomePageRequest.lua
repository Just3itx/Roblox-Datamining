-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HttpService = game:GetService("HttpService")

local buildHomePromptClientAttributes = require(Home.buildHomePromptClientAttributes)
local buildHomeSystemContextFeatures = require(Home.buildHomeSystemContextFeatures)

local FFlagLuaAppSduiHomePromptClientAttributes = require(Home.Flags.FFlagLuaAppSduiHomePromptClientAttributes)

local var1 = if FFlagLuaAppSduiHomePromptClientAttributes then "prompt_client_attributes" else nil

local function buildContextualFeatures(tbl1)
    local homeSystemContextFeatures = buildHomeSystemContextFeatures()

    if FFlagLuaAppSduiHomePromptClientAttributes then
        local homePromptClientAttributes = buildHomePromptClientAttributes()
        if next(homePromptClientAttributes) ~= nil then
            local success, result = pcall(HttpService.JSONEncode, HttpService, homePromptClientAttributes)
            if success and typeof(result) == "string" then
                homeSystemContextFeatures[var1] = result
            end
        end
    end

    if typeof(tbl1.contextualFeatures) == "table" then
        for value, value2 in tbl1.contextualFeatures do
            if typeof(value) == "string" and value2 ~= nil then
                homeSystemContextFeatures[value] = tostring(value2)
            end
        end
    end

    if tbl1.requestIntent and tbl1.requestIntent ~= "" then
        homeSystemContextFeatures.request_intent = tbl1.requestIntent
    end

    return if next(homeSystemContextFeatures) == nil then nil else homeSystemContextFeatures
end

local function buildHomePageRequest(arg1, tbl1)
    local tbl2 = {}

    if tbl1 then
        if tbl1.sessionId and tbl1.sessionId ~= "" then
            tbl2.session_id = tbl1.sessionId
        end

        tbl2.topic_ids = tbl1.topicIds

        tbl2.contextual_features = buildContextualFeatures(tbl1)

        if tbl1.cachedRobloxComponentToTemplateId then
            tbl2.cached_roblox_component_to_template_id = tbl1.cachedRobloxComponentToTemplateId
        end

        if tbl1.clientCapabilities then
            tbl2.client_capabilities = tbl1.clientCapabilities
        end

        if tbl1.collectionLayout then
            tbl2.collection_layout = arg1.HomeCollectionLayoutInfo.new(
                {
                    items_per_row = tbl1.collectionLayout.items_per_row,
                    rows_above_fold = tbl1.collectionLayout.rows_above_fold
                }
            )
        end
    end
    return arg1.HomePageRequest.new(tbl2)
end

return buildHomePageRequest
