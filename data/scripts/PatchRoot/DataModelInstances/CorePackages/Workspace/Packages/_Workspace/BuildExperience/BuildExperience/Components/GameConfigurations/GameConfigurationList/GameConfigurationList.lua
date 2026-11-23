-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local FFlagBuildExperienceConfigurationRowTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceConfigurationRowTelemetry)

local Icon = Foundation.Icon
local List = Foundation.List
local FoundationText = Foundation.Text
local View = Foundation.View

local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local function GameConfigurationListItem(tbl1)
    local row = tbl1.row
    local bool1 = row.isDisabled == true
    local onActivated = row.onActivated
    local onRowActivated = if FFlagBuildExperienceConfigurationRowTelemetry then tbl1.onRowActivated else nil
    local id = row.id
    local useCallback = React.useCallback
    local function func1()
        if FFlagBuildExperienceConfigurationRowTelemetry and onRowActivated ~= nil then
            onRowActivated(id)
        end
        if onActivated ~= nil then
            onActivated()
        end
    end

    local var1 = if FFlagBuildExperienceConfigurationRowTelemetry then id else nil
    local var2 = useCallback(func1, { onActivated, onRowActivated, var1 })
    local trailing = if row.trailingIcon then React.createElement(Icon, {
        name = row.trailingIcon,
        size = IconSize.Large,
        tag = "auto-xy content-default",
        testId = `{tbl1.testId}-trailing-icon`
    }) else nil
    local createElement = React.createElement
    local item = List.Item
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        title = row.title,
        description = row.description,
        trailing = trailing,
        onActivated = 0,
        testId = 0
    }
    if onActivated == nil or bool1 then
        var2 = nil
    end

    tbl2.onActivated = var2
    tbl2.testId = tbl1.testId
    local element2 = createElement(item, tbl2)

    if not bool1 then
        return element2
    end

    return React.createElement("CanvasGroup", {
        LayoutOrder = tbl1.LayoutOrder,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        GroupTransparency = 0.5
    }, { Item = element2 })
end

local function GameConfigurationList(tbl1)
    local testId = tbl1.testId or "game-configuration-list"
    local useMemo = React.useMemo
    local function func1()
        local result = ({})
        for layoutOrder, row in tbl1.rows do
            local id = row.id
            result[id] = React.createElement(GameConfigurationListItem, {
                LayoutOrder = layoutOrder,
                row = row,
                onRowActivated = if FFlagBuildExperienceConfigurationRowTelemetry then tbl1.onRowActivated else nil,
                testId = `{testId}-row-{row.id}`
            })
        end
        return result
    end

    local rows = tbl1.rows
    local onRowActivated = if FFlagBuildExperienceConfigurationRowTelemetry then tbl1.onRowActivated else nil
    local var1 = useMemo(func1, { rows, testId, onRowActivated })

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-medium size-full-0 auto-y",
        testId = testId
    }
    local tbl3 = {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col gap-xsmall size-full-0 auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.title,
                tag = "size-full-0 auto-y text-title-large text-align-x-left content-default",
                testId = `{testId}-title`
            }),
            Body = if tbl1.body then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.body,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-default",
                testId = `{testId}-body`
            }) else nil
        }),
        Rows = React.createElement(
            List.Root,
            {
                LayoutOrder = 2,
                hasDivider = { hasDivider = true, isInset = false },
                isContained = true,
                size = InputSize.Medium
            },
            var1
        )
    }
    return createElement(var2, tbl2, tbl3)
end

return GameConfigurationList
