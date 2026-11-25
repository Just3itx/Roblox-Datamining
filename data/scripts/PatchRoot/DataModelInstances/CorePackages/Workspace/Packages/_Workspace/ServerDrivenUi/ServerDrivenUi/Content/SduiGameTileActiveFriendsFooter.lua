-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")

local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local Foundation = require(ServerDrivenUiParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local StatusIndicator = Foundation.StatusIndicator
local StatusIndicatorShape = Foundation.Enums.StatusIndicatorShape
local StatusIndicatorSize = Foundation.Enums.StatusIndicatorSize
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant
local useLocalization = require(ServerDrivenUiParent.Localization).Hooks.useLocalization

local SduiTileFooter = require(ServerDrivenUi.Content.SduiTileFooter)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiParsers = SduiCoreSystem.SduiParsers
local UserProfiles = require(ServerDrivenUiParent.UserProfiles)
local useUserProfilesFetch = UserProfiles.Hooks.useUserProfilesFetch
local SduiInGameFriendsData = require(ServerDrivenUi.DataStore.SduiInGameFriendsData)
local DataHydration = require(ServerDrivenUiParent.DataHydration)
local _UserProfile = require(ServerDrivenUiParent.DataHydration.UserProfile)
local getAndFetchUserNamesByUserIds = DataHydration.UserProfile.getAndFetchUserNamesByUserIds

local FFlagHomeFriendNamesUseUserProfileHydration = require(ServerDrivenUiParent.SharedFlags).FFlagHomeFriendNamesUseUserProfileHydration
local FFlagSduiActiveFriendsFooterTreatment = require(ServerDrivenUiParent.SharedFlags).FFlagSduiActiveFriendsFooterTreatment
local FFlagSduiGameTileFixFacePileZIndex = require(ServerDrivenUiParent.SharedFlags).FFlagSduiGameTileFixFacePileZIndex

local function getUserIdsForFacePile(tbl1, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local userIdsForFacePile = ({})
    for i = 1, num1 do
        userIdsForFacePile[i] = tbl1[i].userId
    end

    return userIdsForFacePile
end

local function getDisplayText(tbl1, separator: string, num1: number): string
    local tbl2 = ({})
    for i = 1, num1 do
        tbl2[i] = tbl1[i].displayName
    end

    return table.concat(tbl2, separator)
end

local function getFormattedText(tbl1, num1: number, tbl2)
    if num1 == 0 then
        return nil
    end

    local var1 = if num1 == 1 then tbl2.textFormatOne elseif num1 == 2 then tbl2.textFormatTwo else tbl2.textFormatMany

    if not var1 or var1 == "" then
        return nil
    end

    local displayName = if tbl1[1] then tbl1[1].displayName else nil

    if not displayName and var1:find("{name}", 1, true) then
        return nil
    end

    local tbl3 = {
        name = displayName or "",
        count = tostring(num1 - 1)
    }

    return (var1:gsub("{(%w+)}", tbl3))
end

local function alphabeticalSort(tbl1, tbl2): boolean
    return if tbl1.displayName then not tbl2.displayName or tbl1.displayName:lower() < tbl2.displayName:lower() else false
end

local function getSortedFriendNames(tbl1, arg1)
    local sortedFriendNames = {}
    if arg1.status == DataHydration.DataStatus.NotReady then
        return sortedFriendNames
    end
    for _, userId in tbl1 do
        local var1 = arg1.namesByUserId[tostring(userId)]
        if var1 then
            table.insert(sortedFriendNames, { userId = userId, displayName = var1.combinedName })
        end
    end
    table.sort(sortedFriendNames, alphabeticalSort)
    return sortedFriendNames
end

local function getSortedFriendDisplayNames(arg1, arg2)
    if not (arg1 and arg2 and arg2.data) then
        return {}
    end

    local sortedFriendDisplayNames = {}
    for _, userId in arg1 do
        table.insert(
            sortedFriendDisplayNames,
            {
                userId = userId,
                displayName = UserProfiles.Selectors.getCombinedNameFromId(arg2.data, userId)
            }
        )
    end
    table.sort(sortedFriendDisplayNames, alphabeticalSort)
    return sortedFriendDisplayNames
end

return React.memo(function(tbl1) -- name: SduiGameTileActiveFriendsFooter
    local layoutOrder = tbl1.layoutOrder
    local anchorPoint = tbl1.anchorPoint
    local automaticSize = tbl1.automaticSize
    local size = tbl1.size
    local zIndex = tbl1.zIndex
    local position = tbl1.position

    local var1 = useTokens()

    local var2 = tbl1.iconWidth or var1.Size.Size_500

    local onActivated = React.useCallback(function(arg1)
        if tbl1.onActivated then
            tbl1.onActivated(arg1)
            return
        end
        local var3 = SduiParsers.safeParseCallback(
            {
                actionType = SduiActionType.OpenJoinFriends,
                actionParams = {
                    placeId = tbl1.placeId,
                    universeId = tbl1.universeId
                }
            },
            tbl1.sduiContext,
            tbl1.analyticsContext
        )

        if var3 then
            var3(arg1)
        end
    end, {
        tbl1.placeId,
        tbl1.universeId,
        tbl1.analyticsContext,
        tbl1.onActivated,
        tbl1.sduiContext
    })
    local var4 = useLocalization({ separator = "Feature.GameDetails.Label.FriendsSeparator" })

    local getInGameFriendsByGame = SduiInGameFriendsData.getInGameFriendsByGame

    local var5 = SignalsReact.useSignalState(getInGameFriendsByGame)
    local userIds = React.useMemo(function()
        local result = {}
        for value, _ in var5[tbl1.universeId] or {} do
            table.insert(result, value)
        end
        return result
    end, { var5, tbl1.universeId })

    local var7 = if FFlagHomeFriendNamesUseUserProfileHydration then nil else useUserProfilesFetch(
        {
            userIds = userIds,
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds,
            skip = #userIds == 0
        }
    )
    local var8 = nil
    if FFlagHomeFriendNamesUseUserProfileHydration then
        local str1 = table.concat(userIds, ",")
        local var9 = React.useMemo(function()
            return getAndFetchUserNamesByUserIds(string.split(str1, ","))
        end, { str1 })
        var8 = SignalsReact.useSignalState(var9)
    end

    local var9 = React.useMemo(function()
        if var8 then
            return (getSortedFriendNames(userIds, var8))
        end
        return (getSortedFriendDisplayNames(userIds, var7))
    end, { userIds, var7, var8 })

    local num1 = math.min(tbl1.maxAvatars or 3, #var9)
    local leftText = if FFlagSduiActiveFriendsFooterTreatment then getFormattedText(var9, #userIds, tbl1) or getDisplayText(var9, var4.separator, num1) else getDisplayText(var9, var4.separator, num1)
    local userIdsForFacePile = getUserIdsForFacePile(var9, num1)
    local tbl2 = ({})
    for i = 1, num1 do
        local var11 = userIdsForFacePile[i]
        local str1 = `userId_{i}`
        local createElement = React.createElement
        local str2 = "ImageLabel"
        local tbl3 = {
            LayoutOrder = i,
            BackgroundTransparency = 0,
            BackgroundColor3 = var1.Color.Content.Muted.Color3,
            Image = `rbxthumb://type=AvatarHeadShot&id={var11}&w=100&h=100`,
            Size = UDim2.fromOffset(var2, var2),
            Position = UDim2.fromOffset((i - 1) * var2 / 2, 0),
            ZIndex = if FFlagSduiGameTileFixFacePileZIndex then num1 - i + 1 else nil
        }
        local tbl4 = {
            BorderRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
            Border = if tbl1.hideBorder then nil else React.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = var1.Color.System.Emphasis.Color3,
                Transparency = 0,
                Thickness = 1
            }),
            PresenceDot = if FFlagSduiActiveFriendsFooterTreatment and tbl1.showPresenceDot then React.createElement(
                StatusIndicator,
                {
                    variant = StatusIndicatorVariant.Success,
                    shape = StatusIndicatorShape.Circle,
                    size = StatusIndicatorSize.XSmall,
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.fromScale(1, 1)
                }
            ) else nil
        }
        tbl2[str1] = createElement(str2, tbl3, tbl4)
    end

    return React.createElement(SduiTileFooter, {
        position = position,
        anchorPoint = anchorPoint,
        automaticSize = automaticSize,
        size = size,
        layoutOrder = layoutOrder,
        zIndex = zIndex,
        sduiContext = tbl1.sduiContext,
        textIconGap = if FFlagSduiActiveFriendsFooterTreatment then tbl1.textIconGap or var1.Gap.Small else var1.Gap.Small,
        leftText = leftText,
        leftTextFlexMode = Enum.UIFlexMode.Shrink,
        leftIconComponent = React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            tbl2
        ),
        onActivated = onActivated,
        testId = tbl1.testId
    })
end)
