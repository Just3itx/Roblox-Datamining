-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local Foundation = require(GameTileParent.Foundation)
local Localization = require(GameTileParent.Localization)
local React = require(GameTileParent.React)
local ReactFocusNavigation = require(GameTileParent.ReactFocusNavigation)
local RoactServiceTags = require(GameTileParent.RoactServiceTags)
local RoactUtils = require(GameTileParent.RoactUtils)
local RobloxAppHooks = require(GameTileParent.RobloxAppHooks)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local useLocalization = Localization.Hooks.useLocalization
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject
local RoactNetworking = RoactServiceTags.RoactNetworking
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useRoactService = RobloxAppHooks.useRoactService

local undoGameNotInterested = require(GameTile.undoGameNotInterested)

return React.memo(function(tbl1) -- name: HiddenTileContent
    local dispatch = useDispatch()
    local ref = React.useRef(nil)
    local var3 = useTokens()
    local var4 = useFocusGuiObject()
    local networking = useRoactService(RoactNetworking)
    local var6 = useLocalization(
        {
            undoLabel = "Feature.GameDetails.Action.Undo",
            hiddenTileMessage = "Feature.GameDetails.Message.SuggestLessOften"
        }
    )

    local onActivated = React.useCallback(function()
        undoGameNotInterested({
            appPage = tbl1.appPage,
            collectionId = tbl1.collectionId,
            dispatch = dispatch,
            isSponsored = tbl1.isSponsored,
            networking = networking,
            onOptimisticUnhide = function()
                if GuiService.SelectedCoreObject ~= ref.current then
                    return
                end

                task.delay(0, function()
                    if tbl1.parentRef then
                        var4(tbl1.parentRef.current)
                    end
                end)
            end,
            setGameHidden = tbl1.setGameHidden,
            universeId = tbl1.universeId
        })
    end, {
        networking,
        var4,
        tbl1.setGameHidden,
        tbl1.universeId,
        tbl1.collectionId,
        tbl1.appPage,
        tbl1.parentRef,
        dispatch,
        tbl1.isSponsored
    })

    return React.createElement(
        View,
        {
            tag = "size-full gap-small col align-x-center align-y-center bg-surface-100 radius-medium padding-medium"
        },
        {
            Message = React.createElement(FoundationText, {
                AutomaticSize = Enum.AutomaticSize.Y,
                fontStyle = var3.Typography.BodySmall,
                LayoutOrder = 1,
                Size = UDim2.fromScale(1, 0),
                Text = var6.hiddenTileMessage,
                textStyle = var3.Color.Content.Default,
                TextWrapped = true
            }),
            UndoButton = React.createElement(Button, {
                LayoutOrder = 2,
                onActivated = onActivated,
                size = InputSize.XSmall,
                text = var6.undoLabel,
                variant = ButtonVariant.Standard,
                ref = ref,
                testId = `--game-tile-hidden-undo-{tbl1.universeId}`
            })
        }
    )
end)
