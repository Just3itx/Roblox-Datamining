-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local React = require(UserSearchParent.React)
local Cryo = require(UserSearchParent.Cryo)

local UIBlox = require(UserSearchParent.UIBlox)
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport
local PlayerTile = UIBlox.App.Tile.PlayerTile
local useStyle = UIBlox.Core.Style.useStyle
local getDeepValue = require(UserSearchParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue

local AppUserLayers = require(UserSearchParent.ExperimentLayers).AppUserLayers
local useUserExperiment = require(UserSearchParent.RoactAppExperiment).useUserExperiment

local useLastInputMode = require(UserSearchParent.FocusNavigationUtils).useLastInputMode
local getStandardSizeAvatarHeadShotRbxthumb = require(UserSearchParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb
local getRbxthumbWithTypeSizeAndOptions = require(UserSearchParent.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = require(UserSearchParent.UserLib).Utils.Constants

local useSelector = require(UserSearchParent.RoactUtils).Hooks.RoactRodux.useSelector
local useContextualInfo = require(script.Parent.useContextualInfo)
local useSearchTileButtons = require(script.Parent.useSearchTileButtons)
local useProfileNames = require(script.Parent.useProfileNames)
local Responsive = require(UserSearchParent.Responsive)

local SignalsReact = require(UserSearchParent.SignalsReact)
local ProfileInsightsStore = require(UserSearchParent.DataHydration.ProfileInsights).ProfileInsightsStore

local EventNames = require(UserSearch.Analytics.EventNames)
local _LocalTypes = require(UserSearch.Common.LocalTypes)
local RoundCTAButton = require(UserSearch.Components.RoundCTAButton)
local Constants2 = require(UserSearch.Common.Constants)

local _GraphQLServer = require(UserSearchParent.GraphQLServer)

local useGetPresenceByUserId = require(UserSearchParent.FriendsCommon).Hooks.useGetPresenceByUserId

local GetFFlagLuaAppEnableOpenTypeSupport = require(UserSearchParent.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport

local FFlagBlendedSerpUserPresenceInLineEnabled = require(UserSearchParent.SharedFlags).FFlagBlendedSerpUserPresenceInLineEnabled
local FFlagUserSearchAddFocusActionsSupport = require(UserSearchParent.SharedFlags).FFlagUserSearchAddFocusActionsSupport

local FFlagLuaAppSearchPeopleUnifiedSchemaFields = require(UserSearchParent.SharedFlags).FFlagLuaAppSearchPeopleUnifiedSchemaFields
local FFlagUserSearchPresenceStoreMigration = require(UserSearch.Flags.FFlagUserSearchPresenceStoreMigration)
local FFlagUserSearchUseProfileFrameThumbnail = require(UserSearch.Flags.FFlagUserSearchUseProfileFrameThumbnail)

local FFlagUserSearchCancelTileActivationOnHoldIntent = require(UserSearchParent.SharedFlags).FFlagUserSearchCancelTileActivationOnHoldIntent
local FFlagSduiUserSearchTile = require(UserSearchParent.SharedFlags).FFlagSduiUserSearchTile

local FFlagPlayerSearchEnableOnlineFrequentsForAll = require(UserSearchParent.SharedFlags).FFlagPlayerSearchEnableOnlineFrequentsForAll
local FFlagUserSearchUsePreviousUsernameMatch = require(UserSearchParent.SharedFlags).FFlagUserSearchUsePreviousUsernameMatch
local FFlagUserSearchClassmatesInsight = require(UserSearchParent.SharedFlags).FFlagUserSearchClassmatesInsight

local RODUX_KEY = Constants2.RODUX_KEY
local PresenceHelpers = require(UserSearch.Utils.PresenceHelpers)

local UserTileEventHandlers = require(UserSearchParent.UserTile).UserTileEventHandlers

local function func1(id, bool1: boolean?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool1 then
        return getStandardSizeAvatarHeadShotRbxthumb(tostring(id), FFlagUserSearchUseProfileFrameThumbnail)
    end
    return getRbxthumbWithTypeSizeAndOptions(tostring(id), Constants.RbxthumbTypes.Avatar, 720)
end

return function(tbl1)
    local tileRef = if FFlagUserSearchAddFocusActionsSupport then React.useRef(nil) else nil
    local var2 = nil
    local var3

    if FFlagUserSearchCancelTileActivationOnHoldIntent then
        local var4 = React.useRef(false)
        var2 = var4
        var3 = React.useCallback(function(current: boolean)
            var4.current = current
        end, {})
    else
        var3 = nil
    end

    local user = tbl1.user
    local var4 = useStyle()
    local profileInsight

    if FFlagSduiUserSearchTile then
        local var5 = React.useMemo(function()
            local rankingStrategy = if FFlagPlayerSearchEnableOnlineFrequentsForAll then "profile_info_boost" else nil
            return ProfileInsightsStore.get().GetProfileInsight(
                user.id,
                {
                    rankingStrategy = rankingStrategy,
                    count = if FFlagUserSearchClassmatesInsight and rankingStrategy then 3 else nil
                }
            )
        end, { user.id })
        profileInsight = SignalsReact.useSignalState(var5.data)
    else
        profileInsight = tbl1.profileInsight
    end
    local var5 = tbl1.enablePresenceIndicator and not tbl1.shouldUseCompactTiles
    local size250 = var4.Tokens.Size.Size_250

    local var6 = useUserExperiment({ AppUserLayers.OmniSearchResultsPageUXExposureLayer }, function(arg1): boolean
        return (arg1[AppUserLayers.OmniSearchResultsPageUXExposureLayer] or {}).userPresenceIndicator == "showPresenceInLine"
    end, false)

    local var7 = useLastInputMode()

    local userPresence = if FFlagUserSearchPresenceStoreMigration then useGetPresenceByUserId(tostring(user.id)) else useSelector(function(arg1)
        return getDeepValue(arg1, string.format("%s.Presence.byUserId.%s", RODUX_KEY, user.id)) or {}
    end)

    local contextualInfoDisplay, contextualInfoType = useContextualInfo({
        userId = user.id,
        previousUsernames = if FFlagUserSearchUsePreviousUsernameMatch then nil else user.previousUsernames,
        isPreviousUsernameMatch = if FFlagUserSearchUsePreviousUsernameMatch then user.isPreviousUsernameMatch else nil,
        searchKeyword = tbl1.searchParameters.searchKeyword,
        profileInsight = profileInsight,
        shouldUseCompactTiles = tbl1.shouldUseCompactTiles,
        userPresence = userPresence
    })
    local bool1 = if FFlagUserSearchAddFocusActionsSupport then Responsive.usePreferredInput() == Responsive.Input.Directional else nil

    local function func2(str1: string, arg1)
        if not tbl1.fireAnalyticsEvent then
            return
        end

        tbl1.fireAnalyticsEvent(
            str1,
            Cryo.Dictionary.join({
                playerId = user.id,
                tilePos = tbl1.index,
                contextualInfoType = contextualInfoType,
                hasEmphasis = tbl1.hasEmphasis,
                rowInSort = tbl1.rowInSort,
                positionInRow = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then tbl1.positionInRow else nil,
                feedRowNumber = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then tbl1.feedRowNumber else nil,
                interactionUuid = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then HttpService:GenerateGUID(false) else nil
            }, arg1 or {})
        )
    end

    local function func3()
        if FFlagUserSearchCancelTileActivationOnHoldIntent and var2.current then
            var2.current = false
            return
        end

        tbl1.luaAppNavigation.navigateToUserInfo({
            userId = user.id,
            index = tbl1.index,
            hasEmphasis = tbl1.hasEmphasis,
            contextualInfoType = contextualInfoType,
            contextualInfoDisplay = contextualInfoDisplay
        })

        func2(EventNames.PlayerTileClick)
    end

    local buttons = useSearchTileButtons({
        userId = user.id,
        index = tbl1.index,
        contextualInfoType = contextualInfoType,
        shouldUseCompactTiles = tbl1.shouldUseCompactTiles,
        userPresence = userPresence,
        subpage = tbl1.subpage,
        shouldAddFocusEventName = if FFlagUserSearchAddFocusActionsSupport then bool1 else nil
    }, func2)
    local var12

    if contextualInfoDisplay then
        var12 = {
            text = contextualInfoDisplay.text,
            fontStyle = var4.Font.CaptionBody,
            icon = if tbl1.shouldUseCompactTiles then nil else contextualInfoDisplay.icon,
            horizontalAlignment = if tbl1.shouldUseCompactTiles then Enum.HorizontalAlignment.Center else nil,
            textXAlignment = if tbl1.shouldUseCompactTiles then Enum.TextXAlignment.Center else nil
        }
            or nil
    else
        var12 = nil
    end

    local var13 = useProfileNames({ userId = user.id })

    local function func4(arg1, arg2)
        if not (arg2 and arg2.combinedName) then
            return ""
        end
        if not (arg1 and PresenceHelpers.isUserOnline(arg1.userPresenceType)) then
            return arg2.combinedName
        end
        local onlineStatusColor = var4.Theme.OnlineStatus.Color

        local num1 = math.round(onlineStatusColor.R * 255)
        local num2 = math.round(onlineStatusColor.G * 255)
        local var14 = onlineStatusColor.B * 255
        return `<font color="rgb({num1},{num2},{math.round(var14)})">\226\151\143 </font>` .. arg2.combinedName
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = if FFlagSduiUserSearchTile then UDim2.fromScale(1, 1) else UDim2.fromScale(1, 0)
    }
    local tbl3 = { UserTile = 0, UserTileRoundCTAButton = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        Size = if FFlagSduiUserSearchTile then UDim2.fromScale(1, 1) else UDim2.fromScale(1, 0),
        ZIndex = 1
    }
    local tbl5 = { Tile = 0, UserTileEventHandlers = 0 }
    local createElement3 = React.createElement
    local var14 = PlayerTile
    local tbl6 = {
        buttonRef = if FFlagUserSearchAddFocusActionsSupport then tileRef else nil,
        tileSize = tbl1.size,
        title = if var5 or var6 or FFlagBlendedSerpUserPresenceInLineEnabled then func4(userPresence, var13) else var13 and var13.combinedName,
        subtitle = var13 and var13.username,
        thumbnail = 0,
        onActivated = 0,
        buttons = 0,
        relevancyInfo = 0,
        Selectable = true,
        horizontalAlignment = 0,
        isCircular = 0,
        thumbnailFrameSize = 0,
        openTypeFeatures = 0
    }
    local id = user.id
    tbl6.thumbnail = if tbl1.shouldUseCompactTiles then func1(id, true) else func1(id, false)
    tbl6.onActivated = func3
    local var15

    if FFlagUserSearchAddFocusActionsSupport then
        if bool1 or tbl1.shouldUseCompactTiles then
            var15 = nil
        else
            var15 = buttons
        end
    elseif tbl1.shouldUseCompactTiles or var7 == "Focus" then
        var15 = nil
    else
        var15 = buttons
    end

    tbl6.buttons = var15

    tbl6.relevancyInfo = var12

    tbl6.horizontalAlignment = if tbl1.shouldUseCompactTiles then Enum.HorizontalAlignment.Center else nil
    tbl6.isCircular = tbl1.shouldUseCompactTiles
    tbl6.thumbnailFrameSize = if tbl1.shouldUseCompactTiles then UDim2.new(1, -size250, 1, -size250) else nil

    tbl6.openTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() then OpenTypeSupport:getUserNameStylisticAlternative() else nil
    tbl5.Tile = createElement3(var14, tbl6)
    local var16

    if FFlagUserSearchAddFocusActionsSupport and bool1 then
        local createElement4 = React.createElement
        local var17 = UserTileEventHandlers
        local tbl7 = {
            buttons = buttons,
            onTileActivated = func3,
            tileRef = tileRef,
            setDisabledForHold = 0,
            disableRegularActionOnHoldIntent = 0
        }

        if not FFlagUserSearchCancelTileActivationOnHoldIntent then
            var3 = nil
        end

        tbl7.setDisabledForHold = var3

        tbl7.disableRegularActionOnHoldIntent = if FFlagUserSearchCancelTileActivationOnHoldIntent then true else nil
        var16 = createElement4(var17, tbl7)
    else
        var16 = nil
    end

    tbl5.UserTileEventHandlers = var16
    tbl3.UserTile = createElement2(str2, tbl4, tbl5)
    local element

    if tbl1.shouldUseCompactTiles and buttons and #buttons > 0 and not (FFlagUserSearchAddFocusActionsSupport and bool1) then
        if FFlagSduiUserSearchTile then
            element = React.createElement("Frame", {
                BackgroundTransparency = 1,
                ZIndex = 2,
                Size = UDim2.fromScale(1, 1),
                SizeConstraint = Enum.SizeConstraint.RelativeXX
            }, {
                RoundCTAButton = React.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(var4.Tokens.Size.Size_900, var4.Tokens.Size.Size_900),
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.new(1, -var4.Tokens.Size.Size_250, 1, -var4.Tokens.Size.Size_250)
                }, {
                    RoundCTAButton = React.createElement(RoundCTAButton, { searchTileButtonProps = buttons[1], playerTileSize = tbl1.size })
                })
            })
        else
            element = React.createElement("Frame", {
                BackgroundTransparency = 1,
                ZIndex = 2,
                Size = UDim2.fromOffset(var4.Tokens.Size.Size_900, var4.Tokens.Size.Size_900),
                AnchorPoint = Vector2.new(1, 1),
                Position = UDim2.fromOffset(tbl1.size.X.Offset - var4.Tokens.Size.Size_250, tbl1.size.X.Offset - var4.Tokens.Size.Size_250)
            }, {
                RoundCTAButton = React.createElement(RoundCTAButton, { searchTileButtonProps = buttons[1], playerTileSize = tbl1.size })
            })
        end
    else
        element = nil
    end

    tbl3.UserTileRoundCTAButton = element
    return createElement(str1, tbl2, tbl3)
end
