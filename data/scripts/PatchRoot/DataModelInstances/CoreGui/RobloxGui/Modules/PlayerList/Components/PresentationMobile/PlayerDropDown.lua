-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local Otter = require(CorePackages.Packages.Otter)
local ReactFocusNavigation = require(CorePackages.Packages.ReactFocusNavigation)
local UIBlox = require(CorePackages.Packages.UIBlox)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local useLayoutValues = PlayerList.Common.useLayoutValues

local scriptParentParent = script.Parent.Parent
local Connection = scriptParentParent.Connection
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues

local DropDownButton = require(script.Parent.DropDownButton)
local DropDownPlayerHeader = require(script.Parent.DropDownPlayerHeader)
local FriendDropDownButton = require(script.Parent.FriendDropDownButton)

local LocalPlayer = Players.LocalPlayer

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local onBlockButtonActivated = require(RobloxGui.Modules.Settings.onBlockButtonActivated)

local Images = UIBlox.App.ImageSet.Images

local isNewInGameMenuEnabled = require(RobloxGui.Modules.isNewInGameMenuEnabled)

local scriptParentParentParent = scriptParentParent.Parent

local ClosePlayerDropDown = require(scriptParentParentParent.Actions.ClosePlayerDropDown)
local SetPlayerListVisibility = require(scriptParentParentParent.Actions.SetPlayerListVisibility)
local FFlagPlayerListReduceRerenders = require(scriptParentParentParent.Flags.FFlagPlayerListReduceRerenders)
local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav

local UnblockPlayer = require(scriptParentParentParent.Thunks.UnblockPlayer)
local RequestFriendship = require(scriptParentParentParent.Thunks.RequestFriendship)
local SetPlayerIsBlocked = require(scriptParentParentParent.Actions.SetPlayerIsBlocked)

local var1 = Roact.PureComponent:extend("PlayerDropDown")

local FFlagStandardizeSafetyIcon = require(CorePackages.Workspace.Packages.SharedFlags).FFlagStandardizeSafetyIcon
local FFlagAllowDisplayingFoundationIconsForDropdown = require(scriptParentParentParent.Flags.FFlagAllowDisplayingFoundationIconsForDropdown)

var1.validateProps = t.strictInterface({
    contentsVisible = t.boolean,
    selectedPlayer = t.optional(t.instanceIsA("Player")),
    isVisible = t.boolean,
    playerRelationship = t.optional(
        t.strictInterface(
            {
                isBlocked = t.boolean,
                friendStatus = t.enum(Enum.FriendStatus),
                isFollowing = t.boolean,
                isFollower = t.boolean
            }
        )
    ),
    inspectMenuEnabled = t.boolean,
    isTenFootInterface = t.boolean,
    isUsingGamepad = t.optional(t.boolean),
    subjectToChinaPolicies = t.boolean,
    preferredTransparency = t.number,
    closeDropDown = t.callback,
    blockPlayerSuccess = t.callback,
    unblockPlayer = t.callback,
    requestFriendship = t.callback,
    setPlayerListVisibility = t.callback,
    focusGuiObject = t.optional(t.callback),
    focusedGuiObject = t.optional(t.instanceIsA("GuiObject")),
    layoutValues = t.optional(t.table)
})

local tbl1 = { dampingRatio = 1, frequency = 4 }

function var1.init(arg1)
    arg1.state = { allVisible = false, contentVisible = false }

    arg1.buttonsContainerRef = React.createRef()

    local containerScale, updateContainerScale = Roact.createBinding(1)
    arg1.containerScale = containerScale
    arg1.updateContainerScale = updateContainerScale
    arg1.containerScaleMotor = Otter.createSingleMotor(0)
    arg1.containerScaleMotor:onStep(function(arg2)
        arg1.updateContainerScale(arg2)
    end)

    local transparency, updateTransparency = Roact.createBinding(1)
    arg1.transparency = transparency
    arg1.updateTransparency = updateTransparency
    arg1.transparencyMotor = Otter.createSingleMotor(0)
    arg1.transparencyMotor:onStep(function(arg2)
        arg1.updateTransparency(arg2)
        if arg2 < 0.5 and arg1.props.isVisible and arg1.props.contentsVisible then
            arg1:setState({ contentVisible = true })
        else
            arg1:setState({ contentVisible = false })
        end

        arg1:setState({ allVisible = arg2 < 1 })
    end)

    local buttonTransparency, updateButtonTransparency = Roact.createBinding(1)
    arg1.buttonTransparency = buttonTransparency
    arg1.updateButtonTransparency = updateButtonTransparency
    arg1.buttonTransparencyMotor = Otter.createSingleMotor(0)
    arg1.buttonTransparencyMotor:onStep(function(arg2)
        arg1.updateButtonTransparency(arg2)
    end)
end

function var1.createFriendButton(arg1, playerRelationship)
    local selectedPlayer = arg1.props.selectedPlayer
    return Roact.createElement(FriendDropDownButton, {
        layoutOrder = 1,
        playerRelationship = playerRelationship,
        selectedPlayer = selectedPlayer,
        dropDownOpen = arg1.props.isVisible,
        requestFriendship = arg1.props.requestFriendship,
        contentVisible = arg1.state.contentVisible,
        isUsingGamepad = arg1.props.isUsingGamepad
    })
end

function var1.createBlockButton(arg1, arg2)
    local selectedPlayer = arg1.props.selectedPlayer
    local var2 = RobloxTranslator:FormatByKey("InGame.PlayerDropDown.Block")
    local var3 = RobloxTranslator:FormatByKey("InGame.PlayerDropDown.UnBlock")
    local iconsActionsBlock = Images["icons/actions/block"]

    local createElement = Roact.createElement
    local var4 = DropDownButton
    local tbl2 = {
        contentVisible = arg1.state.contentVisible,
        buttonTransparency = arg1.buttonTransparency,
        layoutOrder = 4,
        text = 0,
        icon = 0,
        lastButton = false,
        forceShowOptions = false,
        onActivated = 0
    }
    if arg2.isBlocked then
        var2 = var3 or var2
    end

    tbl2.text = var2
    tbl2.icon = iconsActionsBlock

    function tbl2.onActivated()
        if arg2.isBlocked then
            arg1.props.unblockPlayer(selectedPlayer)
            return
        end
        onBlockButtonActivated(selectedPlayer, nil, arg1.__componentName, {
            onBlockingSuccess = function()
                arg1.props.blockPlayerSuccess(selectedPlayer)
            end,
            onBlockingModalClose = FFlagAddNewPlayerListMobileFocusNav and function()
                if arg1.props.isUsingGamepad then
                    arg1.props.focusGuiObject(arg1.buttonsContainerRef.current)
                end
            end or nil
        })
    end

    return createElement(var4, tbl2)
end

function var1.createReportButton(arg1)
    local selectedPlayer = arg1.props.selectedPlayer
    local icon = if FFlagStandardizeSafetyIcon and FFlagAllowDisplayingFoundationIconsForDropdown then "Flag" else Images["icons/actions/feedback"]

    return Roact.createElement(DropDownButton, {
        contentVisible = arg1.state.contentVisible,
        buttonTransparency = arg1.buttonTransparency,
        layoutOrder = 5,
        text = RobloxTranslator:FormatByKey("InGame.PlayerDropDown.Report"),
        icon = icon,
        lastButton = true,
        forceShowOptions = false,
        onActivated = function()
            if isNewInGameMenuEnabled() then
                require(RobloxGui.Modules.InGameMenuInit).openReportDialog(selectedPlayer, arg1.__componentName)
                return
            end
            require(RobloxGui.Modules.Settings.Pages.ReportAbuseMenuContainerPage):ReportPlayer(
                selectedPlayer,
                arg1.__componentName
            )
            arg1.props.closeDropDown()
        end
    })
end

function var1.createInspectButton(arg1)
    local selectedPlayer = arg1.props.selectedPlayer
    local iconsActionsZoomIn = Images["icons/actions/zoomIn"]

    return Roact.createElement(DropDownButton, {
        contentVisible = arg1.state.contentVisible,
        buttonTransparency = arg1.buttonTransparency,
        layoutOrder = 3,
        text = RobloxTranslator:FormatByKey("InGame.PlayerDropDown.Examine"),
        icon = iconsActionsZoomIn,
        lastButton = selectedPlayer == LocalPlayer,
        forceShowOptions = false,
        onActivated = function()
            GuiService:InspectPlayerFromUserIdWithCtx(selectedPlayer.UserId, "leaderBoard")
            arg1.props.closeDropDown()
            arg1.props.setPlayerListVisibility(false)
        end
    })
end

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        arg2 = arg1.props.layoutValues

        local selectedPlayer = arg1.props.selectedPlayer

        if not selectedPlayer or arg1.props.isTenFootInterface then
            return nil
        end

        local tbl2 = ({})

        tbl2.UIScale = Roact.createElement("UIScale", { Scale = arg1.containerScale })

        tbl2.UIListLayout = Roact.createElement(
            "UIListLayout",
            {
                Padding = UDim.new(0, arg2.DropDownButtonPadding),
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )
        tbl2.PlayerHeader = Roact.createElement(
            DropDownPlayerHeader,
            {
                player = arg1.props.selectedPlayer,
                contentVisible = arg1.state.contentVisible,
                transparency = arg1.transparency
            }
        )
        local var2 = 4 * arg2.DropDownButtonSizeY + arg2.DropDownHeaderSizeY
        local var3 = arg2.DropDownButtonPadding + arg2.DropDownHeaderSizeY

        local playerRelationship = arg1.props.playerRelationship
        if selectedPlayer ~= LocalPlayer then
            if not playerRelationship.isBlocked then
                tbl2.FriendButton = arg1:createFriendButton(playerRelationship)
                var3 = var3 + arg2.DropDownButtonPadding + arg2.DropDownButtonSizeY
            end

            tbl2.BlockButton = arg1:createBlockButton(playerRelationship)
            local var4 = var3 + arg2.DropDownButtonPadding + arg2.DropDownButtonSizeY

            tbl2.ReportButton = arg1:createReportButton()
            var3 = var4 + arg2.DropDownButtonPadding + arg2.DropDownButtonSizeY
        end

        if arg1.props.inspectMenuEnabled then
            tbl2.InspectButton = arg1:createInspectButton()
            var3 = var3 + arg2.DropDownButtonPadding + arg2.DropDownButtonSizeY
        end

        local yOffset = var3 - arg2.DropDownButtonPadding

        local createElement = Roact.createElement
        local str1 = "ImageButton"
        local tbl3 = {
            LayoutOrder = arg1.props.layoutOrder,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Selectable = false,
            Modal = false,
            Visible = arg1.state.allVisible,
            AutoButtonColor = false,
            Active = arg1.props.isVisible,
            Image = "",
            SelectionGroup = if FFlagAddNewPlayerListMobileFocusNav then true else nil,
            SelectionBehaviorUp = if FFlagAddNewPlayerListMobileFocusNav then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorDown = if FFlagAddNewPlayerListMobileFocusNav then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorLeft = if FFlagAddNewPlayerListMobileFocusNav then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorRight = if FFlagAddNewPlayerListMobileFocusNav then Enum.SelectionBehavior.Stop else nil,
            [Roact.Event.Activated] = arg1.props.closeDropDown,
            [Roact.Ref] = arg1.imageButtonRef
        }
        local tbl4 = {
            Container = Roact.createElement("Frame", {
                LayoutOrder = arg1.props.layoutOrder,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0.5, -var2 / 2),
                Size = UDim2.new(0, arg2.PlayerDropDownSizeXMobile, 0, yOffset),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                [Roact.Ref] = if FFlagAddNewPlayerListMobileFocusNav then arg1.buttonsContainerRef else nil
            }, tbl2)
        }
        return createElement(str1, tbl3, tbl4)
    end)
end

function var1.getScale(arg1): number
    return if arg1.props.isVisible and arg1.props.contentsVisible then 1 else 1.25
end

function var1.getTransparency(arg1): number
    return if arg1.props.isVisible and arg1.props.contentsVisible then 0 else 1
end

function var1.getButtonTransparency(arg1)
    if arg1.props.isVisible and arg1.props.contentsVisible then
        return arg1.props.preferredTransparency * 0.3
    end

    return 1
end

function var1.didUpdate(arg1, _, arg2)
    arg1.containerScaleMotor:setGoal(Otter.spring(arg1:getScale(), tbl1))
    arg1.transparencyMotor:setGoal(Otter.spring(arg1:getTransparency(), tbl1))
    arg1.buttonTransparencyMotor:setGoal(Otter.spring(arg1:getButtonTransparency(), tbl1))

    if not FFlagAddNewPlayerListMobileFocusNav
        or not arg1.props.isUsingGamepad
        or arg2.contentVisible == arg1.state.contentVisible and arg1.props.focusedGuiObject
        or not arg1.state.contentVisible
        or not arg1.buttonsContainerRef.current
    then
        return
    end

    arg1.props.focusGuiObject(arg1.buttonsContainerRef.current)
    if FFlagAddNewPlayerListMobileFocusNav then
        return
    end

    arg1.buttonsContainerRef.current.SelectionGroup = true
    arg1.buttonsContainerRef.current.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
    arg1.buttonsContainerRef.current.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
    arg1.buttonsContainerRef.current.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
    arg1.buttonsContainerRef.current.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
end

function var1.didMount(_) end

function var1.willUnmount(arg1)
    arg1.transparencyMotor:destroy()
    arg1.containerScaleMotor:destroy()
    arg1.buttonTransparencyMotor:destroy()

    arg1.transparencyMotor = nil
    arg1.containerScaleMotor = nil
    arg1.buttonTransparencyMotor = nil
end

local function mapStateToProps(arg1)
    local selectedPlayer = arg1.playerDropDown.selectedPlayer

    return {
        selectedPlayer = selectedPlayer,
        isVisible = arg1.playerDropDown.isVisible and arg1.displayOptions.isVisible,
        playerRelationship = selectedPlayer and arg1.playerRelationship[selectedPlayer.UserId],
        inspectMenuEnabled = arg1.displayOptions.inspectMenuEnabled,
        isTenFootInterface = arg1.displayOptions.isTenFootInterface,
        isUsingGamepad = if FFlagAddNewPlayerListMobileFocusNav then arg1.displayOptions.isUsingGamepad else nil,
        subjectToChinaPolicies = arg1.displayOptions.subjectToChinaPolicies,
        preferredTransparency = arg1.settings.preferredTransparency
    }
end

local function mapDispatchToProps(arg1)
    return {
        closeDropDown = function()
            return arg1(ClosePlayerDropDown())
        end,
        setPlayerListVisibility = function(arg2)
            return arg1(SetPlayerListVisibility(arg2))
        end,
        blockPlayerSuccess = function(arg2)
            arg1(SetPlayerIsBlocked(arg2, true))
        end,
        unblockPlayer = function(arg2)
            return arg1(UnblockPlayer(arg2))
        end,
        requestFriendship = function(arg2, _)
            return arg1(RequestFriendship(arg2))
        end
    }
end

local function PlayerDropDownWrapper(arg1)
    local layoutValues = useLayoutValues()

    local focusGuiObject = ReactFocusNavigation.useFocusGuiObject()
    local focusedGuiObject = ReactFocusNavigation.useFocusedGuiObject()

    return Roact.createElement(
        var1,
        Cryo.Dictionary.join(
            arg1,
            {
                focusGuiObject = focusGuiObject,
                focusedGuiObject = focusedGuiObject,
                layoutValues = layoutValues
            }
        )
    )
end

if FFlagPlayerListReduceRerenders then
    return React.memo(RoactRodux.connect(mapStateToProps, mapDispatchToProps)(PlayerDropDownWrapper))
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(PlayerDropDownWrapper)
