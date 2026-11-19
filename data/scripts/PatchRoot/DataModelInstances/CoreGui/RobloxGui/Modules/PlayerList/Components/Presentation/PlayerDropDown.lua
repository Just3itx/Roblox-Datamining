-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local Otter = require(CorePackages.Packages.Otter)
local UIBlox = require(CorePackages.Packages.UIBlox)

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
local FFlagPlayerListReduceRerenders = require(scriptParentParentParent.Flags.FFlagPlayerListReduceRerenders)

local UnblockPlayer = require(scriptParentParentParent.Thunks.UnblockPlayer)
local RequestFriendship = require(scriptParentParentParent.Thunks.RequestFriendship)
local SetPlayerIsBlocked = require(scriptParentParentParent.Actions.SetPlayerIsBlocked)

local var1 = Roact.PureComponent:extend("PlayerDropDown")

local FFlagStandardizeSafetyIcon = require(CorePackages.Workspace.Packages.SharedFlags).FFlagStandardizeSafetyIcon
local FFlagAllowDisplayingFoundationIconsForDropdown = require(scriptParentParentParent.Flags.FFlagAllowDisplayingFoundationIconsForDropdown)

var1.validateProps = t.strictInterface({
    positionY = t.number,
    minPositionBoundY = t.number,
    maxPositionBoundY = t.number,
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
    subjectToChinaPolicies = t.boolean,
    closeDropDown = t.callback,
    blockPlayerSuccess = t.callback,
    unblockPlayer = t.callback,
    requestFriendship = t.callback
})

function var1.init(arg1)
    arg1.innerFrameRef = Roact.createRef()

    arg1.motorOptions = { dampingRatio = 1, frequency = 4 }

    arg1.motor = Otter.createSingleMotor(1)
    arg1.motor:onStep(function(arg2)
        local current = arg1.innerFrameRef.current

        if not current then
            return
        end

        if arg2 == 1 then
            current.Visible = false
        else
            current.Visible = true
        end
        current.Position = UDim2.new(arg2, 0, 0, 0)
    end)

    arg1.dropDownPosition = 0
end

function var1.createFriendButton(arg1, playerRelationship)
    local selectedPlayer = arg1.props.selectedPlayer
    return Roact.createElement(FriendDropDownButton, {
        layoutOrder = 1,
        playerRelationship = playerRelationship,
        selectedPlayer = selectedPlayer,
        dropDownOpen = arg1.props.isVisible,
        requestFriendship = arg1.props.requestFriendship,
        contentVisible = true
    })
end

function var1.createBlockButton(arg1, arg2)
    local selectedPlayer = arg1.props.selectedPlayer
    local var2 = RobloxTranslator:FormatByKey("InGame.PlayerDropDown.Block")
    local var3 = RobloxTranslator:FormatByKey("InGame.PlayerDropDown.UnBlock")
    local iconsActionsBlock = Images["icons/actions/block"]

    local createElement = Roact.createElement
    local var4 = DropDownButton
    local tbl1 = {
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

    tbl1.text = var2
    tbl1.icon = iconsActionsBlock

    function tbl1.onActivated()
        if arg2.isBlocked then
            arg1.props.unblockPlayer(selectedPlayer)
            return
        end
        onBlockButtonActivated(selectedPlayer, nil, arg1.__componentName, {
            onBlockingSuccess = function()
                arg1.props.blockPlayerSuccess(selectedPlayer)
            end
        })
    end

    return createElement(var4, tbl1)
end

function var1.createReportButton(arg1)
    local selectedPlayer = arg1.props.selectedPlayer
    local icon = if FFlagStandardizeSafetyIcon and FFlagAllowDisplayingFoundationIconsForDropdown then "Flag" else Images["icons/actions/feedback"]

    return Roact.createElement(DropDownButton, {
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
        layoutOrder = 3,
        text = RobloxTranslator:FormatByKey("InGame.PlayerDropDown.Examine"),
        icon = iconsActionsZoomIn,
        lastButton = selectedPlayer == LocalPlayer,
        forceShowOptions = false,
        onActivated = function()
            GuiService:InspectPlayerFromUserIdWithCtx(selectedPlayer.UserId, "leaderBoard")
            arg1.props.closeDropDown()
        end
    })
end

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        local selectedPlayer = arg1.props.selectedPlayer

        if not selectedPlayer or arg1.props.isTenFootInterface then
            return nil
        end

        local tbl1 = ({})

        tbl1.UIListLayout = Roact.createElement(
            "UIListLayout",
            {
                Padding = UDim.new(0, arg2.DropDownButtonPadding),
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )
        tbl1.PlayerHeader = Roact.createElement(DropDownPlayerHeader, { player = arg1.props.selectedPlayer })

        local var2 = arg2.DropDownButtonPadding + arg2.DropDownHeaderSizeY

        local playerRelationship = arg1.props.playerRelationship
        if selectedPlayer ~= LocalPlayer then
            if not playerRelationship.isBlocked then
                tbl1.FriendButton = arg1:createFriendButton(playerRelationship)
                var2 = var2 + arg2.DropDownButtonPadding + arg2.DropDownButtonSizeY
            end

            tbl1.BlockButton = arg1:createBlockButton(playerRelationship)
            local var3 = var2 + arg2.DropDownButtonPadding + arg2.DropDownButtonSizeY

            tbl1.ReportButton = arg1:createReportButton()
            var2 = var3 + arg2.DropDownButtonPadding + arg2.DropDownButtonSizeY
        end

        if arg1.props.inspectMenuEnabled then
            tbl1.InspectButton = arg1:createInspectButton()
            var2 = var2 + arg2.DropDownButtonPadding + arg2.DropDownButtonSizeY
        end

        local yOffset = var2 - arg2.DropDownButtonPadding

        local yOffset2 = arg1.dropDownPosition + (arg2.DropDownHeaderBackgroundSize - arg2.DropDownHeaderSizeY)
        if yOffset2 + yOffset > arg1.props.maxPositionBoundY then
            yOffset2 -= yOffset2 + yOffset - arg1.props.maxPositionBoundY
        elseif yOffset2 < arg1.props.minPositionBoundY then
            yOffset2 += arg1.props.minPositionBoundY - yOffset2
        end

        local createElement = Roact.createElement
        local tbl2 = {
            LayoutOrder = arg1.props.layoutOrder,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(0, 0, 0, yOffset2),
            Size = UDim2.new(0, arg2.PlayerDropDownSizeX + arg2.PlayerDropDownOffset, 0, yOffset),
            BackgroundTransparency = 1,
            ClipsDescendants = true
        }

        local tbl3 = {
            InnerFrame = Roact.createElement("Frame", {
                Size = UDim2.new(1, -arg2.PlayerDropDownOffset, 1, 0),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                [Roact.Ref] = arg1.innerFrameRef
            }, tbl1)
        }
        return createElement("Frame", tbl2, tbl3)
    end)
end

function var1.getDropDownPosition(arg1): number
    return if arg1.props.isVisible and arg1.props.contentsVisible then 0 else 1
end

function var1.didMount(arg1)
    local dropDownPosition = arg1:getDropDownPosition()
    arg1.motor:start()
    arg1.motor:setGoal(Otter.spring(dropDownPosition, arg1.motorOptions))
end

function var1.willUpdate(arg1, arg2, _)
    arg1.dropDownPosition = arg2.positionY
end

function var1.didUpdate(arg1, arg2, _)
    if arg2.selectedPlayer ~= arg1.props.selectedPlayer then
        arg1.motor:setGoal(Otter.instant(1))
        arg1.motor:step(0)
    end

    local dropDownPosition = arg1:getDropDownPosition()
    arg1.motor:setGoal(Otter.spring(dropDownPosition, arg1.motorOptions))
end

function var1.willUnmount(arg1)
    arg1.motor:destroy()
end

local function mapStateToProps(arg1)
    local selectedPlayer = arg1.playerDropDown.selectedPlayer
    return {
        selectedPlayer = selectedPlayer,
        isVisible = arg1.playerDropDown.isVisible and arg1.displayOptions.isVisible,
        playerRelationship = selectedPlayer and arg1.playerRelationship[selectedPlayer.UserId],
        inspectMenuEnabled = arg1.displayOptions.inspectMenuEnabled,
        isTenFootInterface = arg1.displayOptions.isTenFootInterface,
        subjectToChinaPolicies = arg1.displayOptions.subjectToChinaPolicies
    }
end

local function mapDispatchToProps(arg1)
    return {
        closeDropDown = function()
            return arg1(ClosePlayerDropDown())
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

if FFlagPlayerListReduceRerenders then
    return React.memo(RoactRodux.connect(mapStateToProps, mapDispatchToProps)(var1))
end

return RoactRodux.UNSTABLE_connect2(mapStateToProps, mapDispatchToProps)(var1)
