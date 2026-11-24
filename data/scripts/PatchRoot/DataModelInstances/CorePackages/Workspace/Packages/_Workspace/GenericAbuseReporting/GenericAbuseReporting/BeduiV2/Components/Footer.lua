-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local useDefaultTags = Foundation.Hooks.useDefaultTags
local View = Foundation.View

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)

local LinkOpenedSource = analyticsService.LinkOpenedSource

return React.memo(function(tbl1) -- name: Footer
    local tag = useDefaultTags(tbl1.additionalTag, "col gap-small size-full-0 auto-y")

    if not tbl1.footerItems or #tbl1.footerItems == 0 then
        return nil
    end

    local tbl2 = {}
    for layoutOrder, footerItem in ipairs(tbl1.footerItems) do
        table.insert(
            tbl2,
            React.createElement(TextWithTranslation, {
                input = footerItem.label,
                linkId = footerItem.id,
                linkSource = LinkOpenedSource.Footer,
                tag = "auto-xy text-body-small",
                layoutOrder = layoutOrder
            })
        )
    end

    return React.createElement(View, { padding = tbl1.padding, tag = tag, LayoutOrder = tbl1.layoutOrder }, tbl2)
end)
