-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local AddSystemInfoToArgs = require(ChartsParent.DiscoveryUtils).AddSystemInfoToArgs
local FFlagSduiChartsAudienceFilter = require(Charts.Flags.FFlagSduiChartsAudienceFilter)

local function buildChartsSortDetailRequest(arg1, tbl1)
    local tbl2 = {
        sort_id = tbl1.sortId
    }

    local tbl3 = {}
    AddSystemInfoToArgs(tbl3, { "maxMemory" })
    if tbl3.maxMemory and tbl3.maxMemory ~= "" then
        tbl2.max_memory = tbl3.maxMemory
    end

    if tbl1.contentPageToken and tbl1.contentPageToken ~= "" then
        tbl2.content_page_token = tbl1.contentPageToken
    end
    if tbl1.sessionId and tbl1.sessionId ~= "" then
        tbl2.session_id = tbl1.sessionId
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
        if filterSelections.selectedGenre and filterSelections.selectedGenre ~= "" then
            tbl2.selected_genre = filterSelections.selectedGenre
        end

        if FFlagSduiChartsAudienceFilter and filterSelections.audience and filterSelections.audience ~= "" then
            tbl2.audience = filterSelections.audience
        end
    end

    if tbl1.cachedRobloxComponentToTemplateId then
        tbl2.cached_roblox_component_to_template_id = tbl1.cachedRobloxComponentToTemplateId
    end

    if tbl1.clientCapabilities then
        tbl2.client_capabilities = tbl1.clientCapabilities
    end

    return arg1.GetChartsSortDetailRequest.new(tbl2)
end

return buildChartsSortDetailRequest
