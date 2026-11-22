-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local FocusNavigationUtils = require(MomentsCreationParent.FocusNavigationUtils)
local Foundation = require(MomentsCreationParent.Foundation)
local InputHandlers = require(MomentsCreationParent.InputHandlers)
local Localization = require(MomentsCreationParent.Localization)
local React = require(MomentsCreationParent.React)
local ReactFocusNavigation = require(MomentsCreationParent.ReactFocusNavigation)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local Loading = Foundation.Loading
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useLastInputMode = FocusNavigationUtils.useLastInputMode
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useDefaultFocusBehavior = ReactFocusNavigation.useDefaultFocusBehavior

local useLocalization = Localization.Hooks.useLocalization

local _voiceCatalog = require(MomentsCreation.Components.Voice.voiceCatalog)

local Speaker = BuilderIcons.Icon.Speaker
local PlaySmall = BuilderIcons.Icon.PlaySmall

local snapPoints = { 0.9 }

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function VoiceRow(tbl3)
    local id = tbl3.voice.id
    local onAudition = tbl3.onAudition
    local element

    if onAudition == nil then
        element = nil
    elseif tbl3.isAuditioning then
        element = React.createElement(
            View,
            { tag = "align-x-center align-y-center size-800-800", LayoutOrder = 2 },
            {
                Spinner = React.createElement(Loading, { size = IconSize.Small, testId = `voice-audition-loading-{id}` })
            }
        )
    else
        element = React.createElement(IconButton, {
            icon = PlaySmall,
            variant = ButtonVariant.Standard,
            isCircular = true,
            size = InputSize.Small,
            onActivated = function()
                onAudition(id)
            end,
            testId = `voice-audition-{id}`,
            LayoutOrder = 2
        })
    end

    return React.createElement(View, {
        ref = tbl3.focusRef,
        onActivated = function()
            tbl3.onSelect(id)
        end,
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-y-small radius-medium",
        testId = `voice-row-{id}`,
        LayoutOrder = tbl3.LayoutOrder
    }, {
        Info = React.createElement(View, {
            tag = "row align-y-center fill gap-medium auto-y",
            LayoutOrder = 1
        }, {
            IconTile = React.createElement(
                View,
                {
                    tag = "align-x-center align-y-center size-1000-1000 radius-medium bg-surface-300",
                    LayoutOrder = 1
                },
                {
                    VoiceIcon = React.createElement(Icon, { name = Speaker, size = IconSize.Medium })
                }
            ),
            Name = React.createElement(
                FoundationText,
                {
                    tag = "fill auto-y text-title-medium text-align-x-left content-emphasis",
                    Text = tbl3.voice.name,
                    LayoutOrder = 2
                }
            )
        }),
        Play = element
    })
end

local function VoiceSelectorDialog(tbl3)
    local onSelect = tbl3.onSelect
    local onAudition = tbl3.onAudition
    local onClose = tbl3.onClose

    local var1 = useLocalization({ title = "Feature.Moments.Label.ChooseVoice" })

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onClose()
                    arg1:cancel()
                end)
            }
        }
    end, { onClose })
    local var3 = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })
    local var4, ref = useDefaultFocusBehavior(var3)

    local hasCloseAffordance = useLastInputMode() ~= "Focus"

    local var6 = React.useMemo(function()
        return (Signals.createSignal(nil))
    end, {})
    local var7 = SignalsReact.useSignalState(tbl3.getAuditioningVoiceId or var6)

    local tbl4 = ({})
    for layoutOrder, voice in tbl3.voices do
        local str1 = `Voice_{voice.id}`
        tbl4[str1] = React.createElement(VoiceRow, {
            voice = voice,
            onSelect = onSelect,
            onAudition = onAudition,
            isAuditioning = var7 == voice.id,
            focusRef = if voice.id == tbl3.selectedVoiceId then var4 else nil,
            LayoutOrder = layoutOrder
        })
    end

    return React.createElement(
        Sheet.Root,
        {
            ref = ref,
            size = DialogSize.Medium,
            snapPoints = snapPoints,
            onClose = onClose
        },
        {
            Header = React.createElement(Sheet.Header, { hasCloseAffordance = hasCloseAffordance }, {
                Title = React.createElement(
                    FoundationText,
                    {
                        tag = "fill auto-y text-heading-small text-align-x-left content-emphasis",
                        Text = var1.title,
                        LayoutOrder = 1
                    }
                )
            }),
            Content = React.createElement(
                Sheet.Content,
                {},
                {
                    List = React.createElement(View, { tag = "col gap-xsmall size-full-0 auto-y" }, tbl4)
                }
            )
        }
    )
end

return VoiceSelectorDialog
