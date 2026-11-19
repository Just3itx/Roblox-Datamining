-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local InitialView = require(scriptParentParent.Components.InitialView)
local AssetDetails = require(scriptParentParent.Components.AssetDetails)
local CloseButton = require(scriptParentParent.Components.CloseButton)
local Overlay = require(scriptParentParent.Components.Overlay)
local NoInventoryNotice = require(scriptParentParent.Components.NoInventoryNotice)
local Colors = require(scriptParentParent.Colors)
local Constants = require(scriptParentParent.Constants)

local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local Modules = game:GetService("CoreGui").RobloxGui.Modules
local Theme = require(Modules.Settings.Theme)
local Constants2 = require(Modules.TopBar.Constants)

local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)

local var1 = Roact.PureComponent:extend("Container")

function var1.init(arg1)
    arg1.frameRef = Roact.createRef()
    arg1.lastSavedSelectedCoreGui = nil
    arg1.disposeUiScaleEffect = Signals.createEffect(function(arg2)
        local displayStore = Display.GetDisplayStore(arg2)
        arg1:setState({ UiScale = displayStore.getUIScale(arg2) })
    end)
end

function var1.didMount(arg1)
    local gamepadEnabled = arg1.props.gamepadEnabled

    arg1.selectedCoreObjectChangedSignal = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
        if arg1.props.visible and GuiService.SelectedCoreObject then
            arg1.lastSavedSelectedCoreGui = GuiService.SelectedCoreObject
        end
    end)

    if gamepadEnabled then
        GuiService:AddSelectionParent("InspectMenu", arg1.frameRef.current)
    end
end

function var1.didUpdate(arg1, arg2)
    local visible = arg1.props.visible
    local gamepadEnabled = arg1.props.gamepadEnabled

    if visible and gamepadEnabled and arg1.frameRef.current then
        GuiService:RemoveSelectionGroup("InspectMenu")
        GuiService:AddSelectionParent("InspectMenu", arg1.frameRef.current)
        if arg1.lastSavedSelectedCoreGui then
            GuiService.SelectedCoreObject = arg1.lastSavedSelectedCoreGui
        end
    elseif not gamepadEnabled and arg2.gamepadEnabled or not visible then
        GuiService:RemoveSelectionGroup("InspectMenu")
    end

    if visible and not arg2.visible then
        GuiService.SelectedCoreObject = arg1.lastSavedSelectedCoreGui
    end
end

function var1.willUnmount(arg1)
    arg1.selectedCoreObjectChangedSignal:disconnect()
    GuiService:RemoveSelectionGroup("InspectMenu")
    GuiService.SelectedCoreObject = nil
    if arg1.disposeUiScaleEffect then
        arg1.disposeUiScaleEffect()
    end
end

function var1.render(arg1)
    local view = arg1.props.view
    local localPlayerModel = arg1.props.localPlayerModel
    local visible = arg1.props.visible
    local var2 = Theme.UseInspectAndBuyPanel()
    local var3 = Constants2.TopBarHeight * arg1.state.UiScale
    local var4 = Constants2.ScreenSideOffset * arg1.state.UiScale

    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(arg2)
            local var5 = arg2[view]
            local var6 = var5.ContainerSize(arg1.state.UiScale)
            local var7 = var5.ContainerPosition(arg1.state.UiScale)

            local createElement = Roact.createElement
            local str1 = "ImageButton"
            local tbl1 = {
                Size = UDim2.new(1, if var2 then var4 * -2 else 0, 1, if var2 then Theme.DefaultCornerRadius.Offset else var3),
                Position = UDim2.new(0, if var2 then var4 else 0, 0, if var2 then 0 else -var3),
                BackgroundColor3 = var5.ContainerBackgroundColor,
                BackgroundTransparency = var5.ContainerBackgroundTransparency,
                Visible = visible,
                Selectable = false,
                AutoButtonColor = false,
                AutoLocalize = false
            }

            tbl1[Roact.Event.Activated] = function()
                if view == Constants.View.Wide then
                    GuiService:CloseInspectMenu()
                end
            end
            local tbl2 = {
                UICorner = if var2 then Roact.createElement("UICorner", { CornerRadius = Theme.DefaultCornerRadius }) else nil,
                Overlay = Roact.createElement(Overlay),
                MainContainer = Roact.createElement("ImageButton", {
                    AnchorPoint = var5.ContainerAnchorPoint,
                    Size = var6,
                    Position = var7,
                    BackgroundColor3 = Colors.Carbon,
                    BorderSizePixel = 0,
                    Active = true,
                    AutoButtonColor = false,
                    Selectable = false,
                    [Roact.Ref] = arg1.frameRef
                }, {
                    AspectRatioConstraint = var5.UseContainerAspectRatio
                        and Roact.createElement("UIAspectRatioConstraint", { AspectRatio = var5.ContainerAspectRatio }),
                    CloseButton = Roact.createElement(CloseButton),
                    InitialView = Roact.createElement(InitialView),
                    AssetDetails = Roact.createElement(AssetDetails, { localPlayerModel = localPlayerModel }),
                    NoInventoryNotice = Roact.createElement(NoInventoryNotice)
                })
            }
            return createElement(str1, tbl1, tbl2)
        end
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        view = arg1.view,
        visible = arg1.visible,
        gamepadEnabled = arg1.gamepadEnabled
    }
end)(var1)
