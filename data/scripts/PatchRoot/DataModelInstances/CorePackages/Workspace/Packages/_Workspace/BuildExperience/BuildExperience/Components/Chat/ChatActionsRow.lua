-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)

local FFlagBuildExperienceGateSendDuringResponse = require(BuildExperience.Flags.FFlagBuildExperienceGateSendDuringResponse)
local StopAssistantResponseDialog = require(script.Parent.StopAssistantResponseDialog)

local IconButton = Foundation.IconButton

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function constantSource(): number
    return 0
end

local function ChatActionsRow(tbl1)
    local var1 = React.useCallback(function(arg1)
        if tbl1.getIsComposerEmpty ~= nil then
            return tbl1.getIsComposerEmpty(arg1)
        end
        if typeof(arg1) == "function" then
            arg1(constantSource)
        end
        return tbl1.isComposerEmpty == true
    end, { tbl1.getIsComposerEmpty, tbl1.isComposerEmpty })
    local var2 = SignalsReact.useSignalState(var1)
    local bool1 = not (tbl1.canStopAssistantResponse == false) and tbl1.canSendWhileResponding ~= true

    if not tbl1.isAssistantResponding then
        local var3 = FFlagBuildExperienceModelPicker

        if var3 then
            if tbl1.canStopAssistantResponse ~= true then
                bool1 = false
            end
        else
            bool1 = var3
        end
    end

    local bool2 = tbl1.isAssistantResponding ~= true or tbl1.canSendWhileResponding == true
    local isDisabled = not bool1
        and (FFlagBuildExperienceGateSendDuringResponse and not bool2
            or (if var2 and tbl1.hasAttachments ~= true then true else tbl1.isSendDisabled == true))

    local var3, var4 = React.useState(false)
    local onCancel = React.useCallback(function()
        var4(false)
    end, {})
    local onConfirm = React.useCallback(function()
        var4(false)
        tbl1.onStop()
    end, { tbl1.onStop })

    React.useEffect(function()
        if not bool1 then
            var4(false)
        end
    end, { bool1 })

    local createElement = React.createElement
    local var7 = IconButton
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        icon = if bool1 then IconName.StopSmall else IconName.ArrowWideShortUp,
        size = InputSize.Small,
        variant = if bool1 then ButtonVariant.Standard elseif not var2 or tbl1.hasAttachments == true then ButtonVariant.Emphasis else ButtonVariant.Standard,
        isCircular = true,
        isDisabled = isDisabled or bool1 and tbl1.isStopDisabled == true,
        onActivated = 0
    }

    function tbl2.onActivated()
        if bool1 then
            var4(true)
            return
        end
        tbl1.onSend()
    end

    local action = createElement(var7, tbl2)

    return React.createElement(React.Fragment, nil, {
        Action = action,
        StopDialog = if var3 and bool1 then React.createElement(StopAssistantResponseDialog, { onCancel = onCancel, onConfirm = onConfirm }) else nil
    })
end

return ChatActionsRow
