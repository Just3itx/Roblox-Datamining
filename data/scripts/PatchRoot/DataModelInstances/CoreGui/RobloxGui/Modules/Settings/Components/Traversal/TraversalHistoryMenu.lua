-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local CoreScriptsCommon = require(CorePackages.Workspace.Packages.CoreScriptsCommon)
local CoreScriptsRoactCommon = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)

local TraversalLeaveConfirmation = require(script.Parent.TraversalLeaveConfirmation)

local scriptParentParentParent = script.Parent.Parent.Parent
local EnumReactPage = require(scriptParentParentParent.EnumReactPage)
local ReactPageSignal = require(scriptParentParentParent.ReactPageSignal)
local Utility = require(scriptParentParentParent.Utility)

local View = Foundation.View
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local getRbxThumb = Foundation.Utility.getRbxThumb
local SettingsShowSignal = CoreScriptsCommon.SettingsShowSignal
local Traversal = CoreScriptsRoactCommon.Traversal
local default = Traversal.LocalTraversalHistory.default
local GetInputModeStore = Responsive.GetInputModeStore
local Input = Responsive.Input
local Constants = Traversal.Constants
local HistoryMenu = Traversal.HistoryMenu
local useHistoryItems = Traversal.useHistoryItems
local useTokens = Foundation.Hooks.useTokens
local FFlagAddTraversalHistoryReactMenuButtons = require(scriptParentParentParent.Flags.FFlagAddTraversalHistoryReactMenuButtons)

local function historyToMenuItems(arg1)
    local result = {}
    for _, value in arg1 do
        table.insert(result, {
            universeId = value.universeId,
            text = value.name,
            icon = getRbxThumb(ThumbnailType.GameIcon, value.universeId, ThumbnailSize.Small)
        })
    end
    return result
end

return React.memo(React.forwardRef(function(tbl1, _) -- name: TraversalHistoryMenu
    local var1 = React.useRef(tbl1.anchorParent)
    if FFlagAddTraversalHistoryReactMenuButtons and tbl1.anchorRef then
        var1 = tbl1.anchorRef
    end
    local var2 = useHistoryItems()
    local historyItems = React.useMemo(function()
        return (historyToMenuItems(var2))
    end, { var2 })

    local var4 = if tbl1.idleButtonStateIsDown ~= nil then tbl1.idleButtonStateIsDown else Constants.DEFAULT_CHEVRON_BUTTON_STATE
    local var5, var6 = React.useBinding(Enum.SelectionBehavior.Stop)
    local selectionGroup = React.useMemo(function()
        return {
            SelectionBehaviorUp = if var4 then var5 else Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = if var4 then Enum.SelectionBehavior.Stop else var5
        }
    end, { var4 })
    local var8 = useTokens()
    local universeId, var10 = React.useState(Constants.NO_UNIVERSE_ID)
    local var11 = SignalsReact.useSignalState(ReactPageSignal)
    local closeMenuConn = React.useCallback(function(callback)
        return {
            onSettingsVisible = SettingsShowSignal:connect(function(arg1)
                if not arg1 then
                    callback()
                end
            end),
            onPageChanged = if FFlagAddTraversalHistoryReactMenuButtons and not tbl1.currentPageChangeSignal then nil else tbl1.currentPageChangeSignal:connect(function()
                callback()
            end),
            onNativeClose = GuiService.NativeClose:Connect(function()
                callback()
            end)
        }
    end, { tbl1.currentPageChangeSignal, SettingsShowSignal, GuiService.NativeClose })

    local onMenuItemSelected = React.useCallback(function(num1: number)
        var10(num1)
        var6(Enum.SelectionBehavior.Stop)
    end, { var10 })

    local var14 = React.useCallback(function()
        var10(Constants.NO_UNIVERSE_ID)
        local userInputType = UserInputService:GetLastInputType()
        local var14 = GetInputModeStore().getLastInputType()
        local bool1 = var14 == Input.Directional or var14 == Input.Pointer and userInputType == Enum.UserInputType.Keyboard

        if bool1 and var1.current then
            GuiService.SelectedCoreObject = var1.current
        end
    end, {})

    local onMenuToggled = React.useCallback(function(bool1: boolean)
        if bool1 then
            var6(Enum.SelectionBehavior.Escape)
            return
        end
        var6(Enum.SelectionBehavior.Stop)
    end, {})

    local backgroundStyle = React.useMemo(function()
        if FFlagAddTraversalHistoryReactMenuButtons and tbl1.isDarkOnDarkMode then
            return var8.Color.Surface.Surface_0
        end

        return {
            Color3 = var8.Color.Stroke.Default.Color3,
            Transparency = 0.33
        }
    end, {})

    local isSmallTouchScreen = Utility:IsSmallTouchScreen()
    local historyButtonTags = React.useMemo(function()
        return {
            ["padding-small"] = isSmallTouchScreen,
            ["padding-medium"] = not isSmallTouchScreen
        }
    end, { isSmallTouchScreen })

    local onHistorySelected = React.useCallback(function()
        var11.setCurrentReactPage(EnumReactPage.TraversalHistory)
        var6(Enum.SelectionBehavior.Stop)
    end, { var11 })

    local var19 = React.useMemo(function(): boolean
        return #default:getUniverseHistory() > 0
    end, {})

    if var19 then
        var19 = React.createElement(View, {
            tag = "auto-xy row align-y-center size-0-full",
            selectionGroup = selectionGroup,
            ref = if FFlagAddTraversalHistoryReactMenuButtons and not (tbl1.anchorRef or tbl1.anchorParent) then var1 else nil
        }, {
            DividerLeft = React.createElement(View, { Size = UDim2.new(0, var8.Stroke.Thick, 1, 0), backgroundStyle = backgroundStyle }),
            HistoryMenu = React.createElement(HistoryMenu, {
                historyButtonTags = historyButtonTags,
                historyItems = historyItems,
                onHistorySelected = onHistorySelected,
                onMenuItemSelected = onMenuItemSelected,
                onMenuToggled = onMenuToggled,
                closeMenuConn = closeMenuConn,
                menuSide = tbl1.menuSide,
                ref = var1
            })
        }, {
            Dialog = React.createElement(TraversalLeaveConfirmation, {
                isDialogOpen = Constants.NO_UNIVERSE_ID < universeId,
                onCancel = var14,
                onClose = var14,
                universeId = universeId,
                source = "history_dropdown"
            })
        })
    end

    return var19
end))
