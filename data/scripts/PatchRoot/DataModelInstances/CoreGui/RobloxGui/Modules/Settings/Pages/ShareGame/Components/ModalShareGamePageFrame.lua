-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Modules = CoreGui.RobloxGui.Modules

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local ShareGame = Modules.Settings.Pages.ShareGame
local Constants = require(ShareGame.Constants)
local GameInviteEvents = require(CorePackages.Workspace.Packages.GameInvite).GameInviteEvents
local Header = require(ShareGame.Components.Header)
local ConversationList = require(ShareGame.Components.ConversationList)
local ErrorToaster = require(ShareGame.Components.ErrorToaster)
local BackButton = require(ShareGame.Components.BackButton)
local AppCommonLibText = require(CorePackages.Workspace.Packages.AppCommonLib).Text
local Theme = require(RobloxGui.Modules.Settings.Theme)

local GetFFlagEnableNewInviteMenu = require(Modules.Flags.GetFFlagEnableNewInviteMenu)
local GetFFlagEnableNewInviteSendEndpoint = require(Modules.Flags.GetFFlagEnableNewInviteSendEndpoint)

local uDim = UDim.new(0.8, 320)
local uDim2 = UDim.new(0.7, 500)

local uDim3 = UDim.new(0.8, 440)

local black = Color3.fromRGB(41, 41, 41)

local var1 = Roact.PureComponent:extend("ModalShareGamePageFrame")
var1.defaultProps = { isVisible = true }

function var1.init(arg1)
    arg1.state = { promptMessageFitsFrame = true }

    function arg1.onCustomTextAreaSizeChange(arg2)
        local deviceLayout = arg1.props.deviceLayout
        local var2 = Constants.LayoutSpecific[deviceLayout]
        local promptMessage = arg1.props.promptMessage
        local var3 = Theme.textSize(var2.PAGE_TITLE_TEXT_SIZE)
        arg1:setState({
            promptMessageFitsFrame = promptMessage
                and AppCommonLibText.GetTextWidth(promptMessage, Theme.font(Enum.Font.SourceSans), var3) < arg2.AbsoluteSize.X
        })
    end
    arg1.customTextAreaRef = Roact.createRef()

    function arg1.onClosePage()
        arg1.props.closePage()
        if arg1.props.onAfterClosePage then
            arg1.props.onAfterClosePage()
        end
    end
end

function var1.didMount(arg1)
    if GetFFlagEnableNewInviteMenu() and arg1.customTextAreaRef.current then
        arg1.onCustomTextAreaSizeChange(arg1.customTextAreaRef.current)
    end

    if GetFFlagEnableNewInviteSendEndpoint() and arg1.props.promptMessage and arg1.props.analytics then
        arg1.props.analytics:sendEvent(Constants.Triggers.DeveloperMultiple, GameInviteEvents.CustomTextShown)
    end
end

function var1.render(arg1)
    local analytics = arg1.props.analytics
    local deviceLayout = arg1.props.deviceLayout
    local zIndex = arg1.props.zIndex
    local searchAreaActive = arg1.props.searchAreaActive
    local searchText = arg1.props.searchText

    local isVisible = arg1.props.isVisible

    local fFlagEnableNewInviteMenu = GetFFlagEnableNewInviteMenu()
    local uDim4 = if fFlagEnableNewInviteMenu then uDim3 else uDim
    local var2 = fFlagEnableNewInviteMenu
        and arg1.props.deviceInfo
        and arg1.props.deviceInfo.DeviceLayout == Constants.DeviceLayout.PHONE_LANDSCAPE

    local vector2 = Vector2.new(0.5, 0.5)
    local uDim2_2 = UDim2.new(uDim4.Scale, 0, uDim2.Scale, 0)
    local vector2_2 = Vector2.new(uDim4.Offset, uDim2.Offset)
    local uDim2_3 = UDim2.new(0.5, 0, 0.425, 0)
    if var2 then
        vector2 = Vector2.new(0.5, 1)
        uDim2_2 = UDim2.new(uDim4.Scale, 0, 1, 0)
        vector2_2 = Vector2.new(uDim4.Offset, math.huge)
        uDim2_3 = UDim2.new(0.5, 0, 1, 4)
    end

    local var3 = Constants.LayoutSpecific[deviceLayout]
    local promptMessage = arg1.props.promptMessage
    local textSize = Theme.textSize(var3.PAGE_TITLE_TEXT_SIZE)
    local promptMessageFitsFrame = fFlagEnableNewInviteMenu and promptMessage and arg1.state.promptMessageFitsFrame
    local yOffset = if promptMessageFitsFrame then textSize + 10 else 10

    local var5 = if fFlagEnableNewInviteMenu then 40 + yOffset else 60

    local createElement = Roact.createElement
    local str1 = "ImageButton"
    local tbl1 = {
        AnchorPoint = vector2,
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/LuaChat/9-slice/btn-control-sm.png",
        ImageColor3 = black,
        ImageTransparency = 0.1,
        Modal = isVisible,
        Position = uDim2_3,
        Size = uDim2_2,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(Vector2.new(3, 3), Vector2.new(3, 3))
    }
    local tbl2 = {
        sizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = vector2_2 }),
        uiPadding2 = Roact.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15),
                PaddingBottom = UDim.new(0, 15)
            }
        ),
        content = 0
    }
    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        ZIndex = zIndex
    }
    local tbl4 = {
        toasterPortal = Roact.createElement(Roact.Portal, { target = CoreGui }, { Toaster = Roact.createElement(ErrorToaster) }),
        Layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        Padding = if fFlagEnableNewInviteMenu then Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 10) }) else nil,
        Header = Roact.createElement(Header, {
            deviceLayout = deviceLayout,
            size = UDim2.new(1, 0, 0, if fFlagEnableNewInviteMenu then 40 else 60),
            layoutOrder = 0,
            zIndex = zIndex,
            closePage = arg1.onClosePage,
            searchAreaActive = searchAreaActive,
            toggleSearchIcon = true,
            iconType = BackButton.IconType.Cross
        }),
        CustomText = 0,
        ConversationList = 0
    }
    if fFlagEnableNewInviteMenu then
        fFlagEnableNewInviteMenu = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, yOffset),
            TextYAlignment = Enum.TextYAlignment.Top,
            TextSize = textSize,
            TextColor3 = Constants.Color.WHITE,
            Font = Theme.font(Enum.Font.SourceSans),
            BackgroundTransparency = 1,
            Text = if promptMessageFitsFrame then promptMessage else "",
            [Roact.Change.AbsoluteSize] = arg1.onCustomTextAreaSizeChange,
            [Roact.Ref] = arg1.customTextAreaRef
        })
    end

    tbl4.CustomText = fFlagEnableNewInviteMenu

    tbl4.ConversationList = Roact.createElement(ConversationList, {
        analytics = analytics,
        size = UDim2.new(1, 0, 1, -var5),
        topPadding = 10,
        layoutOrder = 1,
        zIndex = zIndex,
        searchText = searchText,
        entryHeight = 62,
        entryPadding = 18,
        isVisible = isVisible,
        trigger = Constants.Triggers.DeveloperMultiple,
        inviteMessageId = arg1.props.inviteMessageId,
        launchData = arg1.props.launchData
    })
    tbl2.content = createElement2(str2, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end

return (RoactRodux.connect(function(arg1)
    return {
        deviceInfo = arg1.DeviceInfo
    }
end)(var1))
