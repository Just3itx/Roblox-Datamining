-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent
local React = require(InExperienceInterventionParent.React)
local Cryo = require(InExperienceInterventionParent.Cryo)

local InExperienceInterventionEventReceiver = require(InExperienceIntervention.InExperienceInterventionEventReceiver)
local InExperienceInterventionUIStateReducer = require(InExperienceIntervention.Reducers.InExperienceInterventionUIStateReducer)
local InExperienceInterventionDialogManager = require(InExperienceIntervention.InExperienceInterventionDialogManager)
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local useLocalization = require(InExperienceInterventionParent.Localization).Hooks.useLocalization

function InExperienceInterventionContainer()
    local uiState, var2 = React.useReducer(InExperienceInterventionUIStateReducer, Constants.InitialUIState)
    local localizedText = useLocalization(Constants.localizationKeys)

    local uiStateDispatch = React.useCallback(function(arg1)
        local var4 = Cryo.Dictionary.join(arg1, { dispatchTimestamp = DateTime.now().UnixTimestamp })

        var2(var4)
    end, { var2 })

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        EventReceiver = React.createElement(
            InExperienceInterventionEventReceiver,
            { uiStateDispatch = uiStateDispatch, localizedText = localizedText }
        ),
        DialogManager = React.createElement(InExperienceInterventionDialogManager, { uiState = uiState, uiStateDispatch = uiStateDispatch })
    })
end

return InExperienceInterventionContainer
