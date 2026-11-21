-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomFormsParent = script:FindFirstAncestor("CustomForms").Parent
local React = require(CustomFormsParent.React)
local Foundation = require(CustomFormsParent.Foundation)

local CustomFormResultBar = require(script.Parent.CustomFormResultBar)
local _CustomFormSelection = require(script.Parent.CustomFormSelection)

local function text(text2: string?, layoutOrder: number, testId: string, bool1: boolean?)
    if not text2 or text2 == "" then
        return nil
    end

    return (React.createElement(Foundation.Text, {
        Text = text2,
        LayoutOrder = layoutOrder,
        testId = testId,
        tag = {
            ["size-full-0 auto-y text-body-medium text-align-x-left"] = true,
            ["content-alert"] = bool1 == true,
            ["content-default"] = bool1 ~= true
        }
    }))
end

local function renderOption(tbl1, tbl2, tbl3, layoutOrder: number)
    if tbl3.result then
        return React.createElement(CustomFormResultBar, {
            label = tbl3.label,
            percentage = tbl3.result.percentage,
            isSelected = tbl3.isChosen,
            viewerUserId = tbl1.viewerUserId,
            layoutOrder = layoutOrder,
            testId = `{tbl3.testId}--result`
        })
    end
    local bool1 = tbl2.rowWidth ~= nil
    local createElement = React.createElement
    local view = Foundation.View
    local tbl4 = {
        LayoutOrder = layoutOrder,
        Size = if tbl2.rowWidth then UDim2.fromOffset(tbl2.rowWidth, 0) else nil,
        onActivated = if tbl1.isEditable then tbl3.onActivated else nil,
        tag = {
            ["row align-y-center auto-y padding-x-medium padding-y-medium"] = true,
            ["size-full-0"] = not bool1,
            ["stroke-standard radius-medium"] = true,
            ["stroke-emphasis"] = tbl3.isChosen,
            ["stroke-default"] = not tbl3.isChosen
        },
        testId = tbl3.testId
    }
    local tbl5 = { Input = 0 }
    local element

    if tbl2.fieldType == "Radio" then
        element = React.createElement(
            Foundation.RadioGroup.Item,
            {
                value = tbl3.optionId,
                label = tbl3.label,
                isDisabled = not tbl1.isEditable,
                LayoutOrder = 1
            }
        )
    else
        element = React.createElement(Foundation.Checkbox, {
            label = tbl3.label,
            isChecked = tbl3.isChosen,
            isDisabled = not tbl1.isEditable,
            onActivated = tbl3.onActivated,
            Selectable = false,
            LayoutOrder = 1,
            testId = `{tbl3.testId}--input`
        })
    end

    tbl5.Input = element
    return createElement(view, tbl4, tbl5)
end

local function renderField(tbl1, tbl2, layoutOrder: number)
    local tbl3 = {}
    for k, option in tbl2.options do
        tbl3[option.optionId] = renderOption(tbl1, tbl2, option, k)
    end
    local tbl4 = {}
    for k, error in tbl2.errors do
        tbl4[`Server{k}`] = text(error, k, `{tbl2.testId}--error-{k}`, true)
    end
    tbl4.Required = text(tbl2.requiredMessage, 0, `{tbl2.testId}--required`, true)
    local createElement = React.createElement
    local view = Foundation.View
    local tbl5 = {
        LayoutOrder = layoutOrder,
        tag = "col gap-small size-full-0 auto-y",
        testId = tbl2.testId
    }
    local tbl6 = {
        Label = text(tbl2.label, 1, `{tbl2.testId}--label`),
        Options = 0,
        Errors = 0
    }
    local element

    if tbl2.fieldType == "Radio" and not tbl2.showResults then
        element = React.createElement(Foundation.RadioGroup.Root, {
            value = tbl2.selectedRadio,
            onValueChanged = tbl2.onRadioChanged,
            Selectable = false,
            LayoutOrder = 2,
            testId = `{tbl2.testId}--radio`
        }, tbl3)
    else
        element = React.createElement(Foundation.View, { LayoutOrder = 2, tag = "col gap-small size-full-0 auto-y" }, tbl3)
    end

    tbl6.Options = element

    tbl6.Errors = if next(tbl4) then React.createElement(Foundation.View, { LayoutOrder = 3, tag = "col gap-xsmall size-full-0 auto-y" }, tbl4) else nil
    return createElement(view, tbl5, tbl6)
end

local function CustomFormView(tbl1)
    local testId = tbl1.testId
    local tbl2 = ({})
    for layoutOrder, section in tbl1.sections do
        local tbl3 = {}
        for k2, field in section.fields do
            tbl3[field.fieldId] = renderField(tbl1, field, k2)
        end
        local id = section.id
        tbl2[id] = React.createElement(
            Foundation.View,
            {
                LayoutOrder = layoutOrder,
                tag = "col gap-large size-full-0 auto-y",
                testId = section.testId
            },
            {
                Header = text(section.header, 1, `{section.testId}--header`),
                Fields = React.createElement(Foundation.View, { LayoutOrder = 2, tag = "col gap-large size-full-0 auto-y" }, tbl3)
            }
        )
    end

    local tbl3 = {}
    for k, formError in tbl1.formErrors do
        tbl3[tostring(k)] = text(formError, k, `{testId}--error-{k}`, true)
    end
    tbl3.Invalid = text(tbl1.failureMessage, 0, `{testId}--error`, true)

    local createElement = React.createElement
    local view = Foundation.View
    local tbl4 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-large size-full-0 auto-y padding-large stroke-standard stroke-default radius-medium bg-surface-100",
        testId = testId
    }
    local tbl5 = {
        Title = if tbl1.title and tbl1.title ~= "" then React.createElement(Foundation.Text, {
            Text = tbl1.title,
            LayoutOrder = 1,
            testId = `{testId}--title`,
            tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
        }) else nil,
        Description = text(tbl1.description, 2, `{testId}--description`),
        Sections = React.createElement(Foundation.View, {
            LayoutOrder = 3,
            tag = "col gap-large size-full-0 auto-y",
            testId = `{testId}--sections`,
            onAbsoluteSizeChanged = tbl1.onSectionsSizeChanged
        }, tbl2),
        Summary = if tbl1.summary then React.createElement(Foundation.Text, {
            Text = tbl1.summary,
            LayoutOrder = 4,
            testId = `{testId}--summary`,
            tag = "size-full-0 auto-y text-label-small text-align-x-right content-default"
        }) else nil,
        DisabledMessage = text(tbl1.disabledMessage, 4, `{testId}--disabled`),
        Errors = if next(tbl3) then React.createElement(Foundation.View, { LayoutOrder = 5, tag = "col gap-small size-full-0 auto-y" }, tbl3) else nil,
        Submit = 0
    }
    local element

    if tbl1.submitLabel and tbl1.submitLabel ~= "" then
        element = React.createElement(Foundation.Button, {
            ref = tbl1.submitRef,
            text = tbl1.submitLabel,
            isDisabled = not tbl1.isEditable,
            isLoading = tbl1.isSubmitting,
            onActivated = tbl1.onSubmit,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            LayoutOrder = 6,
            testId = `{testId}--submit`
        })
    else
        element = nil
    end

    tbl5.Submit = element
    return createElement(view, tbl4, tbl5)
end

return CustomFormView
