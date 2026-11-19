-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local Cryo = require(CorePackages.Packages.Cryo)
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local CoreScriptsRoactCommon = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local scriptParentParentParent = script.Parent.Parent.Parent
local ReactPageSignal = require(scriptParentParentParent.ReactPageSignal)
local TraversalLeaveConfirmation = require(script.Parent.TraversalLeaveConfirmation)

local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local ThumbnailType = Foundation.Enums.ThumbnailType
local View = Foundation.View

local Traversal = CoreScriptsRoactCommon.Traversal
local default = Traversal.LocalTraversalHistory.default
local GetInputModeStore = Responsive.GetInputModeStore
local Input = Responsive.Input
local Constants = Traversal.Constants
local HistoryPage = Traversal.HistoryPage
local useHistoryItems = Traversal.useHistoryItems
local FIntMaximumTraversalHistoryItemsFetch = Traversal.Flags.FIntMaximumTraversalHistoryItemsFetch
local FFlagTraversalExpPagePaddingFixes = Traversal.Flags.FFlagTraversalExpPagePaddingFixes
local FFlagIntegrateTraversalHistoryInSideSheet = SharedFlags.FFlagIntegrateTraversalHistoryInSideSheet

return React.memo(React.forwardRef(function(_, arg1) -- name: TraversalHistoryPage
    local ref = React.useRef(nil)
    React.useImperativeHandle(arg1, function()
        return ref.current
    end, {})
    local var2, var3 = React.useState(FIntMaximumTraversalHistoryItemsFetch)
    local var4 = useHistoryItems(var2)
    local universeId, var6 = React.useState(Constants.NO_UNIVERSE_ID)
    local var7 = SignalsReact.useSignalState(ReactPageSignal)
    React.useEffect(function()
        local userInputType = UserInputService:GetLastInputType()
        local var8 = GetInputModeStore().getLastInputType()
        local bool1 = var8 == Input.Directional or var8 == Input.Pointer and userInputType == Enum.UserInputType.Keyboard

        if bool1 and ref.current then
            GuiService.SelectedCoreObject = ref.current
        end
    end, {})

    local onCardItemActivated = React.useCallback(function(num1: number)
        var6(num1)
    end, { var6 })

    local var9 = React.useCallback(function()
        var6(Constants.NO_UNIVERSE_ID)
        local userInputType = UserInputService:GetLastInputType()
        local var9 = GetInputModeStore().getLastInputType()
        local bool1 = var9 == Input.Directional or var9 == Input.Pointer and userInputType == Enum.UserInputType.Keyboard

        if bool1 and ref.current then
            GuiService.SelectedCoreObject = ref.current
        end
    end, {})

    local historyItems = React.useMemo(function()
        return (Cryo.List.map(var4, function(arg2)
            return {
                placeId = arg2.placeId,
                universeId = arg2.universeId,
                name = arg2.name,
                image = getRbxThumb(ThumbnailType.GameIcon, arg2.universeId, ThumbnailSize.Medium),
                rating = arg2.rating
            }
        end))
    end, { var4 })

    local onLoadMoreHistory = React.useCallback(function(num1: number)
        if var2 >= #default:getUniverseHistory() then
            return
        end
        var3(var2 + num1)
    end, { var2 })

    local element

    if next(historyItems) == nil then
        element = false
    else
        element = React.createElement(View, {
            tag = "size-full " .. (if FFlagIntegrateTraversalHistoryInSideSheet then "" elseif FFlagTraversalExpPagePaddingFixes then "padding-top-medium" else "padding-large")
        }, {
            HistoryPage = React.createElement(HistoryPage, {
                historyItems = historyItems,
                onHistoryClose = function()
                    var7.setCurrentReactPage(nil)
                end,
                onCardItemActivated = onCardItemActivated,
                onLoadMoreHistory = onLoadMoreHistory,
                ref = ref
            })
        }, {
            Dialog = React.createElement(TraversalLeaveConfirmation, {
                isDialogOpen = Constants.NO_UNIVERSE_ID < universeId,
                onCancel = var9,
                onClose = var9,
                universeId = universeId,
                source = "history_landing_page"
            })
        })
    end

    return element
end))
