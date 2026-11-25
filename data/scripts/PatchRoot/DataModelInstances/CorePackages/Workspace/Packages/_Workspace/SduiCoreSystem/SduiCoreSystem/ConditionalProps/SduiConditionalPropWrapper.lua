-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local Cryo = require(SduiCoreSystemParent.Cryo)
local React = require(SduiCoreSystemParent.React)
local GetInputModeStore = require(SduiCoreSystemParent.Responsive).GetInputModeStore
local compareSduiProps = require(SduiCoreSystem.compareSduiProps)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiResponsiveDetector = require(SduiCoreSystem.ConditionalProps.SduiResponsiveDetector)
local SduiPresenceDetector = require(SduiCoreSystem.ConditionalProps.SduiPresenceDetector)
local GetDisplayStore = require(SduiCoreSystemParent.Display).GetDisplayStore

local checkPresenceConditions = require(SduiCoreSystem.ConditionalProps.checkPresenceConditions)
local checkResponsiveConditions = require(SduiCoreSystem.SduiResponsiveHelpers).checkResponsiveConditions
local SduiConditionalPropTypes = require(SduiCoreSystem.ConditionalProps.SduiConditionalPropTypes)
local SduiConditionKey = SduiConditionalPropTypes.SduiConditionKey
local SduiResponsiveKey = SduiConditionalPropTypes.SduiResponsiveKey

local tbl1 = {}

return React.memo(function(tbl2) -- name: SduiConditionalPropWrapper
    local sduiContext = tbl2.sduiContext
    sduiContext.dependencies.instrumentation:startTimerFlow("SduiConditionalPropWrapper")

    local conditionalProps = tbl2.componentConfig.conditionalProps
    local dataStore = sduiContext.dataStore

    local var1 = React.useMemo(function()
        local result = {}
        if not conditionalProps then
            return result
        end
        assert(conditionalProps, "conditionalProps must exist")
        for _, conditionalProp in conditionalProps do
            if not conditionalProp.conditions then
                continue
            end

            for k, _ in conditionalProp.conditions do
                if k == SduiConditionKey.friendInGame then
                    result.hasPresenceProp = true
                elseif SduiResponsiveKey[k] ~= nil then
                    result.hasResponsiveProp = true
                else
                    result.hasCustomProp = true
                end
            end
        end

        return result
    end, { conditionalProps })

    local var2, var3 = React.useState(nil)
    local setCustomConditionState = React.useCallback(function(str1: string, arg1)
        var3(function(arg2)
            if arg2 == nil and arg1 == nil then
                return arg2
            end

            if arg2 == nil then
                return {
                    [str1] = arg1
                }
            end

            if arg2[str1] == arg1 then
                return arg2
            end
            local var4 = table.clone(arg2)
            var4[str1] = arg1
            return var4
        end)
    end, {})

    local var5, setFailedResponsivePropIndexes = React.useState(function()
        if not var1.hasResponsiveProp then
            return tbl1
        end

        local getViewportSize = GetDisplayStore(false).getViewportSize
        local getLastInputType = GetInputModeStore(false).getLastInputType
        local getPreferredInputType = GetInputModeStore(false).getPreferredInputType
        local getIsSpatial = GetDisplayStore(false).getIsSpatial

        return checkResponsiveConditions(
            conditionalProps,
            getViewportSize(false),
            getLastInputType(false),
            getPreferredInputType(false),
            getIsSpatial(false),
            sduiContext
        )
    end)

    local var7, setFailedPresencePropIndexes = React.useState(function()
        if var1.hasPresenceProp then
            return checkPresenceConditions(conditionalProps, dataStore.social.getInGameFriendsByGame(false))
        end
        return tbl1
    end)

    local var9 = React.useCallback(function(num1: number, arg1)
        if var5[num1] or var7[num1] then
            return false
        end
        if arg1.conditions then
            for k, condition in arg1.conditions do
                if SduiResponsiveKey[k] == nil and k ~= SduiConditionKey.friendInGame then
                    return not not (var2 and var2[k] == condition)
                end
            end
        end
        return true
    end, { var5, var7, var2 })

    local var4 = React.useMemo(function()
        local tbl3 = { setCustomConditionState = setCustomConditionState }

        if conditionalProps then
            for k, conditionalProp in conditionalProps do
                if conditionalProp.propOverrides and var9(k, conditionalProp) then
                    tbl3 = Cryo.Dictionary.join(tbl3, conditionalProp.propOverrides)
                end
            end
        end

        return tbl3
    end, { var9, conditionalProps, setCustomConditionState })

    local var11 = React.useMemo(function()
        if not conditionalProps then
            return {}
        end
        assert(conditionalProps, "conditionalProps must exist")

        local result = ({})

        if var1.hasPresenceProp then
            result.PresenceDetector = React.createElement(SduiPresenceDetector, {
                setFailedPresencePropIndexes = setFailedPresencePropIndexes,
                sduiContext = sduiContext,
                allConditionalProps = conditionalProps
            })
        end

        if var1.hasResponsiveProp then
            result.ResponsiveDetector = React.createElement(SduiResponsiveDetector, {
                setFailedResponsivePropIndexes = setFailedResponsivePropIndexes,
                sduiContext = sduiContext,
                allConditionalProps = conditionalProps
            })
        end

        return result
    end, { conditionalProps, sduiContext, var1 })

    var11.WrappedComponent = React.useMemo(function()
        return React.createElement(tbl2.wrappedComponent, Cryo.Dictionary.join(tbl2, { conditionalProps = var4 }))
    end, { tbl2.wrappedComponent, var4, tbl2 })

    sduiContext.dependencies.instrumentation:stopTimerFlow("SduiConditionalPropWrapper", sduiContext)

    return React.createElement(React.Fragment, nil, var11)
end, compareSduiProps)
