-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local ComponentSubtext = require(GenericAbuseReporting.Bedui.Components.ComponentSubtext)
local CommentTextField = require(GenericAbuseReporting.Common.CommentTextField)
local useFormData = require(GenericAbuseReporting.Bedui.Provider.useFormData)

return React.memo(function(tbl1) -- name: FreeComment
    local var1 = useTokens()
    local text, var3 = React.useState("")
    local updateForm = useFormData().updateForm

    local onUpdate = React.useCallback(function(str1: string)
        var3(str1)
        updateForm(tbl1.component.formDataKey, str1)
    end, { updateForm, tbl1.component.formDataKey })

    return React.createElement(View, {
        tag = "size-full-0 auto-y col gap-small",
        LayoutOrder = tbl1.layoutOrder
    }, {
        Prompt = React.createElement(FoundationText, { Text = tbl1.component.freeComment.prompt, tag = "auto-xy", LayoutOrder = 0 }),
        FreeCommentContainer = React.createElement(
            View,
            {
                tag = "size-full-0 auto-y col align-x-left stroke-thick stroke-default radius-medium",
                LayoutOrder = 1
            },
            {
                FreeComment = React.createElement(CommentTextField, {
                    text = text,
                    placeholderText = tbl1.component.freeComment.placeholder,
                    backgroundColor3 = var1.Color.Shift.Shift_100.Color3,
                    backgroundTransparency = var1.Color.Shift.Shift_100.Transparency,
                    onUpdate = onUpdate,
                    layoutOrder = 1
                })
            }
        ),
        ComponentSubtext = React.createElement(ComponentSubtext, {
            isErrorState = tbl1.isErrorState,
            isOptional = tbl1.component.isOptional,
            requirementMessage = tbl1.component.requirementMessage,
            layoutOrder = 2
        })
    })
end)
