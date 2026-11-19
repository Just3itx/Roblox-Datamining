-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local Otter = InGameMenuDependencies.Otter
local t = InGameMenuDependencies.t

local scriptParentParent = script.Parent.Parent

local BlurredModalPortal = require(script.Parent.BlurredModalPortal)
local Pages = require(script.Parent.Pages)

local Constants = require(script.Parent.Parent.Resources.Constants)

local tbl1 = ({})
for k, value in pairs(Pages.pagesByKey) do
    tbl1[k] = require(value.component)
end

local withLocalization = require(scriptParentParent.Localization.withLocalization)

local var1 = Roact.PureComponent:extend("PageContainer")
var1.validateProps = t.strictInterface(
    {
        currentPage = t.string,
        visible = t.boolean,
        controllerBarHeight = t.number,
        controllerBarCount = t.number
    }
)
function var1.init(arg1, arg2)
    function arg1.onContainerRendered(selectionParent: Instance, arg3)
        if selectionParent then
            local selectionParentNameFromKey = arg1.getSelectionParentNameFromKey(arg3)
            GuiService:RemoveSelectionGroup(selectionParentNameFromKey)
            GuiService:AddSelectionParent(selectionParentNameFromKey, selectionParent)
        end
    end

    function arg1.getSelectionParentNameFromKey(arg3)
        return arg3 .. "_IGMPageSelectionGroup"
    end

    local tbl2 = ({})
    local tbl3 = ({})
    local tbl4 = ({})
    arg1.pagePositions = {}
    arg1.pageVisibilities = {}
    for k, _ in pairs(Pages.pagesByKey) do
        local num1 = if arg2.currentPage == k then 1 else 0
        local var2, var3 = Roact.createBinding(num1)
        tbl2[k] = var2
        tbl3[k] = var3
        tbl4[k] = num1

        arg1.pagePositions[k] = tbl2[k]:map(function(arg3): UDim2
            return UDim2.new(arg3 - 1, 0, 0, 0)
        end)

        arg1.pageVisibilities[k] = tbl2[k]:map(function(arg3): boolean
            return arg3 ~= 0 and arg3 ~= 1.25
        end)
    end

    arg1.pageMotor = Otter.createGroupMotor(tbl4)
    arg1.pageMotor:onStep(function(arg3)
        for k, value in pairs(arg3) do
            tbl3[k](value)
        end
    end)
end

function var1.render(arg1)
    local tbl2 = ({})

    for k, value in pairs(Pages.pagesByKey) do
        local var2 = arg1.pageVisibilities[k]

        local var3 = withLocalization
        local tbl3 = {
            title = value.title
        }

        tbl2[k] = var3(tbl3)(function(arg2)
            if value.isModal then
                return Roact.createElement(
                    BlurredModalPortal,
                    {
                        Enabled = arg1.props.currentPage == k
                    },
                    {
                        ModalPageContent = Roact.createElement(tbl1[k], { pageTitle = arg2.title })
                    }
                )
            end

            local createElement = Roact.createElement
            local tbl4 = {
                Size = UDim2.new(1, 0, 1, 0),
                Position = arg1.pagePositions[k],
                BackgroundTransparency = 1,
                ZIndex = value.navigationDepth,
                Visible = var2
            }

            tbl4[Roact.Ref] = function(arg3)
                arg1.onContainerRendered(arg3, k)
            end

            return createElement("Frame", tbl4, { Page = Roact.createElement(tbl1[k], { pageTitle = value.title and arg2.title }) })
        end)
    end

    local yOffset = arg1.props.controllerBarCount > 0 and -1 * Constants.ControllerBarHeight or nil
    return Roact.createElement("Frame", {
        Size = UDim2.new(0, 400, 1, yOffset),
        Position = UDim2.new(0, 64, 0, 0),
        BackgroundTransparency = 1,
        Visible = arg1.props.visible,
        ClipsDescendants = true
    }, tbl2)
end

function var1.didUpdate(arg1, arg2, _)
    local currentPage = arg2.currentPage
    local currentPage2 = arg1.props.currentPage

    if currentPage == currentPage2 then
        return
    end

    local isModal = Pages.pagesByKey[currentPage2].isModal
    local isModal2 = Pages.pagesByKey[currentPage].isModal
    if isModal or isModal2 then
        return
    end

    if Pages.pagesByKey[currentPage].navigationDepth < Pages.pagesByKey[currentPage2].navigationDepth then
        if not isModal then
            arg1.pageMotor:setGoal({ [currentPage] = Otter.spring(1.25, { frequency = 2.5 }) })
        end
    elseif Pages.pagesByKey[currentPage].navigationDepth == Pages.pagesByKey[currentPage2].navigationDepth then
        arg1.pageMotor:setGoal({ [currentPage] = Otter.spring(0, { frequency = 2.5 }) })
    else
        local tbl2 = ({})

        while currentPage ~= nil and currentPage ~= currentPage2 do
            tbl2[currentPage] = Otter.spring(0, { frequency = 3.5 })
            currentPage = Pages.pagesByKey[currentPage].parentPage
        end

        arg1.pageMotor:setGoal(tbl2)
    end

    arg1.pageMotor:setGoal({ [currentPage2] = Otter.spring(1, { frequency = 2.5 }) })
end

function var1.willUnmount(arg1)
    for k, value in pairs(Pages.pagesByKey) do
        if not value.isModal then
            local selectionParentNameFromKey = arg1.getSelectionParentNameFromKey(k)
            GuiService:RemoveSelectionGroup(selectionParentNameFromKey)
        end
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1)
    return {
        currentPage = arg1.menuPage,
        visible = arg1.isMenuOpen,
        controllerBarHeight = arg1.controllerBarHeight,
        controllerBarCount = arg1.controllerBarCount
    }
end)(var1)
