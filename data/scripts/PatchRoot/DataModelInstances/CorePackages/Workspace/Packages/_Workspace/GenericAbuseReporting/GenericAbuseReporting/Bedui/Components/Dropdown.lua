-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Cryo = require(GenericAbuseReportingParent.Cryo)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local ComponentSubtext = require(GenericAbuseReporting.Bedui.Components.ComponentSubtext)
local DropdownWithPopover = require(GenericAbuseReporting.Common.DropdownWithPopover)
local useFormData = require(GenericAbuseReporting.Bedui.Provider.useFormData)

return React.memo(function(tbl1) -- name: Dropdown
    local updateForm = useFormData().updateForm

    local cellDatas = React.useMemo(function()
        return Cryo.List.map(tbl1.component.dropdown.items, function(arg1)
            return {
                text = arg1.label or "",
                value = arg1.formDataValue
            }
        end)
    end, { tbl1.component.dropdown.items })

    local onChange = React.useCallback(function(str1: string)
        updateForm(tbl1.component.formDataKey, str1)
    end, { tbl1.component.formDataKey })

    return React.createElement(View, {
        tag = "size-full-0 auto-y col gap-small",
        LayoutOrder = tbl1.layoutOrder
    }, {
        Prompt = React.createElement(FoundationText, { Text = tbl1.component.dropdown.prompt, tag = "auto-xy", LayoutOrder = 0 }),
        DropdownMenuContainer = React.createElement(
            View,
            { tag = "size-full-0 auto-y col gap-small", LayoutOrder = 1, ZIndex = 3 },
            {
                DropdownWithPopover = React.createElement(DropdownWithPopover, {
                    placeholder = tbl1.component.dropdown.placeholder,
                    onChange = onChange,
                    cellDatas = cellDatas,
                    errorState = tbl1.isErrorState,
                    layoutOrder = 1
                }),
                ComponentSubtext = React.createElement(ComponentSubtext, {
                    isErrorState = tbl1.isErrorState,
                    isOptional = tbl1.component.isOptional,
                    requirementMessage = tbl1.component.requirementMessage,
                    layoutOrder = 2
                })
            }
        )
    })
end)
