-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService

local Checkbox = Foundation.Checkbox
local Image = Foundation.Image
local ScaleType = Enum.ScaleType
local FoundationText = Foundation.Text
local View = Foundation.View

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local ComponentSubtext = require(GenericAbuseReporting.Bedui.Components.ComponentSubtext)
local getPlaceMediaAssetIds = require(GenericAbuseReporting.Bedui.Utils.getPlaceMediaAssetIds)
local useFormData = require(GenericAbuseReporting.Bedui.Provider.useFormData)

local uDim2 = UDim2.fromOffset(180, 101)

local tbl1 = {
    [AbuseVector.Place] = "THUMBNAIL_IDS"
}

return React.memo(function(tbl2) -- name: Selector
    local var1, var2 = React.useState({})

    local var3, var4 = React.useState({})

    local custom = useFormData().custom
    local updateForm = useFormData().updateForm
    local updateAdditionalReportTags = useFormData().updateAdditionalReportTags
    local var5 = useRoactService(RoactNetworking)

    local var6 = React.useRef(`selector-{DateTime.now()}`)

    React.useEffect(function()
        if tbl2.abuseVector ~= AbuseVector.Place then
            return
        end

        local var7 = getPlaceMediaAssetIds
        local var8 = var5
        local universeId = custom and custom.universeId

        var7(var8, tostring(universeId)):andThen(function(arg1)
            var2(arg1)
        end)
    end, {
        tbl2.abuseVector,
        getPlaceMediaAssetIds,
        var5,
        custom and custom.universeId
    })

    local var7 = React.useCallback(function(str1: string)
        var4(function(arg1)
            local var7 = table.clone(arg1)
            local var8 = table.find(var7, str1)
            if var8 then
                table.remove(var7, var8)
            else
                table.insert(var7, str1)
            end

            if tbl2.abuseVector == AbuseVector.Place then
                local tagValue = table.concat(var7, ",")
                if updateAdditionalReportTags then
                    updateAdditionalReportTags(var6.current, { tagKey = tbl1[tbl2.abuseVector], tagValue = tagValue })
                end
            end

            return var7
        end)
    end, { tbl2.component, tbl2.abuseVector, updateForm })

    local var8 = React.useMemo(function()
        local result = {}
        for layoutOrder, value in ipairs(var1) do
            local createElement = React.createElement
            local var8 = View

            local tbl3 = { Checkbox = 0, Image = 0 }
            local createElement2 = React.createElement
            local var9 = Checkbox
            local tbl4 = {
                label = "",
                isChecked = table.find(var3, value) ~= nil,
                onActivated = 0
            }

            function tbl4.onActivated()
                var7(value)
            end

            tbl3.Checkbox = createElement2(var9, tbl4)

            local createElement3 = React.createElement
            local var10 = Image
            local tbl5 = {
                Image = `rbxthumb://type=Asset&id={value}&w=768&h=432`,
                ScaleType = ScaleType.Fit,
                Size = uDim2,
                onActivated = 0
            }

            function tbl5.onActivated()
                var7(value)
            end

            tbl3.Image = createElement3(var10, tbl5)
            table.insert(
                result,
                createElement(
                    var8,
                    {
                        tag = "size-0-0 auto-xy row gap-small self-center border-radius-medium padding-small",
                        LayoutOrder = layoutOrder
                    },
                    tbl3
                )
            )
        end

        return result
    end, { var1, var3 })

    if #var1 == 0 then
        return nil
    end

    return (React.createElement(View, {
        tag = "size-full-0 auto-y col gap-small",
        LayoutOrder = tbl2.layoutOrder
    }, {
        Prompt = React.createElement(FoundationText, { Text = tbl2.component.selector.prompt, tag = "auto-xy", LayoutOrder = 0 }),
        CheckboxGroup = React.createElement(View, { tag = "size-full-0 auto-y col", LayoutOrder = 1 }, var8),
        ComponentSubtext = React.createElement(ComponentSubtext, {
            isErrorState = tbl2.isErrorState,
            isOptional = tbl2.component.isOptional,
            requirementMessage = tbl2.component.requirementMessage,
            layoutOrder = 2
        })
    }))
end)
