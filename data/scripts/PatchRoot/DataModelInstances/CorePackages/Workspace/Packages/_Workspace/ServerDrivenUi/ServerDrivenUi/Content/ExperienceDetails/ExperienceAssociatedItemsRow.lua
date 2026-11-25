-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local RoactUtils = require(ServerDrivenUiParent.RoactUtils)
local Cryo = require(ServerDrivenUiParent.Cryo)

local Game = require(ServerDrivenUiParent.DataHydration).Game
local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local PlayerFeedback = require(ServerDrivenUiParent.PlayerFeedback)
local CentralOverlay = require(ServerDrivenUiParent.CentralOverlay)
local RobloxAppEnums = require(ServerDrivenUiParent.RobloxAppEnums)
local SharedFlags = require(ServerDrivenUiParent.SharedFlags)

local useTokens = Foundation.Hooks.useTokens
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local GamePlayerFeedbackPrompt = PlayerFeedback.GamePlayerFeedbackPrompt
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local SduiAssociatedItemsRow = require(ServerDrivenUi.Content.SduiAssociatedItemsRow)

local GetFFlagEdpPlayerFeedbackEnabled = SharedFlags.GetFFlagEdpPlayerFeedbackEnabled

return React.memo(function(tbl1) -- name: ExperienceAssociatedItemsRow
    local layoutOrder = tbl1.layoutOrder
    local var1 = useTokens()
    local var2 = useDispatch()

    local universeId = tbl1.universeId

    local gameInfoStore = Game.getGameInfoStore(false)
    local var3 = SignalsReact.useSignalState(gameInfoStore.getAndFetchGameInfo(universeId).data)
    local rootPlaceId = var3 and var3.rootPlaceId

    local votesStore = Game.getVotesStore(false)
    local var4 = SignalsReact.useSignalState(votesStore.getAndFetchUserVote(universeId).data)

    local var5 = React.useCallback(function(arg1)
        if not rootPlaceId then
            return nil
        end
        return Game.getUserVoteFeedbackMetadataStore(arg1).getUserVoteFeedbackMetadata(rootPlaceId).data(arg1)
    end, { rootPlaceId })
    local var6 = SignalsReact.useSignalState(var5)

    local canSubmitReview = GetFFlagEdpPlayerFeedbackEnabled() and var6 and var6.canSubmitReview

    local var7 = React.useCallback(function()
        if rootPlaceId then
            Game.getUserVoteFeedbackMetadataStore(false).clearItem(rootPlaceId)
        end
    end, { rootPlaceId })

    local onButtonClick = React.useCallback(function()
        if not var6 or not var6.canSubmitReview or not var4 or var4.userVote ~= true and var4.userVote ~= false then
            return
        end
        local tbl2 = { [true] = "Upvote", [false] = "Downvote" }

        local var8 = nil

        for _, value in var6.categories do
            if value.type == tbl2[var4.userVote] then
                var8 = value
                break
            end
        end

        local playerFeedbackMetadata = {
            rootPlaceId = var6.rootPlaceId,
            canSubmitReview = var6.canSubmitReview,
            canSubmitComment = var6.canSubmitComment,
            categoryType = tbl2[var4.userVote],
            category = var8,
            comment = var6.comment,
            metadata = var6.metadata
        }
        var2(
            SetCentralOverlay(
                CentralOverlayType.GamePlayerFeedbackForm,
                {
                    universeId = universeId,
                    playerFeedbackMetadata = playerFeedbackMetadata,
                    onSubmitted = var7
                }
            )
        )
    end, {
        var6,
        universeId,
        var2,
        var4,
        var7
    })

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = layoutOrder
    }, {
        MinHeightConstraint = React.createElement("UISizeConstraint", { MinSize = Vector2.new(0, var1.Size.Size_700) }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var1.Padding.Small)
        }),
        ChipsRow = React.createElement(SduiAssociatedItemsRow, Cryo.Dictionary.join(tbl1, { universeId = nil, layoutOrder = 1 })),
        FeedbackPrompt = if canSubmitReview and rootPlaceId then React.createElement(
            GamePlayerFeedbackPrompt,
            {
                placeId = rootPlaceId,
                onButtonClick = onButtonClick,
                onDimiss = var7,
                LayoutOrder = 2
            }
        ) else nil
    })
end)
