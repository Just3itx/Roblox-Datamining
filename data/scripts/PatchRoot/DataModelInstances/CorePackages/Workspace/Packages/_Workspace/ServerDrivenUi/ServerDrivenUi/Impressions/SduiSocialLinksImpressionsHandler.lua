-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local sendSocialLinksImpressionsEvent = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.sendSocialLinksImpressionsEvent

local SduiErrors = require(ServerDrivenUiParent.SduiCoreSystem).SduiErrors

local tbl1 = {}

local function SduiSocialLinksImpressionsHandler(arg1, tbl2, tbl3, arg2, _: number?)
    if not arg2 then
        arg1.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.FailedToLogSocialLinksImpressions,
            {
                name = "SduiSocialLinksImpressionsHandler",
                message = "Missing collectionAnalyticsData"
            },
            arg1.appPage
        )
        return
    end

    if #tbl2 == 0 or #(tbl3 or tbl1) == 0 then
        arg1.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToLogSocialLinksImpressions, {
            name = "SduiSocialLinksImpressionsHandler",
            message = `No entries to log: impressionIndexes={#tbl2}, itemAnalyticsDatas={#(tbl3 or tbl1)}`
        }, arg1.appPage)
        return
    end

    local tbl4 = {}
    local tbl5 = {}
    local tbl6 = {}

    for _, value in tbl2 do
        local var1 = tbl3[value]
        if var1 then
            table.insert(tbl4, value)
            table.insert(tbl5, var1.socialLinkUrl or "")
            table.insert(tbl6, var1.socialLinkType or "")
        end
    end

    if #tbl4 == 0 then
        arg1.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.FailedToLogSocialLinksImpressions,
            {
                name = "SduiSocialLinksImpressionsHandler",
                message = "No valid items found for impression indexes"
            },
            arg1.appPage
        )
        return
    end

    sendSocialLinksImpressionsEvent({
        item_positions = table.concat(tbl4, ","),
        social_link_urls = table.concat(tbl5, ","),
        social_link_types = table.concat(tbl6, ","),
        social_link_display_type = arg2.socialLinkDisplayType,
        assignment_id = tonumber(arg2.assignmentId),
        assignment_type = arg2.assignmentType,
        page = arg1.appPage
    })
end

return SduiSocialLinksImpressionsHandler
