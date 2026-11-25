-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local React = require(SduiCoreSystemParent.React)
local Signals = require(SduiCoreSystemParent.Signals)
local GetDisplayStore = require(SduiCoreSystemParent.Display).GetDisplayStore
local GetInputModeStore = require(SduiCoreSystemParent.Responsive).GetInputModeStore

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConditionalPropTypes = require(SduiCoreSystem.ConditionalProps.SduiConditionalPropTypes)
local checkResponsiveConditions = require(SduiCoreSystem.SduiResponsiveHelpers).checkResponsiveConditions

return React.memo(function(tbl1) -- name: SduiResponsiveDetector
    local allConditionalProps = tbl1.allConditionalProps
    local setFailedResponsivePropIndexes = tbl1.setFailedResponsivePropIndexes
    local sduiContext = tbl1.sduiContext
    local getViewportSize = GetDisplayStore(false).getViewportSize
    local getLastInputType = GetInputModeStore(false).getLastInputType
    local getPreferredInputType = GetInputModeStore(false).getPreferredInputType
    local getIsSpatial = GetDisplayStore(false).getIsSpatial

    React.useLayoutEffect(function()
        local tbl2 = {}

        local function checkConditions(vector2: Vector2, str1: string, str2: string, bool1: boolean)
            local var1 = checkResponsiveConditions(allConditionalProps, vector2, str1, str2, bool1, sduiContext)

            local var2 = nil
            for value, value2 in var1 do
                if not not tbl2[value] ~= not not value2 then
                    var2 = true
                    break
                end
            end

            if not var2 then
                for value, value2 in tbl2 do
                    if not not var1[value] ~= not not value2 then
                        var2 = true
                        break
                    end
                end
            end

            if var2 then
                tbl2 = var1
                setFailedResponsivePropIndexes(var1)
            end
        end

        checkConditions(getViewportSize(false), getLastInputType(false), getPreferredInputType(false), getIsSpatial(false))

        return Signals.createEffect(function(arg1)
            checkConditions(getViewportSize(arg1), getLastInputType(arg1), getPreferredInputType(arg1), getIsSpatial(arg1))
        end)
    end, {
        getViewportSize,
        getLastInputType,
        getPreferredInputType,
        getIsSpatial,
        allConditionalProps,
        setFailedResponsivePropIndexes,
        sduiContext
    })

    return nil
end)
