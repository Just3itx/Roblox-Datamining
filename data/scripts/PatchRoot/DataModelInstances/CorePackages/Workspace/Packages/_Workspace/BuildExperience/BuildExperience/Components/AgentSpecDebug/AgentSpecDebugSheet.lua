-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local FFlagBuildExperienceAdvancedPreviewSpecs = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceAdvancedPreviewSpecs
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local Sheet = Foundation.Sheet
local Button = Foundation.Button
local Divider = Foundation.Divider
local Icon = Foundation.Icon
local Loading = Foundation.Loading
local RadioGroup = Foundation.RadioGroup
local FoundationText = Foundation.Text
local TextInput = Foundation.TextInput
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local computed = Signals.createComputed(function(): string
    return "NotReady"
end)
local computed2 = Signals.createComputed(function()
    return nil
end)

local function getRows(arg1)
    local tbl1 = {{
        value = "default",
        title = "Default (latest)",
        description = nil,
        override = "",
        isPinned = false
    }}

    if arg1 ~= nil then
        local tbl2 = {}
        local tbl3 = {}
        local tbl4 = ({})
        for _, item in arg1.items do
            local value = if item.pinned == CreatorAgentChat.PreviewSpecs.PreviewSpecPinned.Hash then `pr-{item.prNumber}-hash` else `pr-{item.prNumber}`

            if tbl4[value] then
                continue
            end

            tbl4[value] = true
            table.insert(if item.pinned == nil then tbl3 else tbl2, {
                value = value,
                title = if item.title ~= "" then item.title else `PR #{item.prNumber}`,
                description = `#{item.prNumber} \194\183 {item.override}`,
                override = item.override,
                isPinned = item.pinned ~= nil
            })
        end

        for _, value in tbl2 do
            table.insert(tbl1, value)
        end
        for value, value2 in tbl3 do
            if value > 25 then
                break
            end

            table.insert(tbl1, value2)
        end
    end
    return tbl1
end

local function getSelectedValue(tbl1, override: string, str1: string?)
    if CreatorAgentChat.experimentOverride.normalize(override) == "" then
        return "default"
    end
    local str2 = ""
    for _, value in tbl1 do
        if value.value ~= "default" and value.override == override and (str2 == "" or value.value == str1) then
            str2 = value.value
        end
    end
    return str2
end

local function AgentSpecDebugSheet(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local text, onChanged = React.useState(tbl1.specVersion or "")
    local var4 = FFlagBuildExperienceAdvancedPreviewSpecs and tbl1.specName ~= nil
    local var5 = nil
    local var6 = nil
    if FFlagBuildExperienceAdvancedPreviewSpecs then
        var5, var6 = React.useState(tbl1.specName or "build-on-mobile")
    end

    local var7, var8 = React.useState(nil)

    React.useEffect(function()
        var8(CreatorAgentChat.PreviewSpecs.getPreviewSpecsStore(false).refreshPreviewSpecs())
    end, {})
    local var9 = SignalsReact.useSignalState(if var7 ~= nil then var7.status else computed)
    local var10 = SignalsReact.useSignalState(if var7 ~= nil then var7.data else computed2)

    local var11 = React.useMemo(function(): {any}
        return (getRows(var10))
    end, { var10 })

    local var12, var13 = React.useState(nil)
    local onValueChanged = React.useCallback(function(str1: string)
        for _, value in var11 do
            if value.value == str1 then
                onChanged(value.override)
                var13(str1)
                return
            end
        end
    end, { var11 })

    local element

    if var4 and var5 == "build-on-mobile-advanced" then
        element = React.createElement(FoundationText, {
            Text = "Enter the published build-on-mobile-advanced preview hash below.",
            tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-default"
        })
    elseif var9 == "Ready" then
        local yOffset = math.ceil(var1.Typography.TitleMedium.FontSize * var1.Typography.TitleMedium.LineHeight)
        local tbl2 = ({})
        for layoutOrder, value2 in var11 do
            local value3 = value2.value
            local createElement = React.createElement
            local var15 = View
            local tbl3 = { LayoutOrder = layoutOrder, tag = "col size-full-0 auto-y" }

            local tbl4 = { Row = 0, Divider = 0 }
            local createElement2 = React.createElement
            local var16 = View

            local tbl5 = {
                LayoutOrder = 1,
                onActivated = function()
                    onValueChanged(value2.value)
                end,
                tag = "row align-y-center gap-medium size-full-0 auto-y padding-y-small"
            }

            local tbl6 = { Text = 0, Radio = 0 }
            local createElement3 = React.createElement
            local var17 = View
            local tbl7 = { LayoutOrder = 1, tag = "col fill gap-xsmall auto-y" }

            local tbl8 = { TitleRow = 0, Description = 0 }
            local createElement4 = React.createElement
            local var18 = View
            local tbl9 = { LayoutOrder = 1, tag = "row align-y-top gap-xsmall size-full-0 auto-y" }

            local tbl10 = {
                Title = React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 2,
                        Text = value2.title,
                        tag = "auto-xy text-title-medium text-wrap text-align-x-left content-emphasis"
                    }
                ),
                Pin = 0
            }
            local var19

            if value2.isPinned then
                local createElement5 = React.createElement
                local var20 = View
                local tbl11 = {
                    LayoutOrder = 1,
                    Size = UDim2.fromOffset(0, yOffset),
                    tag = "row align-y-center auto-x"
                }
                local tbl12 = {
                    Icon = React.createElement(Icon, { name = IconName.Pin, size = IconSize.XSmall })
                }
                var19 = createElement5(var20, tbl11, tbl12)
            else
                var19 = nil
            end

            tbl10.Pin = var19
            tbl8.TitleRow = createElement4(var18, tbl9, tbl10)
            local element2 = if value2.description then React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = value2.description,
                    tag = "auto-xy text-body-medium text-wrap text-align-x-left"
                }
            ) else nil
            tbl8.Description = element2
            tbl6.Text = createElement3(var17, tbl7, tbl8)

            tbl6.Radio = React.createElement(RadioGroup.Item, { LayoutOrder = 2, label = "", size = InputSize.Medium, value = value2.value })
            tbl4.Row = createElement2(var16, tbl5, tbl6)

            tbl4.Divider = if layoutOrder < #var11 then React.createElement(Divider, { LayoutOrder = 2 }) else nil
            tbl2[value3] = createElement(var15, tbl3, tbl4)
        end

        element = React.createElement(
            RadioGroup.Root,
            {
                onValueChanged = onValueChanged,
                Selectable = false,
                tag = "size-full-0 auto-y",
                value = getSelectedValue(var11, text, var12)
            },
            {
                Rows = React.createElement(View, { tag = "col size-full-0 auto-y" }, tbl2)
            }
        )
    elseif var9 == "Failed" then
        element = React.createElement(
            FoundationText,
            {
                Text = "Preview list unavailable",
                tag = "size-full-0 auto-y text-body-small text-align-x-left content-muted"
            }
        )
    else
        element = React.createElement(View, {
            tag = "row align-y-center gap-small size-full-0 auto-y"
        }, {
            Spinner = React.createElement(Loading, { LayoutOrder = 1, size = IconSize.Small }),
            Label = React.createElement(FoundationText, { LayoutOrder = 2, Text = "Loading previews", tag = "auto-xy text-body-medium" })
        })
    end

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        isOpen = true,
        preferCenterSheet = true,
        onClose = tbl1.onClose,
        ref = tbl1.focusRootRef,
        testId = tbl1.testId
    }
    local tbl3 = {
        Header = React.createElement(Sheet.Header, {
            hasCloseAffordance = tbl1.hasCloseAffordance ~= false
        }, {
            Title = React.createElement(FoundationText, { Text = "Agent Spec", tag = "auto-xy text-heading-small content-emphasis" })
        }),
        Content = React.createElement(Sheet.Content, nil, { List = element }),
        Actions = 0
    }

    local createElement2 = React.createElement
    local actions = Sheet.Actions
    local var15 = nil
    local tbl4 = { Form = 0 }
    local createElement3 = React.createElement
    local var16 = View
    local tbl5 = { tag = "col gap-small size-full-0 auto-y" }

    local tbl6 = { SpecName = 0, Input = 0, Save = 0 }
    local element2

    if var4 then
        element2 = React.createElement(RadioGroup.Root, {
            LayoutOrder = 0,
            value = var5,
            testId = "AgentSpecDebug.SpecName",
            onValueChanged = function(str1: string)
                if str1 == "build-on-mobile" or str1 == "build-on-mobile-advanced" then
                    var6(str1)
                    onChanged("")
                    var13(nil)
                end
            end,
            tag = "size-full-0 auto-y"
        }, {
            Default = React.createElement(
                RadioGroup.Item,
                {
                    LayoutOrder = 1,
                    label = "Default spec",
                    value = "build-on-mobile",
                    testId = "AgentSpecDebug.SpecName.default"
                }
            ),
            Advanced = React.createElement(RadioGroup.Item, {
                LayoutOrder = 2,
                label = "Advanced spec",
                value = "build-on-mobile-advanced",
                testId = "AgentSpecDebug.SpecName.advanced"
            })
        })
    else
        element2 = nil
    end

    tbl6.SpecName = element2

    tbl6.Input = React.createElement(TextInput, {
        LayoutOrder = 1,
        label = "specVersion",
        placeholder = "Leave empty for latest",
        text = text,
        width = UDim.new(1, 0),
        onChanged = onChanged
    })
    tbl6.Save = React.createElement(Button, {
        LayoutOrder = 2,
        text = "Save",
        size = InputSize.Large,
        variant = Foundation.Enums.ButtonVariant.Emphasis,
        width = UDim.new(1, 0),
        onActivated = function()
            tbl1.onSave(text, if var4 and var5 == "build-on-mobile-advanced" then var5 else nil)

            tbl1.onClose()
        end
    })

    tbl4.Form = createElement3(var16, tbl5, tbl6)
    tbl3.Actions = createElement2(actions, var15, tbl4)
    return createElement(root, tbl2, tbl3)
end

return AgentSpecDebugSheet
