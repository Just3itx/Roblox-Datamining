-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Dash = require(MomentsCreationParent.Dash)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local useCallback = React.useCallback
local useMemo = React.useMemo
local useSignalState = SignalsReact.useSignalState

local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local FFlagMomentsTextOverlayV2Redesign = MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local tbl1 = { Enum.TextXAlignment.Center, Enum.TextXAlignment.Left, Enum.TextXAlignment.Right }

local tbl2 = {
    [Enum.TextXAlignment.Left.Name] = BuilderIcons.Icon.FourBarsHorizontalRightAligned,
    [Enum.TextXAlignment.Center.Name] = BuilderIcons.Icon.FourBarsHorizontalCenterAligned,
    [Enum.TextXAlignment.Right.Name] = BuilderIcons.Icon.FourBarsHorizontalLeftAligned
}

local function nextAlignment(textXAlignment) -- Luacid: Inlined by compiler; 1 call site recovered
    for value, value2 in tbl1 do
        if value2 == textXAlignment then
            return tbl1[value % #tbl1 + 1]
        end
    end
    return Enum.TextXAlignment.Center
end

local function useTextAlignmentButtonState(arg1)
    local var1 = useMemo(function()
        return Signals.createComputed(function(arg2)
            local activeSession = arg1.getActiveSession(arg2)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg2)
            local var1 = draft and draft[1]
            return if var1 == nil then Enum.TextXAlignment.Center else var1.textOverlayStyle.textXAlignment
        end)
    end, { arg1 })
    local var2 = useSignalState(var1)

    local onActivated = useCallback(function()
        local activeSession = arg1.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local var3 = draft and draft[1]
        if var3 == nil then
            return
        end
        local textXAlignment = nextAlignment(var3.textOverlayStyle.textXAlignment)
        activeSession.update({ Dash.joinDeep(var3, { textOverlayStyle = { textXAlignment = textXAlignment } }) })

        if FFlagMomentsTextOverlayV2Redesign then
            fireAnalyticsEvent(
                EventNames.EditingFlowTextOverlayAlignmentSelected,
                makeCreationEventFields.makeTextOverlayEventFields({ alignment = textXAlignment.Name })
            )
        end
    end, { arg1 })

    return {
        icon = tbl2[var2.Name] or BuilderIcons.Icon.FourBarsHorizontalCenterAligned,
        onActivated = onActivated
    }
end

return useTextAlignmentButtonState
