-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local AddSystemInfoToArgs = require(ChartsParent.DiscoveryUtils).AddSystemInfoToArgs
local buildSduiCollectionInfo = require(ChartsParent.SduiSharedUtilities).buildSduiCollectionInfo
local SharedFlags = require(ChartsParent.SharedFlags)
local FFlagSduiChartsRequestPlaceholders = SharedFlags.FFlagSduiChartsRequestPlaceholders
local FFlagSduiPreferredTextSizeLineBudgets = SharedFlags.FFlagSduiPreferredTextSizeLineBudgets
local FFlagSduiChartsAudienceFilter = require(Charts.Flags.FFlagSduiChartsAudienceFilter)

local uDim = UDim.new(1, 72)

local function buildChartsPageRequest(arg1, tbl1)
    local tbl2 = {}

    local tbl3 = {}
    AddSystemInfoToArgs(tbl3, { "maxMemory" })
    if tbl3.maxMemory and tbl3.maxMemory ~= "" then
        tbl2.max_memory = tbl3.maxMemory
    end

    if tbl1 then
        if tbl1.feedPageToken and tbl1.feedPageToken ~= "" then
            tbl2.feed_page_token = tbl1.feedPageToken
        end
        if tbl1.sessionId and tbl1.sessionId ~= "" then
            tbl2.session_id = tbl1.sessionId
        end
        if tbl1.entryPaginationKey and tbl1.entryPaginationKey ~= "" then
            tbl2.entry_pagination_key = tbl1.entryPaginationKey
        end
        if tbl1.entryPageToken and tbl1.entryPageToken ~= "" then
            tbl2.entry_page_token = tbl1.entryPageToken
        end
        if tbl1.pageType and tbl1.pageType ~= "" then
            tbl2.page_type = tbl1.pageType
        end

        local filterSelections = tbl1.filterSelections
        if filterSelections then
            if filterSelections.device and filterSelections.device ~= "" then
                tbl2.device = filterSelections.device
            end
            if filterSelections.country and filterSelections.country ~= "" then
                tbl2.country = filterSelections.country
            end

            if filterSelections.ageGroup and filterSelections.ageGroup ~= "" then
                tbl2.age_group = filterSelections.ageGroup
            end

            if FFlagSduiChartsAudienceFilter and filterSelections.audience and filterSelections.audience ~= "" then
                tbl2.audience = filterSelections.audience
            end
        end

        if FFlagSduiChartsRequestPlaceholders and tbl1.includePlaceholders then
            tbl2.include_placeholders = true
        end

        if tbl1.hydrationStreamEnabled ~= nil then
            tbl2.hydration_stream_enabled = tbl1.hydrationStreamEnabled
        end

        if tbl1.cachedRobloxComponentToTemplateId then
            tbl2.cached_roblox_component_to_template_id = tbl1.cachedRobloxComponentToTemplateId
        end

        if tbl1.clientCapabilities then
            tbl2.client_capabilities = tbl1.clientCapabilities
        end

        if tbl1.hydrationStreamEnabled then
            local sduiCollectionInfo = buildSduiCollectionInfo("Small", uDim, if FFlagSduiPreferredTextSizeLineBudgets then 3 else nil)

            tbl2.collection_layout = arg1.CollectionLayoutInfo.new(
                {
                    items_per_row = sduiCollectionInfo.items_per_row,
                    rows_above_fold = sduiCollectionInfo.rows_above_fold
                }
            )
        end
    end
    return arg1.GetChartsPageRequest.new(tbl2)
end

return buildChartsPageRequest
