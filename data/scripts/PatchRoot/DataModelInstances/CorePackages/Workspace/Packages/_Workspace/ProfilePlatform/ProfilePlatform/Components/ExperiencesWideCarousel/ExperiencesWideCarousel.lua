-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local IXPService = game:GetService("IXPService")
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local CollectionCarousel = require(ProfilePlatformParent.CollectionViews).CollectionCarousel
local CollectionHeader = require(ProfilePlatformParent.CollectionViews).CollectionHeader
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local NetworkingGames = require(ProfilePlatform.Networking.NetworkingGames)
local useSendItemImpressions = require(ProfilePlatform.Hooks.useSendItemImpressions)
local formatExperienceDetailsForImpressions = require(ProfilePlatform.Hooks.formatExperienceDetailsForImpressions)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Common.Types)
local useRoactService = require(ProfilePlatformParent.RobloxAppHooks).useRoactService
local RoactAnalyticsCommonGameEvents = require(ProfilePlatformParent.RoactServiceTags).RoactAnalyticsCommonGameEvents
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation
local OpenGameDetails = require(ProfilePlatformParent.GameDetail).OpenGameDetails
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage

local SetGameVotes = require(ProfilePlatformParent.GameVotesRodux).GameVotes.SetGameVotes
local Url = require(ProfilePlatformParent.Http).Url

local myRoduxNetworkingImpl = require(ProfilePlatform.Networking.myRoduxNetworkingImpl)

local GameTile = require(ProfilePlatformParent.GameTile)
local GameTileView = GameTile.GameTileView
local GameTileViewConfig = GameTile.GameTileViewConfig
local GameStats = GameTile.GameStats
local formatExperienceThumbnail = GameTile.formatExperienceThumbnail

local useDesignTokens = require(ProfilePlatformParent.Style).useDesignTokens
local useTextSizeOffset = require(ProfilePlatformParent.UIBlox).Core.Style.useTextSizeOffset

local ContentType = require(ProfilePlatformParent.UnifiedLogging).ContentType

local bool1 = game:DefineFastFlag("ExperiencesOnProfileIxpEnabled", false)
local layerName = game:DefineFastString("ExperiencesOnProfileIxpLayer", "")

local tbl1 = ({})

local function chunkList(tbl2, num1: number)
    local num2 = 1
    local result = {}

    while num2 <= #tbl2 do
        local tbl3 = {}
        local num3 = num2 + num1 - 1
        local num4 = #tbl2

        for i = num2, math.min(num3, num4) do
            table.insert(tbl3, tbl2[i])
        end
        table.insert(result, tbl3)
        num2 += num1
    end
    return result
end

local function formatVotePercent(upVotes: number?, downVotes: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = math.max(0, upVotes or 0)
    local num2 = num1 + math.max(0, downVotes or 0)

    if num2 == 0 then
        return nil
    end

    return tostring(math.floor(num1 / num2 * 100 + 0.5)) .. "%"
end

local function getGameVotes(myRoduxNetworkingImpl2, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return myRoduxNetworkingImpl2(string.format("%sv1/games/%s/votes", Url.GAME_URL, str1), "GET")
end

return React.memo(function(tbl2) -- name: ExperiencesWideCarousel
    local sideMargin, var1 = useDynamicSizeMargin()
    local var2 = useDesignTokens()
    local var3 = useTextSizeOffset()
    local var4 = useLocalization({ title = TextKeys.Experiences })

    local var5, var6 = React.useState(0)
    local var7, var8 = React.useState(0)
    local var9, var10 = React.useState(0)

    local var11 = useDispatch()

    local var12 = useProfileWrapperContext()
    local profileId = var12 and var12.profileId
    local var13 = useProfileAnalyticsContext()
    local eventNames = require(ProfilePlatform.Analytics.EventNames)
    local var14 = useRoactService(RoactAnalyticsCommonGameEvents)
    local var15 = useNavigation()

    local var16 = useSelector(function(arg1)
        return getDeepValue(arg1, "GameVotes") or {}
    end)

    local experiences = (useProfileJsonComponent(Enums.Components.Experiences) or {}).experiences or {}

    local var17 = React.useMemo(function()
        local result = {}
        for _, value in ipairs(experiences) do
            if value.universeId ~= nil then
                table.insert(result, tostring(value.universeId))
            end
        end
        return result
    end, { experiences })

    React.useEffect(function()
        if #var17 == 0 then
        end
    end, { var17 })

    local var18 = useSelector(function(arg1)
        return getDeepValue(arg1, "ProfilePlatform.Games.byGameId") or {}
    end)

    local var19 = React.useRef({ key = "", at = 0 })

    React.useEffect(function()
        if #var17 == 0 then
            return
        end

        local at = os.clock()
        local key = table.concat(var17, ",")
        local current = var19.current
        if key == current.key and at - current.at < 2 then
            return
        end

        var19.current = { key = key, at = at }

        local tbl3 = {}
        for _, value in var17 do
            if not tbl1[value] and var18[value] == nil then
                table.insert(tbl3, value)
            end
        end

        for _, value in chunkList(tbl3, 10) do
            var11(NetworkingGames.GetExperiencesDetails.API(value)):catch(function()
                for _, value2 in value do
                    tbl1[value2] = true
                end
            end)
        end

        local num1 = #var17

        for i = 1, math.min(6, num1) do
            local var20 = var17[i]
            if var16[var20] ~= nil then
                continue
            end

            getGameVotes(myRoduxNetworkingImpl, var20):andThen(function(arg1)
                local responseBody = arg1.responseBody
                if responseBody ~= nil and responseBody.upVotes ~= nil and responseBody.downVotes ~= nil then
                    var11(
                        SetGameVotes(
                            var20,
                            if responseBody.upVotes < 0 then 0 else responseBody.upVotes,
                            if responseBody.downVotes < 0 then 0 else responseBody.downVotes
                        )
                    )
                end
            end):catch(function() end)
        end
    end, { var17, var18, var16 })

    local items = React.useMemo(function()
        local result = {}
        for _, value in var17 do
            local var20 = var18[value]
            if var20 then
                table.insert(result, var20)
            end
        end
        return result
    end, { var17, var18 })

    local var21 = React.useMemo(function()
        return formatExperienceDetailsForImpressions(items)
    end, { items })

    local var22 = useSendItemImpressions(var21, 2, ContentType.Game, 1, "ExperiencesWideCarousel")

    local var23 = React.useCallback(function(experienceId: string, position: number, ccu: number?, votePercentage: string?, upVotes: number?, downVotes: number?, visits: number?)
        var13.fireAnalyticsEvent(eventNames.ExperienceOpened, {
            profileUserId = profileId,
            experienceId = experienceId,
            position = position,
            row = 1,
            ccu = ccu or 0,
            votePercentage = votePercentage,
            upVotes = upVotes or 0,
            downVotes = downVotes or 0,
            visits = visits or 0,
            section = "Experiences",
            layoutType = "Wide"
        })
    end, { var13, profileId })

    local renderItem = React.useCallback(function(arg1, layoutOrder: number, size)
        local image = formatExperienceThumbnail(nil, arg1.rootPlaceId)

        local footerMetadata = React.createElement(GameStats, {
            stats = {
                playerCount = arg1.playing or 0,
                totalUpVotes = var16[arg1.experienceId] and var16[arg1.experienceId].upVotes or 0,
                totalDownVotes = var16[arg1.experienceId] and var16[arg1.experienceId].downVotes or 0
            },
            isGridTile = true,
            gameTileLayoutType = "Wide"
        })

        return React.createElement("Frame", {
            Size = size,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        }, {
            Tile = React.createElement(GameTileView, {
                Size = UDim2.fromScale(1, 1),
                image = image,
                title = arg1.name,
                imageAspectRatio = GameTileViewConfig.getImageAspectRatio("Wide"),
                footerMetadata = footerMetadata,
                isHovered = false,
                onActivated = function()
                    local var25 = var16[arg1.experienceId]
                    local var26 = if var25 then formatVotePercent(var25.upVotes, var25.downVotes) or nil else nil
                    var23(
                        arg1.experienceId,
                        layoutOrder,
                        arg1.playing,
                        var26,
                        var25 and var25.upVotes or 0,
                        var25 and var25.downVotes or 0,
                        0
                    )

                    local num1 = #items
                    var14.reportOpenGameDetailFromProfile(
                        arg1.rootPlaceId,
                        layoutOrder,
                        num1,
                        arg1.experienceId,
                        AppPage.ProfilePlatform,
                        tbl2.layoutOrder,
                        1,
                        nil
                    )

                    var11(OpenGameDetails(arg1.experienceId, var15, { mountAsFullView = false, showBackButton = true }))
                end,
                hidePlayButton = true,
                isContained = false
            })
        }), "EXP_Tile"
    end, {
        var23,
        var5,
        sideMargin,
        var11,
        var15,
        var14,
        tbl2.layoutOrder,
        items,
        var16
    })

    local getItemHeight = React.useCallback(function(num1: number)
        if var9 ~= num1 then
            var10(num1)
        end
        return (GameTileViewConfig.getTileHeight(var2, num1, "Wide", false, false, false, var3, nil, nil, nil, nil, nil))
    end, { var2, var3, var9 })

    local var26 = React.useCallback(function(num1: number, num2: number): number
        return math.max(1, (math.max(0, num1 - num2 * 2) - 12) / 2)
    end, {})

    React.useEffect(function()
        if var5 <= 0 then
            return
        end

        local var27 = var26(var5, sideMargin)
        local var28 = if #items > 2 then math.clamp(60 / (var27 + 12), 0, 0.5) else 0
        var8(var28)
    end, {
        var5,
        sideMargin,
        items,
        var26
    })

    React.useEffect(function()
        if not (#items > 0) then
            return
        end
        local tbl3 = {}
        local num1 = #items

        for i = 1, math.min(2, num1) do
            table.insert(tbl3, i)
        end
        var22(tbl3)
    end, { items, var22 })

    React.useEffect(function()
        if #items > 0 and bool1 then
            IXPService:LogFlagLinkedUserLayerExposure(layerName)
        end
    end, { items })

    if #items == 0 then
        return nil
    end

    local createElement = React.createElement
    local tbl3 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl2.layoutOrder
    }

    tbl3[React.Change.AbsoluteSize] = function(arg1)
        var1(arg1)
        var6(arg1.AbsoluteSize.X)
    end

    return createElement("Frame", tbl3, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 16)
        }),
        Header = React.createElement(
            "Frame",
            {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            },
            {
                UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, sideMargin), PaddingRight = UDim.new(0, sideMargin) }),
                Content = React.createElement(CollectionHeader, { LayoutOrder = 1, title = var4.title, hideButton = true })
            }
        ),
        CollectionCarousel = React.createElement(CollectionCarousel, {
            LayoutOrder = 2,
            title = nil,
            items = items,
            renderItem = renderItem,
            getItemHeight = getItemHeight,
            numColumns = 2,
            fractionalItemAmount = #items > 2 and var7 or 0,
            columnGap = 12,
            sideMargin = sideMargin
        })
    })
end)
