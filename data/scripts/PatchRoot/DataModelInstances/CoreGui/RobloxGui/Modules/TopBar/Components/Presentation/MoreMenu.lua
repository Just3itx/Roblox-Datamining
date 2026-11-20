-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local VRService = game:GetService("VRService")
local StarterGui = game:GetService("StarterGui")

local _Signals = require(CorePackages.Packages.Signals)
local _Display = require(CorePackages.Workspace.Packages.Display)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local ContextualMenu = UIBlox.App.Menu.ContextualMenu
local MenuDirection = UIBlox.App.Menu.MenuDirection
local Images = UIBlox.App.ImageSet.Images
local withStyle = UIBlox.Core.Style.withStyle

local scriptParentParentParent = script.Parent.Parent.Parent

local Actions = scriptParentParentParent.Actions
local SetKeepOutArea = require(Actions.SetKeepOutArea)
local RemoveKeepOutArea = require(Actions.RemoveKeepOutArea)
local SetMoreMenuOpen = require(Actions.SetMoreMenuOpen)

local Analytics = require(scriptParentParentParent.Analytics)

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas
local FFlagTopBarSignalizeScreenSize = CoreGuiCommon.Flags.FFlagTopBarSignalizeScreenSize

local var1 = require(scriptParentParentParent.Flags.GetFFlagEnableTopBarAnalytics)()

local Constants = require(scriptParentParentParent.Constants)
local _InputType = Constants.InputType

local IconButton = require(script.Parent.IconButton)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Modules = RobloxGui.Modules
local TenFootInterface = require(Modules.TenFootInterface)
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub

local EmotesMenuMaster = require(Modules.EmotesMenu.EmotesMenuMaster)
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local BackpackScript = if FFlagEnableNewBackpack then nil else require(Modules.BackpackScript)
local ChatSelector = require(Modules.ChatSelector)
local PlayerListManager = require(Modules.PlayerList.PlayerListManager)

local Constants2 = require(Modules.EmotesMenu.Constants)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection

local FFlagMountCoreGuiBackpack = require(Modules.Flags.FFlagMountCoreGuiBackpack)

local iconsControlsEmoteOn = Images["icons/controls/emoteOn"]
local iconsControlsEmoteOff = Images["icons/controls/emoteOff"]

local var2 = Roact.PureComponent:extend("MoreMenu")

var2.validateProps = t.strictInterface({
    layoutOrder = t.integer,
    moreMenuOpen = t.boolean,
    setMoreMenuOpen = t.callback,
    screenSize = if FFlagTopBarSignalizeScreenSize then nil else t.Vector2,
    isSmallTouchDevice = t.boolean,
    topBarEnabled = t.boolean,
    leaderboardEnabled = t.boolean,
    emotesEnabled = t.boolean,
    backpackEnabled = if FFlagMountCoreGuiBackpack then nil else t.boolean,
    leaderboardOpen = t.boolean,
    backpackOpen = t.boolean,
    emotesOpen = t.boolean,
    setKeepOutArea = if FFlagTopBarSignalizeKeepOutAreas then nil else t.callback,
    removeKeepOutArea = if FFlagTopBarSignalizeKeepOutAreas then nil else t.callback
})

function var2.init(arg1)
    arg1.rootRef = Roact.createRef()
    if var1 then
        arg1.analytics = Analytics.default
    end
    arg1.disposeUiScaleEffect = Signals.createEffect(function(arg2)
        local displayStore = Display.GetDisplayStore(arg2)
        arg1:setState({ UiScale = displayStore.getUIScale(arg2) })
    end)

    if FFlagMountCoreGuiBackpack then
        arg1:setState({ mountBackpack = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack), vrShowMenuIcon = false })

        StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
            if coreGuiType == Enum.CoreGuiType.Backpack or coreGuiType == Enum.CoreGuiType.All then
                arg1:setState({ mountBackpack = enabled })
            end
        end)
    else
        arg1:setState({ vrShowMenuIcon = false })
    end

    arg1.chatWasHidden = false

    arg1.boundAction = false

    function arg1.moreButtonActivated()
        arg1.props.setMoreMenuOpen(not arg1.props.moreMenuOpen)
        if arg1.analytics then
            arg1.analytics:onMoreMenuActivated()
        end
    end

    if FFlagTopBarSignalizeKeepOutAreas then
        arg1.keepOutAreasStore = CoreGuiCommon.Stores.GetKeepOutAreasStore(false)
    end

    if not FFlagTopBarSignalizeScreenSize then
        return
    end

    local getViewportSize = Display.GetDisplayStore(false).getViewportSize

    arg1.disposeScreenSize = Signals.createEffect(function(arg2)
        arg1:setState({ screenSize = getViewportSize(arg2) })
    end)
end

function var2.willUnmount(arg1)
    if FFlagTopBarSignalizeScreenSize then
        arg1.disposeScreenSize()
    end
    if arg1.disposeUiScaleEffect then
        arg1.disposeUiScaleEffect()
    end
end

function var2.renderWithStyle(arg1, arg2)
    local buttonProps = {}
    local bool1 = false
    if arg1.props.leaderboardEnabled then
        table.insert(buttonProps, {
            icon = if arg1.props.leaderboardOpen then "rbxasset://textures/ui/TopBar/leaderboardOn.png" else "rbxasset://textures/ui/TopBar/leaderboardOff.png",
            text = RobloxTranslator:FormatByKey("CoreScripts.TopBar.Leaderboard"),
            onActivated = function()
                local leaderboardOpen = arg1.props.leaderboardOpen
                if VRService.VREnabled then
                    require(RobloxGui.Modules.InGameMenu).openPlayersPage()
                else
                    PlayerListManager:SetVisibility(not PlayerListManager:GetSetVisible())
                    arg1.props.setMoreMenuOpen(false)
                end
                if arg1.analytics then
                    arg1.analytics:onLeaderboardActivated(not leaderboardOpen)
                end
            end
        })
        bool1 = true
    end

    if arg1.props.emotesEnabled then
        local var3 = iconsControlsEmoteOn
        if not arg1.props.emotesOpen then
            var3 = iconsControlsEmoteOff
        end

        local _emoteMenuOpenKey = Constants2.EmoteMenuOpenKey

        table.insert(buttonProps, {
            icon = var3,
            text = RobloxTranslator:FormatByKey("CoreScripts.TopBar.Emotes"),
            onActivated = function()
                if EmotesMenuMaster:isOpen() then
                    EmotesMenuMaster:close()
                else
                    if arg1.chatWasHidden then
                        ChatSelector:SetVisible(true)
                        arg1.chatWasHidden = false
                    end
                    EmotesMenuMaster:open()
                end
                arg1.props.setMoreMenuOpen(false)
                if arg1.analytics then
                    arg1.analytics:onEmotesActivated(EmotesMenuMaster:isOpen())
                end
            end
        })
        bool1 = true
    end

    if if FFlagMountCoreGuiBackpack then arg1.state.mountBackpack else arg1.props.backpackEnabled then
        table.insert(buttonProps, {
            icon = if arg1.props.backpackOpen then "rbxasset://textures/ui/TopBar/inventoryOn.png" else "rbxasset://textures/ui/TopBar/inventoryOff.png",
            text = RobloxTranslator:FormatByKey("CoreScripts.TopBar.Inventory"),
            onActivated = function()
                if FFlagEnableNewBackpack then
                    Features.toggleVisibility(Features.FeatureName.Backpack)
                    arg1.props.setMoreMenuOpen(false)
                    if arg1.analytics then
                        arg1.analytics:onInventoryActivated(Features.getVisibility(Features.FeatureName.Backpack))
                    end
                else
                    BackpackScript:OpenClose()
                    arg1.props.setMoreMenuOpen(false)
                    if arg1.analytics then
                        arg1.analytics:onInventoryActivated(BackpackScript.IsOpen)
                    end
                end
            end
        })
        bool1 = true
    end

    local screenSize = if FFlagTopBarSignalizeScreenSize then arg1.state.screenSize else arg1.props.screenSize
    local uDim2 = UDim2.new(0, 324, 0, screenSize.Y)
    if screenSize.X < 450 then
        uDim2 = UDim2.new(0, screenSize.X - 24, 0, screenSize.Y)
    end

    local icon = if arg1.props.moreMenuOpen then "rbxasset://textures/ui/TopBar/moreOn.png" else "rbxasset://textures/ui/TopBar/moreOff.png"

    local var3 = not TenFootInterface:IsEnabled() and arg1.props.topBarEnabled and bool1 and not VRService.VREnabled

    local function func1(arg3)
        if var3 and arg3 then
            if FFlagTopBarSignalizeKeepOutAreas then
                arg1.keepOutAreasStore.setKeepOutArea(Constants.MoreMenuKeepOutAreaId, arg3.AbsolutePosition, arg3.AbsoluteSize)
                return
            end
            arg1.props.setKeepOutArea(Constants.MoreMenuKeepOutAreaId, arg3.AbsolutePosition, arg3.AbsoluteSize)
        elseif FFlagTopBarSignalizeKeepOutAreas then
            arg1.keepOutAreasStore.removeKeepOutArea(Constants.MoreMenuKeepOutAreaId)
        else
            arg1.props.removeKeepOutArea(Constants.MoreMenuKeepOutAreaId)
        end
    end

    if arg1.rootRef.current then
        func1(arg1.rootRef.current)
    end

    local createElement = Roact.createElement
    local tbl2 = {
        Visible = var3,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 32, 1, 0),
        LayoutOrder = arg1.props.layoutOrder,
        [Roact.Change.AbsoluteSize] = func1,
        [Roact.Change.AbsolutePosition] = func1,
        [Roact.Ref] = arg1.rootRef
    }

    return createElement("Frame", tbl2, {
        OpenButton = Roact.createElement(IconButton, { icon = icon, iconSize = 24, onActivated = arg1.moreButtonActivated }),
        MoreMenuContainer = Roact.createElement("Frame", {
            ZIndex = 3,
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 12, 0, 0),
            Size = uDim2,
            AnchorPoint = Vector2.new(1, 0)
        }, {
            ContextualMenu = Roact.createElement(ContextualMenu, {
                buttonProps = buttonProps,
                open = arg1.props.moreMenuOpen,
                menuDirection = MenuDirection.Down,
                openPositionY = UDim.new(0, Constants.TopBarHeight * arg1.state.UiScale + 12),
                background = arg2.Theme.BackgroundUIContrast,
                closeBackgroundVisible = false,
                screenSize = screenSize,
                onDismiss = function()
                    arg1.props.setMoreMenuOpen(false)
                    PlayerListManager:SetMinimized(false)
                end
            })
        }),
        ShowTopBarListener = Roact.createElement(ExternalEventConnection, {
            event = VRHub.ShowTopBarChanged.Event,
            callback = function()
                arg1:setState({ vrShowMenuIcon = VRService.VREnabled and VRHub.ShowTopBar and bool1 })
            end
        })
    })
end

function var2.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderWithStyle(arg2)
    end)
end

function var2.updateActionBound(arg1)
    if not arg1.props.moreMenuOpen then
        if arg1.boundAction then
            ContextActionService:UnbindCoreAction("CloseMoreMenuAction")

            arg1.boundAction = false
        end
        return
    end

    ContextActionService:BindCoreAction("CloseMoreMenuAction", function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass
        end

        arg1.props.setMoreMenuOpen(false)
        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.Escape)

    arg1.boundAction = true
end

function var2.didUpdate(arg1, arg2, _)
    if arg1.props.moreMenuOpen == arg2.moreMenuOpen then
        return
    end

    PlayerListManager:SetMinimized(arg1.props.moreMenuOpen)

    arg1:updateActionBound()
    local screenSize = if FFlagTopBarSignalizeScreenSize then arg1.state.screenSize else arg1.props.screenSize

    if not (screenSize.X < 600) then
        return
    end

    if arg1.props.moreMenuOpen and ChatSelector:GetVisibility() then
        arg1.chatWasHidden = true
        ChatSelector:SetVisible(false)
        return
    end

    if not arg1.props.moreMenuOpen and arg1.chatWasHidden then
        ChatSelector:SetVisible(true)
        arg1.chatWasHidden = false
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        screenSize = if FFlagTopBarSignalizeScreenSize then nil else arg1.displayOptions.screenSize,
        moreMenuOpen = arg1.moreMenu.open,
        isSmallTouchDevice = arg1.displayOptions.isSmallTouchDevice,
        topBarEnabled = arg1.displayOptions.topbarEnabled,
        leaderboardEnabled = arg1.coreGuiEnabled[Enum.CoreGuiType.PlayerList],
        emotesEnabled = arg1.moreMenu.emotesEnabled and arg1.coreGuiEnabled[Enum.CoreGuiType.EmotesMenu],
        backpackEnabled = if FFlagMountCoreGuiBackpack then nil else arg1.coreGuiEnabled[Enum.CoreGuiType.Backpack],
        leaderboardOpen = arg1.moreMenu.leaderboardOpen,
        backpackOpen = arg1.moreMenu.backpackOpen,
        emotesOpen = arg1.moreMenu.emotesOpen
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        setMoreMenuOpen = function(arg2)
            return arg1(SetMoreMenuOpen(arg2))
        end,
        setKeepOutArea = not FFlagTopBarSignalizeKeepOutAreas and function(arg2, arg3, arg4)
            return arg1(SetKeepOutArea(arg2, arg3, arg4))
        end or nil,
        removeKeepOutArea = not FFlagTopBarSignalizeKeepOutAreas and function(arg2)
            return arg1(RemoveKeepOutArea(arg2))
        end or nil
    }
end)(var2)
