-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local var1 = if FFlagBuildExperienceAnswerForm then require(BuildExperienceParent.AppBlox).Composer else Foundation.TextInput
local List = Foundation.List
local View = Foundation.View
local FoundationText = Foundation.Text
local Divider = Foundation.Divider
local IconButton = Foundation.IconButton

local function AnswerFormView(tbl1)
    local var2 = if FFlagBuildExperienceAnswerForm then Foundation.Hooks.useTokens() else nil
    local isDisabled = tbl1.isReadOnly == true
    local var3 = tbl1.isSubmitting or isDisabled
    local tbl2 = {}
    for layoutOrder, option in tbl1.options do
        local element = if tbl1.isMultiSelect then React.createElement(
            Foundation.Checkbox,
            {
                label = "",
                isChecked = option.isSelected,
                isDisabled = var3,
                onActivated = option.onActivated,
                Selectable = false
            }
        ) else nil
        local element2 = React.createElement(List.Item, {
            title = option.title,
            description = option.description,
            LayoutOrder = layoutOrder,
            testId = `AnswerForm.Option.{option.id}`,
            trailing = element
        })

        local id = option.id
        local createElement = React.createElement
        local var4 = View
        local tbl3 = {
            LayoutOrder = layoutOrder,
            tag = {
                ["size-full-0 auto-y radius-medium"] = true,
                col = FFlagBuildExperienceAnswerForm
            },
            onActivated = option.onActivated,
            isDisabled = var3,
            selection = {
                Selectable = not var3
            }
        }
        local tbl4 = { Item = 0, Divider = 0 }
        if FFlagBuildExperienceAnswerForm then
            element2 = React.createElement(View, { LayoutOrder = 1, tag = "size-full-0 auto-y padding-x-large" }, element2)
        end

        tbl4.Item = element2
        local element3 = if FFlagBuildExperienceAnswerForm then React.createElement(Divider, { LayoutOrder = 2, testId = `AnswerForm.OptionDivider.{option.id}` }) else nil
        tbl4.Divider = element3
        tbl2[id] = createElement(var4, tbl3, tbl4)
    end

    local element = React.createElement(IconButton, {
        LayoutOrder = 2,
        icon = Foundation.Enums.IconName.X,
        size = Foundation.Enums.InputSize.Small,
        variant = Foundation.Enums.ButtonVariant.Utility,
        isDisabled = isDisabled,
        onActivated = tbl1.onStop,
        testId = "AnswerForm.Close"
    })

    local element2 = React.createElement(var1, {
        LayoutOrder = if FFlagBuildExperienceAnswerForm then 1 else #tbl1.options + 1,
        label = "",
        text = tbl1.customTextBinding or tbl1.customText,
        placeholder = "",
        onChanged = tbl1.onCustomChanged,
        isDisabled = var3,
        width = UDim.new(1, 0),
        maxLines = if FFlagBuildExperienceAnswerForm then 5 else nil,
        size = if FFlagBuildExperienceAnswerForm then Foundation.Enums.InputSize.Medium else Foundation.Enums.InputSize.Large,
        variant = Foundation.Enums.InputVariant.Utility,
        testId = "AnswerForm.CustomInput"
    })

    if tbl1.isCustom then
        if FFlagBuildExperienceAnswerForm then
            element2 = React.createElement(View, {
                LayoutOrder = #tbl1.options + 1,
                padding = {
                    top = UDim.new(0, var2.Size.Size_150),
                    bottom = UDim.new(0, var2.Size.Size_150)
                },
                tag = "size-full-0 auto-y",
                testId = "AnswerForm.CustomRow"
            }, { Input = element2 })
        end
    else
        element2 = React.createElement(View, {
            LayoutOrder = #tbl1.options + 1,
            tag = "size-full-0 auto-y padding-large",
            onActivated = tbl1.onCustomActivated,
            isDisabled = var3,
            testId = "AnswerForm.Custom"
        }, {
            Label = React.createElement(FoundationText, {
                Text = tbl1.customLabel,
                tag = {
                    ["size-full-0 auto-y text-wrap text-align-x-left"] = true,
                    ["text-body-medium content-default"] = FFlagBuildExperienceAnswerForm,
                    ["text-title-small content-emphasis"] = not FFlagBuildExperienceAnswerForm
                }
            })
        })
    end

    tbl2.Custom = element2
    local createElement = React.createElement
    local var4 = View
    local tbl3 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col size-full-0 auto-y stroke-standard stroke-default radius-large bg-surface-0",
        testId = "AnswerForm"
    }

    local tbl4 = {
        Header = 0,
        HeaderDivider = 0,
        Body = 0,
        Error = 0,
        FooterDivider = 0,
        Footer = 0
    }
    local createElement2 = React.createElement
    local var5 = View
    local tbl5 = {
        LayoutOrder = 1,
        testId = "AnswerForm.Header",
        tag = "row align-y-center gap-small size-full-0 auto-y padding-x-large padding-y-small"
    }

    local tbl6 = {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.title,
            tag = "fill auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
        }),
        Close = 0
    }

    if FFlagBuildExperienceAnswerForm then
        element = React.createElement(
            View,
            {
                LayoutOrder = 2,
                Size = UDim2.fromOffset(var2.Size.Size_600, var2.Size.Size_800),
                testId = "AnswerForm.CloseSlot"
            },
            {
                Button = React.createElement(
                    View,
                    {
                        Size = UDim2.fromOffset(var2.Size.Size_800, var2.Size.Size_800),
                        tag = "position-center-center anchor-center-center"
                    },
                    { Button = element }
                )
            }
        )
    end

    tbl6.Close = element
    tbl4.Header = createElement2(var5, tbl5, tbl6)

    tbl4.HeaderDivider = React.createElement(Divider, { LayoutOrder = 2 })
    tbl4.Body = React.createElement(
        View,
        { LayoutOrder = 3, tag = "col size-full-0 auto-y", testId = "AnswerForm.Body" },
        {
            Options = React.createElement(List.Root, {
                LayoutOrder = 1,
                hasDivider = not FFlagBuildExperienceAnswerForm and {
                    hasDivider = true,
                    isInset = false
                } or false,
                isContained = {
                    isContained = false,
                    hasMargin = not FFlagBuildExperienceAnswerForm
                }
            }, tbl2)
        }
    )

    tbl4.Error = if tbl1.errorText == nil then nil else React.createElement(FoundationText, {
        LayoutOrder = 4,
        Text = tbl1.errorText,
        tag = "size-full-0 auto-y padding-x-large text-body-small text-wrap text-align-x-left content-alert",
        testId = "AnswerForm.Error"
    })

    tbl4.FooterDivider = React.createElement(Divider, { LayoutOrder = 5 })
    local createElement3 = React.createElement
    local var6 = View
    local tbl7 = { LayoutOrder = 6, testId = "AnswerForm.Actions", tag = "size-full-1600" }

    local tbl8 = {
        Progress = React.createElement(FoundationText, {
            Text = tbl1.progressText,
            tag = "position-center-center anchor-center-center auto-xy text-body-medium content-default"
        }),
        Forward = 0
    }
    local element3

    if tbl1.showForward then
        element3 = React.createElement(IconButton, {
            icon = {
                name = Foundation.Enums.IconName.ArrowMediumRight,
                variant = Foundation.Enums.IconVariant.Filled
            },
            size = Foundation.Enums.InputSize.Small,
            variant = if tbl1.isForwardDisabled then Foundation.Enums.ButtonVariant.Standard else Foundation.Enums.ButtonVariant.Emphasis,
            isCircular = true,
            Position = UDim2.new(1, -tbl1.footerInset, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            isDisabled = tbl1.isForwardDisabled,
            onActivated = tbl1.onForward,
            testId = "AnswerForm.Forward"
        })
    else
        element3 = nil
    end

    tbl8.Forward = element3
    tbl4.Footer = createElement3(var6, tbl7, tbl8)
    return createElement(var4, tbl3, tbl4)
end

return AnswerFormView
