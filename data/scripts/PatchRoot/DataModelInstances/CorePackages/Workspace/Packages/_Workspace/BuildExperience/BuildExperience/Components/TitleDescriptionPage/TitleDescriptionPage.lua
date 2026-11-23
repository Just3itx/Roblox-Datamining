-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local GameConfigurationActions = require(BuildExperience.utils.GameConfigurationActions)
local ConfigurationActionTelemetry = require(BuildExperience.Telemetry.ConfigurationActionTelemetry)
local FFlagBuildExperienceActionOutcomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceActionOutcomeTelemetry)

local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local TextArea = Foundation.TextArea
local TextInput = Foundation.TextInput
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local Action = ConfigurationActionTelemetry.Action
local FailureReason = ConfigurationActionTelemetry.FailureReason

local function isSameText(logged, title: string, description: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (logged == nil or logged.title ~= title) and logged.description == description
end

local function getSaveParameters(saved, title: string, description: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        changedFields = ConfigurationActionTelemetry.getChangedFields(title ~= saved.title, description ~= saved.description)
    }
end

local function logSaveSuccess(tbl1, universeId: number, title: string, description: string)
    local current = tbl1.current

    if current.loggedSuccess and isSameText(current.logged, title, description) then
        return
    end
    ConfigurationActionTelemetry.sendSuccess(
        Action.ExperienceDetailsSave,
        { universeId = universeId },
        nil,
        (getSaveParameters(current.saved, title, description))
    )
    local tbl2 = { title = title, description = description }
    tbl1.current = { saved = tbl2, logged = tbl2, loggedSuccess = true }
end

local function logSaveFailure(tbl1, universeId: number, title: string, description: string, error)
    local current = tbl1.current

    if isSameText(current.logged, title, description) then
        return
    end
    ConfigurationActionTelemetry.sendFailure(
        Action.ExperienceDetailsSave,
        { universeId = universeId },
        {
            reason = FailureReason.RequestFailed,
            error = error
        },
        nil,
        (getSaveParameters(current.saved, title, description))
    )
    tbl1.current = {
        saved = current.saved,
        logged = { title = title, description = description },
        loggedSuccess = false
    }
end

local function TitleDescriptionPage(tbl1)
    local testId = tbl1.testId or "title-description-page"
    local titleText = tbl1.titleText or ""
    local descriptionText = tbl1.descriptionText or ""
    local text, onChanged = React.useBinding(titleText)
    local var1, var2 = React.useBinding(descriptionText)
    local var5 = useLocalization({
        descriptionLabel = LocalizationStrings.TITLE_DESCRIPTION_DESCRIPTION_LABEL,
        title = LocalizationStrings.TITLE_DESCRIPTION_TITLE,
        titleLabel = LocalizationStrings.TITLE_DESCRIPTION_TITLE_LABEL
    })
    local descriptionLabel = var5.descriptionLabel
    local title = var5.title
    local titleLabel = var5.titleLabel
    local var6 = if FFlagBuildExperienceActionOutcomeTelemetry then React.useRef({ saved = { title = titleText, description = descriptionText }, logged = nil, loggedSuccess = false }) else nil

    local onFocusLost = React.useCallback(function()
        local universeId = tbl1.universeId
        if universeId == nil then
            return
        end

        local value = text:getValue()
        local value2 = var1:getValue()
        if value == titleText and value2 == descriptionText then
            return
        end

        local var7 = GameConfigurationActions.updateTitleDescription(universeId, value, value2)
        if FFlagBuildExperienceActionOutcomeTelemetry then
            var7 = var7:andThen(function()
                logSaveSuccess(var6, universeId, value, value2)
            end)
        end
        var7:catch(function(error)
            warn(`[BuildExperience] Failed to save title and description: {tostring(error)}`)
            if FFlagBuildExperienceActionOutcomeTelemetry then
                logSaveFailure(var6, universeId, value, value2, error)
            end
        end)
    end, {
        var1,
        descriptionText,
        titleText,
        tbl1.universeId,
        text
    })

    React.useEffect(function()
        return onFocusLost
    end, { onFocusLost })

    local onActivated = React.useCallback(function()
        onFocusLost()
        tbl1.onBack()
    end, { tbl1.onBack, onFocusLost })

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = {
            ["composition-layout-detail"] = true,
            ["col align-x-center size-full bg-surface-0"] = true
        },
        testId = testId
    }, {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            tag = "composition-content-header row align-y-center gap-small size-full-0 auto-y padding-y-medium",
            testId = `{testId}-header`
        }, {
            Back = React.createElement(IconButton, {
                LayoutOrder = 1,
                icon = IconName.ArrowLargeLeft,
                isCircular = true,
                onActivated = onActivated,
                size = InputSize.Medium,
                variant = ButtonVariant.Utility,
                testId = `{testId}-back`
            }),
            Title = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = title,
                tag = "fill auto-y text-heading-medium text-align-x-left text-truncate-end content-emphasis"
            })
        }),
        Content = React.createElement(View, {
            LayoutOrder = 2,
            tag = "composition-content-body col gap-xlarge size-full-0 auto-y padding-y-large",
            testId = `{testId}-content-body`
        }, {
            TitleInput = React.createElement(TextInput, {
                LayoutOrder = 1,
                label = titleLabel,
                placeholder = tbl1.titlePlaceholder,
                text = text,
                width = UDim.new(1, 0),
                onChanged = onChanged,
                onFocusLost = onFocusLost,
                testId = `{testId}-title-input`
            }),
            DescriptionInput = React.createElement(TextArea, {
                LayoutOrder = 2,
                label = descriptionLabel,
                placeholder = tbl1.descriptionPlaceholder,
                text = var1,
                width = UDim.new(1, 0),
                numLines = 4,
                onChanged = var2,
                onFocusLost = onFocusLost,
                testId = `{testId}-description-input`
            })
        })
    })
end

return TitleDescriptionPage
