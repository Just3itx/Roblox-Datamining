-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local AbuseReportFormDataContext = require(GenericAbuseReporting.Bedui.Provider.AbuseReportFormDataContext)

local FFlagAddThumbnailSelectorReport = require(GenericAbuseReportingParent.SharedFlags).FFlagAddThumbnailSelectorReport

local function AbuseReportFormDataProvider(tbl1)
    local formData, var2 = React.useState({})
    local var3, var4 = React.useState({})

    local updateForm = React.useCallback(function(str1: string, str2: string)
        var2(function(arg1)
            local var5 = table.clone(arg1)
            var5[str1] = str2
            return var5
        end)
    end, {})

    local var6 = React.useCallback(function(str1: string, arg1)
        var4(function(arg2)
            local var6 = table.clone(arg2)
            var6[str1] = arg1
            return var6
        end)
    end, {})

    local createElement = React.createElement
    local provider = AbuseReportFormDataContext.Provider
    local tbl2 = { value = 0 }
    local value = {
        formData = formData,
        updateForm = updateForm,
        custom = tbl1.custom,
        additionalReportTags = 0,
        updateAdditionalReportTags = 0
    }

    if not FFlagAddThumbnailSelectorReport then
        var3 = nil
    end

    value.additionalReportTags = var3
    if not FFlagAddThumbnailSelectorReport then
        var6 = nil
    end

    value.updateAdditionalReportTags = var6
    tbl2.value = value
    return createElement(provider, tbl2, tbl1.children)
end

return AbuseReportFormDataProvider
