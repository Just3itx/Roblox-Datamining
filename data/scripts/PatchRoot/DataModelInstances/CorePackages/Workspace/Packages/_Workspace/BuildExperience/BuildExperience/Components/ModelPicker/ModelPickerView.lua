-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local FFlagBuildExperienceAdvancedPreviewSpecs = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceAdvancedPreviewSpecs
local AgentSpecDebugSheet = if require(BuildExperience.Flags.FFlagBuildExperienceModelPicker) then require(BuildExperience.Components.AgentSpecDebug.AgentSpecDebugSheet) else nil
local _ModelPickerTypes = require(script.Parent.ModelPickerTypes)

local Chip = Foundation.Chip
local IconButton = Foundation.IconButton
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local function Option(tbl1)
    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        onActivated = tbl1.onActivated,
        isDisabled = tbl1.isDisabled,
        selection = {
            Selectable = not tbl1.isDisabled
        },
        cursor = Foundation.Enums.CursorType.RoundedRectNoInset,
        GroupTransparency = if tbl1.isDisabled then 0.5 else 0,
        tag = {
            ["col gap-xxsmall size-full-0 auto-y padding-medium stroke-standard radius-medium"] = true,
            ["stroke-system-contrast"] = tbl1.isSelected,
            ["stroke-emphasis"] = not tbl1.isSelected
        },
        testId = tbl1.testId
    }, {
        Label = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.label,
            tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
        }),
        Description = if tbl1.description then React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = tbl1.description,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
        }) else nil
    })
end

local function ModelPickerView(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local element = nil
    local internalTesting = tbl1.internalTesting
    local isSelected = not (internalTesting == nil) and internalTesting.isSelected
    local previewHash = if internalTesting then internalTesting.previewHash else nil
    local bool1 = not (previewHash == nil) and previewHash ~= ""

    if tbl1.isOpen then
        local tbl2 = ({})
        for layoutOrder, option in tbl1.data.options do
            local id = option.id
            local createElement = React.createElement
            local func1 = Option
            local tbl3 = {
                LayoutOrder = layoutOrder,
                label = option.label,
                description = if option.isAvailable then option.description else tbl1.unavailableText,
                isDisabled = tbl1.isDisabled or not option.isAvailable,
                isSelected = not isSelected and tbl1.selectedId == option.id,
                onActivated = 0,
                testId = 0
            }

            function tbl3.onActivated()
                tbl1.onSelect(option.id)
            end
            tbl3.testId = `ModelPicker.Option.{option.id}`
            tbl2[id] = createElement(func1, tbl3)
        end

        local createElement = React.createElement
        local var2 = View
        local tbl3 = {
            tag = "col items-stretch gap-medium size-full-0 auto-y padding-y-xsmall",
            testId = "ModelPicker.Options"
        }

        local tbl4 = {
            Options = React.createElement(React.Fragment, nil, tbl2),
            Unavailable = if #tbl1.data.options == 0 then React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.unavailableText,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left"
            }) else nil,
            InternalTesting = if internalTesting then React.createElement(Option, {
                LayoutOrder = #tbl1.data.options + 2,
                label = internalTesting.label,
                description = internalTesting.description,
                isDisabled = tbl1.isDisabled,
                isSelected = isSelected,
                onActivated = internalTesting.onSelect,
                testId = "ModelPicker.InternalTesting"
            }) else nil,
            InternalSpec = 0
        }
        local var3

        if internalTesting and isSelected then
            local createElement2 = React.createElement
            local var4 = View
            local tbl5 = {
                LayoutOrder = #tbl1.data.options + 3,
                tag = "col gap-small size-full-0 auto-y"
            }
            local tbl6 = {
                Label = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = internalTesting.specLabel,
                    fontStyle = var1.Typography.TitleMedium,
                    selection = { Selectable = false },
                    stateLayer = {
                        affordance = Foundation.Enums.StateLayerAffordance.None
                    },
                    tag = {
                        ["size-full-0 auto-y text-wrap text-align-x-left"] = true,
                        ["content-emphasis"] = not tbl1.isDisabled,
                        ["content-muted"] = tbl1.isDisabled
                    },
                    testId = "ModelPicker.InternalSpec--label"
                }),
                Button = 0,
                Hint = 0
            }

            local createElement3 = React.createElement
            local var5 = View
            local tbl7 = {
                LayoutOrder = 2,
                tag = "size-full-1000 stroke-standard stroke-emphasis radius-medium clip",
                testId = "ModelPicker.InternalSpec--container"
            }

            local tbl8 = { Open = 0, Clear = 0 }
            local createElement4 = React.createElement
            local var6 = View
            local tbl9 = {
                ZIndex = 1,
                onActivated = internalTesting.onOpenSpec,
                isDisabled = tbl1.isDisabled,
                selection = {
                    Selectable = not tbl1.isDisabled
                },
                cursor = Foundation.Enums.CursorType.RoundedRectNoInset,
                GroupTransparency = if tbl1.isDisabled then 0.5 else 0,
                padding = {
                    left = UDim.new(0, var1.Padding.Small),
                    right = UDim.new(0, var1.Padding.Small + var1.Size.Size_800)
                },
                tag = "size-full radius-medium",
                testId = "ModelPicker.InternalSpec"
            }

            local tbl10 = { Value = 0 }
            local createElement5 = React.createElement
            local var7 = FoundationText
            local tbl11 = { Text = 0, tag = 0, testId = "ModelPicker.InternalSpec--value" }
            if previewHash == nil or previewHash == "" then
                previewHash = internalTesting.placeholder
            end

            tbl11.Text = previewHash

            tbl11.tag = {
                ["size-full text-body-medium text-align-x-left text-truncate-end"] = true,
                ["content-emphasis"] = bool1,
                ["content-muted"] = not bool1
            }
            tbl10.Value = createElement5(var7, tbl11)
            tbl8.Open = createElement4(var6, tbl9, tbl10)

            tbl8.Clear = React.createElement(IconButton, {
                ZIndex = 2,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -var1.Padding.Small, 0.5, 0),
                icon = Foundation.Enums.IconName.X,
                size = Foundation.Enums.InputSize.Small,
                variant = Foundation.Enums.ButtonVariant.Utility,
                isDisabled = tbl1.isDisabled or not bool1,
                onActivated = internalTesting.onClearSpec,
                testId = "ModelPicker.InternalSpec--clear"
            })
            tbl6.Button = createElement3(var5, tbl7, tbl8)

            tbl6.Hint = React.createElement(FoundationText, {
                LayoutOrder = 3,
                Text = internalTesting.hint,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-default"
            })
            var3 = createElement2(var4, tbl5, tbl6)
        else
            var3 = nil
        end

        tbl4.InternalSpec = var3
        element = createElement(var2, tbl3, tbl4)

        if #tbl1.data.options == 0 and internalTesting == nil then
            element = React.createElement(
                FoundationText,
                {
                    Text = tbl1.unavailableText,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left"
                }
            )
        end
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var2 = nil
    local tbl2 = {
        Chip = React.createElement(
            View,
            {
                LayoutOrder = tbl1.LayoutOrder,
                tag = "auto-xy stroke-standard stroke-default radius-circle"
            },
            {
                Control = React.createElement(Chip, {
                    text = tbl1.label,
                    trailing = Foundation.Enums.IconName.ChevronLargeDown,
                    size = Foundation.Enums.ChipSize.Medium,
                    variant = Foundation.Enums.ChipVariant.Utility,
                    isDisabled = tbl1.isDisabled,
                    onActivated = tbl1.onOpen,
                    testId = "ModelPicker.Chip"
                })
            }
        ),
        AgentSpecSheet = 0,
        Sheet = 0
    }
    local element2

    if tbl1.isSpecOpen and internalTesting then
        element2 = React.createElement(AgentSpecDebugSheet, {
            specVersion = internalTesting.previewHash,
            specName = if FFlagBuildExperienceAdvancedPreviewSpecs then internalTesting.previewSpecName or "build-on-mobile" else nil,
            onSave = internalTesting.onSaveSpec,
            onClose = tbl1.onCloseSpec,
            focusRootRef = tbl1.focusRootRef,
            hasCloseAffordance = tbl1.hasCloseAffordance,
            testId = "ModelPicker.AgentSpecSheet"
        })
    else
        element2 = nil
    end

    tbl2.AgentSpecSheet = element2
    local var3

    if tbl1.isOpen then
        local createElement2 = React.createElement
        local root = Sheet.Root
        local tbl3 = {
            isOpen = true,
            preferCenterSheet = true,
            onClose = tbl1.onClose,
            ref = tbl1.focusRootRef,
            testId = "ModelPicker.Sheet"
        }
        local tbl4 = {
            Header = React.createElement(Sheet.Header, {
                hasCloseAffordance = if tbl1.hasCloseAffordance then nil else false
            }, {
                Title = React.createElement(
                    FoundationText,
                    {
                        Text = tbl1.title,
                        tag = "shrink auto-xy text-heading-small text-wrap text-align-x-left content-emphasis"
                    }
                )
            }),
            Content = React.createElement(Sheet.Content, nil, { Body = element })
        }
        var3 = createElement2(root, tbl3, tbl4)
    else
        var3 = nil
    end

    tbl2.Sheet = var3
    return createElement(fragment, var2, tbl2)
end

return ModelPickerView
