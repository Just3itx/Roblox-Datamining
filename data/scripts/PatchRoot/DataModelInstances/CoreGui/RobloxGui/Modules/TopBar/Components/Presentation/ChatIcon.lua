-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local VRService = game:GetService("VRService")
local _AppStorageService = game:GetService("AppStorageService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local _Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal

local withStyle = UIBlox.Core.Style.withStyle
local Badge = UIBlox.App.Indicator.Badge
local BadgeStates = UIBlox.App.Indicator.Enum.BadgeStates
local Images = UIBlox.App.ImageSet.Images

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local ChatSelector = require(RobloxGui.Modules.ChatSelector)
local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)

local IconButton = require(script.Parent.IconButton)

local scriptParentParentParent = script.Parent.Parent.Parent
local Analytics = require(scriptParentParentParent.Analytics)
local var1 = require(scriptParentParentParent.Flags.GetFFlagEnableTopBarAnalytics)()
local SetKeepOutArea = require(scriptParentParentParent.Actions.SetKeepOutArea)
local RemoveKeepOutArea = require(scriptParentParentParent.Actions.RemoveKeepOutArea)
local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas
local Constants = require(scriptParentParentParent.Constants)

local _ChatIconFtuxTooltip = require(script.Parent.ChatIconFtuxTooltip)
local getExperienceChatVisualConfig = require(CorePackages.Workspace.Packages.ExpChat).getExperienceChatVisualConfig
game:DefineFastInt("InExperienceChatTooltipShowDelayMs", 1000)
game:DefineFastInt("InExperienceChatTooltipDismissDelayMs", 7000)
local GameSettings = UserSettings().GameSettings

local function shouldShowEmptyBadge(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService
end

local var2 = Roact.PureComponent:extend("ChatIcon")

var2.validateProps = t.strictInterface({
    layoutOrder = t.integer,
    chatVisible = t.boolean,
    unreadMessages = t.integer,
    topBarEnabled = t.boolean,
    chatEnabled = t.boolean,
    setKeepOutArea = if FFlagTopBarSignalizeKeepOutAreas then nil else t.callback,
    removeKeepOutArea = if FFlagTopBarSignalizeKeepOutAreas then nil else t.callback
})

function var2.init(arg1)
    arg1.buttonRef = Roact.createRef()

    function arg1.chatIconActivated()
        ChatSelector:ToggleVisibility()
        GameSettings.ChatVisible = ChatSelector:GetVisibility()
        if var1 then
            Analytics.default:onChatButtonActivated(GameSettings.ChatVisible)
        end
    end

    if FFlagTopBarSignalizeKeepOutAreas then
        arg1.keepOutAreasStore = CoreGuiCommon.Stores.GetKeepOutAreasStore(false)
    end
end

function var2.render(arg1)
    return withStyle(function(_)
        local var3 = arg1.props.topBarEnabled and arg1.props.chatEnabled and not (TenFootInterface:IsEnabled() or VRService.VREnabled)

        local experienceChatVisualConfig = getExperienceChatVisualConfig()
        local iconSize = experienceChatVisualConfig.iconSize
        local var4 = Images[experienceChatVisualConfig.icon.on]
        if not arg1.props.chatVisible then
            var4 = Images[experienceChatVisualConfig.icon.off]
        end

        local function func1(arg2)
            if var3 and arg2 then
                if FFlagTopBarSignalizeKeepOutAreas then
                    arg1.keepOutAreasStore.setKeepOutArea(Constants.ChatIconKeepOutAreaId, arg2.AbsolutePosition, arg2.AbsoluteSize)
                    return
                end
                arg1.props.setKeepOutArea(Constants.ChatIconKeepOutAreaId, arg2.AbsolutePosition, arg2.AbsoluteSize)
            elseif FFlagTopBarSignalizeKeepOutAreas then
                arg1.keepOutAreasStore.removeKeepOutArea(Constants.ChatIconKeepOutAreaId)
            else
                arg1.props.removeKeepOutArea(Constants.ChatIconKeepOutAreaId)
            end
        end

        local function func2(current)
            if current then
                arg1.buttonRef.current = current
                func1(arg1.buttonRef.current)
            end
        end
        if arg1.buttonRef.current then
            func1(arg1.buttonRef.current)
        end

        local background = Roact.createElement(IconButton, {
            icon = var4,
            iconSize = iconSize,
            onActivated = arg1.chatIconActivated,
            [Roact.Change.AbsoluteSize] = func1,
            [Roact.Change.AbsolutePosition] = func1,
            [Roact.Ref] = func2
        })

        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl1 = {
            Text = "",
            Visible = var3,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 44, 1, 0),
            LayoutOrder = arg1.props.layoutOrder,
            Selectable = false
        }
        local tbl2 = {
            Background = background,
            BadgeContainer = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 2
                },
                {
                    Badge = arg1.props.unreadMessages > 0
                        and Roact.createElement(Badge, {
                            position = UDim2.fromOffset(18, if shouldShowEmptyBadge() then 6 else 2),
                            anchorPoint = Vector2.new(0, 0),
                            hasShadow = false,
                            value = shouldShowEmptyBadge() and BadgeStates.isEmpty or arg1.props.unreadMessages
                        })
                }
            )
        }
        return createElement(str1, tbl1, tbl2)
    end)
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        chatVisible = arg1.chat.visible,
        unreadMessages = arg1.chat.unreadMessages,
        topBarEnabled = arg1.displayOptions.topbarEnabled,
        chatEnabled = arg1.coreGuiEnabled[Enum.CoreGuiType.Chat]
    }
end, not FFlagTopBarSignalizeKeepOutAreas and function(arg1) -- name: mapDispatchToProps
    return if FFlagTopBarSignalizeKeepOutAreas then {} else {
        setKeepOutArea = function(arg2, arg3, arg4)
            return arg1(SetKeepOutArea(arg2, arg3, arg4))
        end,
        removeKeepOutArea = function(arg2)
            return arg1(RemoveKeepOutArea(arg2))
        end
    }
end or nil)(var2)
