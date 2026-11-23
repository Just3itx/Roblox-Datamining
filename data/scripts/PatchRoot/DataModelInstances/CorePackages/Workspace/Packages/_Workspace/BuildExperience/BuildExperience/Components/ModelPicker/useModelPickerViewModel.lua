-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local UserInputService = game:GetService("UserInputService")

local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local Responsive = require(BuildExperienceParent.Responsive)

local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local FFlagBuildExperienceModelPickerChipHash = require(BuildExperience.Flags.FFlagBuildExperienceModelPickerChipHash)
local CreatorAgentChat = if FFlagBuildExperienceModelPicker then require(BuildExperienceParent.DataHydration.CreatorAgentChat) else nil
local var1 = FFlagBuildExperienceModelPicker and CreatorAgentChat.experimentOverride.isEnabled()
local Signals = if var1 then require(BuildExperienceParent.Signals) else nil
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local useClosableFocusRoot = require(BuildExperience.utils.useClosableFocusRoot)
local _ModelPickerTypes = require(script.Parent.ModelPickerTypes)
local _ModelPickerView = require(script.Parent.ModelPickerView)

local function useModelPickerViewModel(arg1)
    local internalTesting = if var1 then arg1.internalTesting else nil
    local var2 = Localization.Hooks.useLocalization({
        title = LocalizationStrings.MODEL_PICKER_TITLE,
        unavailable = LocalizationStrings.MODEL_PICKER_UNAVAILABLE,
        defaultLabel = LocalizationStrings.MODEL_PICKER_DEFAULT_LABEL,
        defaultDescription = LocalizationStrings.MODEL_PICKER_DEFAULT_DESCRIPTION,
        advancedLabel = LocalizationStrings.MODEL_PICKER_ADVANCED_LABEL,
        advancedDescription = LocalizationStrings.MODEL_PICKER_ADVANCED_DESCRIPTION,
        internalLabel = if internalTesting then LocalizationStrings.MODEL_PICKER_INTERNAL_LABEL else nil,
        internalDescription = if internalTesting then LocalizationStrings.MODEL_PICKER_INTERNAL_DESCRIPTION else nil,
        internalSpecLabel = if internalTesting then LocalizationStrings.MODEL_PICKER_INTERNAL_SPEC_LABEL else nil,
        internalSpecPlaceholder = if internalTesting then LocalizationStrings.MODEL_PICKER_INTERNAL_SPEC_PLACEHOLDER else nil,
        internalSpecHint = if internalTesting then LocalizationStrings.MODEL_PICKER_INTERNAL_SPEC_HINT else nil
    })

    local var3, var4 = React.useState(nil)
    local isSelected = not (internalTesting == nil) and internalTesting.isSelected
    local isOpen = var3 == "picker"
    local isSpecOpen = var3 == "spec" and isSelected

    if var1 then
        React.useEffect(function()
            if not isOpen then
                return nil
            end
            return Signals.createEffect(function(arg2)
                CreatorAgentChat.PreviewSpecs.getPreviewSpecsStore(false).getAndFetchPreviewSpecs(arg2)
            end)
        end, { isOpen })
    end
    if FFlagBuildExperienceModelPicker then
        React.useEffect(function()
            if var3 ~= nil and (arg1.isDisabled or var3 == "spec" and not isSelected) then
                var4(nil)
            end
        end, { var3, isSelected, arg1.isDisabled })
    end
    local onSelect = React.useCallback(function()
        if isOpen and not arg1.isDisabled and internalTesting then
            internalTesting.onSelect()
        end
    end, { isOpen, arg1.isDisabled, internalTesting })
    local onOpenSpec = React.useCallback(function()
        if isOpen and isSelected and not arg1.isDisabled and internalTesting then
            var4("spec")
        end
    end, {
        isOpen,
        isSelected,
        arg1.isDisabled,
        internalTesting
    })

    local onClearSpec = React.useCallback(function()
        if isOpen
            and isSelected
            and not arg1.isDisabled
            and internalTesting
            and internalTesting.previewHash ~= nil
            and internalTesting.previewHash ~= ""
        then
            internalTesting.onSaveSpec(nil, internalTesting.previewSpecName)
        end
    end, {
        isOpen,
        isSelected,
        arg1.isDisabled,
        internalTesting
    })

    local onSaveSpec = React.useCallback(function(str1: string?, arg2)
        if isSpecOpen and not arg1.isDisabled and internalTesting then
            internalTesting.onSaveSpec(str1, arg2)
        end
    end, { isSpecOpen, arg1.isDisabled, internalTesting })
    local onCloseSpec = React.useCallback(function()
        var4("picker")
    end, {})
    local onOpen = React.useCallback(function()
        if arg1.isDisabled then
            return
        end

        if FFlagBuildExperienceModelPicker then
            local textBox = UserInputService:GetFocusedTextBox()
            if textBox then
                textBox:ReleaseFocus()
            end
        end
        var4("picker")
    end, { arg1.isDisabled })
    local onClose = React.useCallback(function()
        var4(nil)
    end, {})
    local var5 = React.useCallback(function(id: string)
        if not isOpen or arg1.isDisabled then
            return
        end
        for _, option in arg1.data.options do
            if option.id == id and option.isAvailable then
                var4(nil)
                arg1.onSelect(id)
                return
            end
        end
    end, {
        isOpen,
        arg1.isDisabled,
        arg1.data,
        arg1.onSelect
    })
    local focusRootRef = useClosableFocusRoot({
        surfaceIdentifier = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.PopUp,
        isOpen = isOpen or isSpecOpen,
        onClose = if isSpecOpen then onCloseSpec else onClose
    })
    local var15 = Responsive.usePreferredInput()

    local options = {}
    for _, option in arg1.data.options do
        local unavailable = var2.unavailable
        local var16 = nil
        if option.model == "Default" then
            unavailable = var2.defaultLabel
            var16 = var2.defaultDescription
        elseif option.model == "Advanced" then
            unavailable = var2.advancedLabel
            var16 = var2.advancedDescription
        end
        table.insert(
            options,
            {
                id = option.id,
                model = option.model,
                isAvailable = option.isAvailable,
                label = unavailable,
                description = var16
            }
        )
    end
    local title = var2.title
    if arg1.selectedId ~= nil then
        title = var2.unavailable
        for _, value in options do
            if value.id == arg1.selectedId then
                title = value.label
                break
            end
        end
    end

    if FFlagBuildExperienceModelPickerChipHash and isSelected and internalTesting then
        title = internalTesting.previewHash ~= "" and internalTesting.previewHash or var2.internalLabel
    elseif isSelected then
        title = var2.internalLabel
    end

    return {
        internalTesting = internalTesting
            and {
                isSelected = isSelected,
                previewHash = internalTesting.previewHash,
                previewSpecName = internalTesting.previewSpecName,
                onSelect = onSelect,
                onSaveSpec = onSaveSpec,
                onOpenSpec = onOpenSpec,
                onClearSpec = onClearSpec,
                label = var2.internalLabel,
                description = var2.internalDescription,
                specLabel = var2.internalSpecLabel,
                placeholder = var2.internalSpecPlaceholder,
                hint = var2.internalSpecHint
            }
            or nil,
        isSpecOpen = isSpecOpen,
        onCloseSpec = onCloseSpec,
        data = { options = options },
        selectedId = arg1.selectedId,
        isDisabled = arg1.isDisabled,
        LayoutOrder = arg1.LayoutOrder,
        label = title,
        title = var2.title,
        unavailableText = var2.unavailable,
        isOpen = isOpen,
        onOpen = onOpen,
        onClose = onClose,
        onSelect = var5,
        focusRootRef = focusRootRef,
        hasCloseAffordance = var15 ~= Responsive.Input.Directional
    }
end

return useModelPickerViewModel
