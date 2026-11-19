-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local TextService = game:GetService("TextService")

local SetActiveTab = require(script.Parent.Parent.Actions.SetActiveTab)

local TabRowButton = require(script.Parent.TabRowButton)
local DropDown = require(script.Parent.DropDown)
local FullScreenDropDownButton = require(script.Parent.FullScreenDropDownButton)

local Constants = require(script.Parent.Parent.Constants)
local TabDropDownWidth = Constants.TabRowFormatting.TabDropDownWidth
local TabOverlapThreshold = Constants.TabRowFormatting.TabOverlapThreshold

local var1 = Roact.Component:extend("TabRowContainer")

local function initTabList(tabList)
    local tbl1 = ({})
    local num1 = 0
    local num2 = 0
    for k, _ in pairs(tabList) do
        local vector2 = TextService:GetTextSize(k, Constants.DefaultFontSize.TabBar, Constants.Font.TabBar, Vector2.new(0, 0))
        tbl1[k] = vector2.X
        num1 += vector2.X
        num2 += 1
    end
    return tbl1, num1, num2
end

function var1.init(arg1)
    local tabList = arg1.props.tabList

    local textWidths, totalTextLength, totalTabCount = initTabList(tabList)

    arg1.state = {
        textWidths = textWidths,
        totalTextLength = totalTextLength,
        totalTabCount = totalTabCount,
        currContainerWidth = 0
    }

    function arg1.onTabButtonClicked(layoutOrder)
        for k, value in pairs(arg1.props.tabList) do
            if value.layoutOrder == layoutOrder then
                arg1.props.dispatchSetActiveTab(k, value.hasClientServer)
                return
            end
        end
    end
end

function var1.didUpdate(arg1, arg2, _)
    if arg2.tabList == arg1.props.tabList then
        return
    end

    local textWidths, totalTextLength, totalTabCount = initTabList(arg1.props.tabList)
    arg1:setState({ textWidths = textWidths, totalTextLength = totalTextLength, totalTabCount = totalTabCount })
end

function var1.render(arg1)
    local tabList = arg1.props.tabList
    local currTabIndex = arg1.props.currTabIndex
    local formFactor = arg1.props.formFactor
    local windowWidth = arg1.props.windowWidth
    local frameHeight = arg1.props.frameHeight
    local layoutOrder = arg1.props.layoutOrder

    local textWidths = arg1.state.textWidths
    local totalTextLength = arg1.state.totalTextLength
    local totalTabCount = arg1.state.totalTabCount
    local tbl1 = ({})

    local padding = (windowWidth - totalTextLength) / totalTabCount

    local xOffset = padding % 1 * totalTabCount / 2
    local bool1 = padding < TabOverlapThreshold and windowWidth > 0
    local bool2 = formFactor == Constants.FormFactor.Small

    if tabList then
        if bool1 or bool2 then
            local dropDownList = {}
            local layoutOrder2 = tabList[currTabIndex].layoutOrder

            for k, value in pairs(tabList) do
                dropDownList[value.layoutOrder] = k
            end

            if bool2 then
                return Roact.createElement(FullScreenDropDownButton, {
                    buttonSize = UDim2.new(0, TabDropDownWidth, 0, frameHeight),
                    dropDownList = dropDownList,
                    selectedIndex = layoutOrder2,
                    onSelection = arg1.onTabButtonClicked,
                    layoutOrder = layoutOrder
                })
            end

            if bool1 then
                return Roact.createElement(DropDown, {
                    buttonSize = UDim2.new(0, TabDropDownWidth, 0, frameHeight),
                    dropDownList = dropDownList,
                    selectedIndex = layoutOrder2,
                    onSelection = arg1.onTabButtonClicked
                })
            end
        else
            for name, value in pairs(tabList) do
                if not textWidths[name] then
                    continue
                end

                local createElement = Roact.createElement
                local var3 = TabRowButton
                local tbl2 = {
                    index = value.layoutOrder,
                    name = name,
                    padding = padding,
                    textWidth = bool1 and TabDropDownWidth or textWidths[name],
                    isSelected = name == currTabIndex,
                    layoutOrder = value.layoutOrder,
                    onTabButtonClicked = arg1.onTabButtonClicked
                }
                tbl1[name] = createElement(var3, tbl2)
            end
        end

        tbl1.UIListLayout = Roact.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            FillDirection = Enum.FillDirection.Horizontal
        })
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, frameHeight),
        Position = UDim2.new(0, xOffset, 0, 0),
        Transparency = 1,
        LayoutOrder = layoutOrder
    }, tbl1)
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        tabList = arg1.MainView.tabList,
        currTabIndex = arg1.MainView.currTabIndex
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetActiveTab = function(arg1, arg2)
            callback(SetActiveTab(arg1, arg2))
        end
    }
end)(var1)
