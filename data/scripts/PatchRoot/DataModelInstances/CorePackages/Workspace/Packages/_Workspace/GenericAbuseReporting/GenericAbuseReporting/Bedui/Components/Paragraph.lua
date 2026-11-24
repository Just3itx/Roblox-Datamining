-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local createTextWithLinks = require(GenericAbuseReporting.Bedui.Utils.createTextWithLinks)
local WebViewLink = require(GenericAbuseReporting.Bedui.Components.WebViewLink)

return React.memo(function(tbl1) -- name: Paragraph
    local var1 = React.useMemo(function()
        return createTextWithLinks(tbl1.component.paragraph.text, tbl1.component.paragraph.links)
    end, { tbl1.component.paragraph.text, tbl1.component.paragraph.links })

    local var2 = React.useMemo(function()
        if not tbl1.component.paragraph.links then
            return {}
        end

        local result = {}
        for _, link in tbl1.component.paragraph.links do
            table.insert(
                result,
                React.createElement(
                    WebViewLink,
                    {
                        component = {
                            componentType = "link",
                            isOptional = true,
                            formDataKey = nil,
                            link = link
                        }
                    }
                )
            )
        end

        return result
    end, { tbl1.component })

    return React.createElement(View, {
        tag = "size-full-0 auto-y col",
        LayoutOrder = tbl1.layoutOrder
    }, {
        Text = React.createElement(FoundationText, {
            Text = var1,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            tag = "auto-xy padding-bottom-small",
            LayoutOrder = 0
        }),
        Links = React.createElement(View, { tag = "size-full-0 auto-y col wraps", LayoutOrder = 1 }, var2)
    })
end)
