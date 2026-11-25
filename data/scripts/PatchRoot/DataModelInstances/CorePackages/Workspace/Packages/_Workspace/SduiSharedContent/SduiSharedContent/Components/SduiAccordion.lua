-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local FFlagSduiErrorPaths = require(SduiSharedContentParent.SharedFlags).FFlagSduiErrorPaths

local Foundation = require(SduiSharedContentParent.Foundation)
local React = require(SduiSharedContentParent.React)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiErrors = SduiCoreSystem.SduiErrors
local addSduiErrorContextFields = SduiCoreSystem.addSduiErrorContextFields

local Accordion = Foundation.Accordion

local var1 = table.freeze({})

return React.memo(function(tbl1) -- name: SduiAccordion
    local tbl2 = ({})

    for value, componentConfig in tbl1.items or var1 do
        local componentType = SduiBuilder.getComponentType(componentConfig, tbl1.sduiContext)
        if not componentType then
            local tbl3 = {
                name = tbl1.debugName,
                message = `Nil componentType in SduiAccordion at index {value}`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl3, componentConfig.errorContext)
            end
            tbl1.sduiContext.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.NilComponentType,
                tbl3,
                tbl1.sduiContext.appPage
            )
        else
            local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)

            local str1 = `Item_{value}_{componentType}`
            tbl2[str1] = React.createElement(sduiComponentWrapper, {
                componentConfig = componentConfig,
                sduiContext = tbl1.sduiContext,
                extraLocalProps = { index = value, layoutOrder = value },
                debugName = if tbl1.debugName then `{tbl1.debugName}.Item_{value}` else `Item_{value}`,
                localAnalyticsData = {
                    itemPosition = value,
                    itemComponentType = componentType,
                    componentType = componentType
                }
            })
        end
    end
    return React.createElement(Accordion.Root, {
        size = tbl1.size,
        isContained = tbl1.isContained,
        chevronPosition = tbl1.chevronPosition,
        LayoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }, tbl2)
end)
