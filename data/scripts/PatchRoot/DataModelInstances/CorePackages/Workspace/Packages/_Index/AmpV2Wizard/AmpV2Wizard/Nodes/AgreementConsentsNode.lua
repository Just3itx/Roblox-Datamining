-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local Checkbox = Foundation.Checkbox
local Divider = Foundation.Divider
local InputLabel = Foundation.InputLabel
local ScrollView = Foundation.ScrollView
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens

local InlineRichText = require(AmpV2WizardParent.InlineRichText)
local Renderer = InlineRichText.Renderer
local LinkBehavior = InlineRichText.Enums.LinkBehavior
local prepareRichTextCopy = InlineRichText.prepareRichTextCopy

local _Types = require(AmpV2Wizard.Types)
local FullPageChrome = require(AmpV2Wizard.FullPageChrome)

local function renderRow(tbl1, layoutOrder: number)
    return React.createElement(
        View,
        { tag = "row align-y-top gap-medium size-full-0 auto-y", LayoutOrder = layoutOrder },
        {
            Check = React.createElement(Checkbox, {
                label = "",
                isChecked = tbl1.checked[layoutOrder] == true,
                onActivated = function()
                    tbl1.toggleRow(layoutOrder)
                end,
                size = InputSize.Medium,
                testId = `amp-v2-wizard-consent-row-{layoutOrder}`,
                LayoutOrder = 1
            }),
            Label = React.createElement(Renderer, {
                text = tbl1.labels[layoutOrder],
                textStyle = tbl1.textStyle,
                fontStyle = tbl1.fontStyle,
                linkerOptions = tbl1.linkerOptions,
                wrapperProps = {
                    tag = "fill size-full-0 auto-y",
                    LayoutOrder = 2,
                    selection = { Selectable = false },
                    onActivated = function()
                        tbl1.toggleRow(layoutOrder)
                    end
                },
                nodeProps = {
                    LINK = { showUnderline = true }
                }
            })
        }
    )
end

local function renderSection(tbl1, text: string, isRequired: boolean, layoutOrder: number)
    local tbl2 = {}
    for k, row in tbl1.rows do
        if row.isRequired == isRequired then
            tbl2[`Row_{k}`] = renderRow(tbl1, k)
        end
    end

    if next(tbl2) == nil then
        return nil
    end

    return React.createElement(View, {
        tag = "col gap-large size-full-0 auto-y",
        LayoutOrder = layoutOrder
    }, {
        SectionLabel = React.createElement(InputLabel, { Text = text, LayoutOrder = 1 }),
        Rows = React.createElement(View, { tag = "col gap-medium size-full-0 auto-y", LayoutOrder = 2 }, tbl2)
    })
end

local function AgreementConsentsNode(arg1)
    local props = arg1.props
    local report = arg1.report
    local var1 = useTokens()

    local rows = props.rows or {}

    local checked, var4 = React.useState({})

    local num1 = 0
    local num2 = 0
    local num3 = 0
    for value, value2 in rows do
        local bool1 = checked[value] == true
        if bool1 then
            num3 += 1
        end
        if not value2.isRequired then
            continue
        end

        num1 += 1
        if bool1 then
            num2 += 1
        end
    end

    local isChecked = #rows > 0 and num3 == #rows
    local bool2 = num2 == num1

    local onActivated = React.useCallback(function()
        local bool3 = not isChecked
        local tbl1 = ({})
        for value in rows do
            tbl1[value] = bool3
        end
        var4(tbl1)
    end, { isChecked, rows })

    local toggleRow = React.useCallback(function(num4: number)
        var4(function(arg2)
            local var6 = table.clone(arg2)
            var6[num4] = not arg2[num4]
            return var6
        end)
    end, {})

    local var2 = React.useCallback(function()
        local acceptedRows = {}
        for value, value2 in rows do
            if checked[value] then
                table.insert(acceptedRows, { id = value2.id, target = value2.target })
            end
        end
        report("Agree", { acceptedRows = acceptedRows })
    end, { rows, checked, report })

    local var8 = React.useCallback(function()
        report("Back")
    end, { report })

    local linkerOptions = React.useMemo(function()
        return {
            evaluateLinkBehavior = function()
                return LinkBehavior.Webview
            end
        }
    end, {})

    local tbl1 = {
        rows = rows,
        labels = React.useMemo(function()
            local result = ({})
            for value, value2 in rows do
                local label = value2.label
                result[value] = if type(label) ~= "string" then "" else prepareRichTextCopy(value2.label)
            end
            return result
        end, { rows }),
        checked = checked,
        toggleRow = toggleRow,
        linkerOptions = linkerOptions,
        textStyle = var1.Color.Content.Emphasis,
        fontStyle = var1.Typography.BodyMedium
    }

    local bool3 = not (arg1.transitions == nil) and arg1.transitions.Back ~= nil
    local content = React.createElement(View, { tag = "col size-full" }, {
        Body = React.createElement(ScrollView, {
            LayoutOrder = 1,
            flexItem = {
                FlexMode = Enum.UIFlexMode.Fill
            },
            Size = UDim2.fromScale(1, 0),
            scroll = {
                ScrollingDirection = Enum.ScrollingDirection.Y,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.fromScale(0, 1)
            }
        }, {
            Content = React.createElement(View, {
                tag = "col gap-xlarge size-full-0 auto-y padding-x-xlarge padding-y-xlarge"
            }, {
                Intro = React.createElement(View, {
                    tag = "col gap-none size-full-0 auto-y",
                    LayoutOrder = 1
                }, {
                    Title = React.createElement(FoundationText, {
                        Text = props.title,
                        tag = "size-full-0 auto-y text-heading-medium text-wrap text-align-x-left text-align-y-top content-emphasis",
                        LayoutOrder = 1
                    }),
                    Description = React.createElement(FoundationText, {
                        Text = props.description,
                        tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-left text-align-y-top content-default",
                        LayoutOrder = 2
                    })
                }),
                ConsentToAll = React.createElement(Checkbox, {
                    label = props.consentToAllLabel,
                    isChecked = isChecked,
                    onActivated = onActivated,
                    size = InputSize.Medium,
                    testId = "amp-v2-wizard-consent-all",
                    LayoutOrder = 2
                }),
                Separator = React.createElement(Divider, { LayoutOrder = 3 }),
                Required = renderSection(tbl1, props.requiredSectionLabel, true, 4),
                Optional = renderSection(tbl1, props.optionalSectionLabel, false, 5)
            })
        }),
        Footer = React.createElement(
            View,
            {
                tag = "col gap-small size-full-0 auto-y padding-x-xlarge padding-bottom-large",
                LayoutOrder = 2
            },
            {
                Agree = React.createElement(Button, {
                    text = props.agreeLabel,
                    onActivated = var2,
                    isDisabled = not bool2,
                    variant = ButtonVariant.Emphasis,
                    size = InputSize.Medium,
                    width = UDim.new(1, 0),
                    LayoutOrder = 1
                })
            }
        )
    })

    local createElement = React.createElement
    local var10 = FullPageChrome
    local tbl2 = {
        title = props.headerTitle,
        onBack = 0
    }

    if not bool3 then
        var8 = nil
    end

    tbl2.onBack = var8
    return createElement(var10, tbl2, { Content = content })
end

return AgreementConsentsNode
