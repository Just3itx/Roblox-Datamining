-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)
local Signals = require(GameJoinCardParent.Signals)
local SignalsReact = require(GameJoinCardParent.SignalsReact)
local Foundation = require(GameJoinCardParent.Foundation)
local DataHydration = require(GameJoinCardParent.DataHydration)
local UserProfileStore = require(GameJoinCardParent.UserProfiles.Stores).UserProfileStore
local useExperienceBannerImage = require(GameJoinCardParent.GameDetail).useExperienceBannerImage
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction
local useLocalization = require(GameJoinCardParent.Localization).Hooks.useLocalization

local _Types = require(GameJoinCard.Components.Actions.Types)
local TextKeys = require(GameJoinCard.Components.Actions.TextKeys)
local _MobileGameJoinCard = require(GameJoinCard.Components.MobileGameJoinCard.MobileGameJoinCard)
local _Types2 = require(script.Parent.Types)

local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local DataStatus = DataHydration.DataStatus
local PresenceType = DataHydration.Presence.PresenceEnums.PresenceType
local var1 = DataHydration.Presence.PresenceStore.get()
local var2 = UserProfileStore.get()

local function noop() end

local function isInGame(presence): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (presence == nil or presence.userPresenceType ~= PresenceType.InGame) and presence.universeId ~= ""
end

local function useInExperienceGameJoinCardViewModel(arg1)
    local userId = arg1.userId
    local onJoin = arg1.onJoin
    local onClose = arg1.onClose

    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local presenceByUserId = var1.GetPresenceByUserId(userId)
            local presence = presenceByUserId.data(arg2)
            return {
                presence = presence,
                isLoading = presence == nil and presenceByUserId.status(arg2) == DataStatus.NotReady
            }
        end)
    end, { userId })
    local var4 = SignalsReact.useSignalState(var3)
    local presence = var4.presence
    local isInExperience = isInGame(presence)

    local var5 = React.useMemo(function()
        return var2.fetchNamesByUserIds({ userId })
    end, { userId })
    local var6 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local var6 = var5(arg2)
            local var7 = var6 and var6.data and var6.data[1]
            local name = if var7 and var7.names then var7.names.getCombinedName(arg2) else ""
            return {
                name = name,
                isLoading = name == "" and var6 ~= nil and var6.status == "fetching"
            }
        end)
    end, { var5 })
    local var7 = SignalsReact.useSignalState(var6)

    local var8, var9 = React.useState(nil)
    React.useEffect(function()
        if isInExperience then
            var9(presence)
        end
    end, { presence, isInExperience })
    if isInExperience then
        var8 = presence
    end
    local universeId = if var8 then var8.universeId else ""
    local rootPlaceId = if var8 and var8.rootPlaceId ~= "" then var8.rootPlaceId else nil
    local var11 = useExperienceBannerImage(universeId, rootPlaceId)
    local thumbnailImageUrl = if universeId == "" then nil else getRbxThumb(ThumbnailType.GameIcon, universeId, ThumbnailSize.Medium)

    local var12 = React.useMemo(function()
        if not isInExperience or presence == nil then
            return nil
        end

        return {
            userId = userId,
            placeId = presence.placeId,
            rootPlaceId = presence.rootPlaceId,
            universeId = presence.universeId
        }
    end, { userId, presence, isInExperience })

    local var13 = React.useRef(false)
    local var14 = React.useCallback(function()
        if var13.current or var12 == nil then
            return
        end
        var13.current = true
        onJoin(var12)
        onClose()
    end, { var12, onJoin, onClose })

    local var15 = useLocalization({ join = TextKeys[UserCtaAction.JoinExperience] })

    local isLoading = var4.isLoading or var7.isLoading

    local actions = {{
        id = UserCtaAction.JoinExperience,
        text = var15.join,
        variant = ButtonVariant.Emphasis,
        inputSize = InputSize.Medium,
        width = UDim.new(1, 0),
        isLoading = isLoading,
        isDisabled = not isInExperience,
        keepOpenOnActivate = true,
        onActivated = var14
    }}

    return {
        onClose = onClose,
        onJoin = var14,
        onViewProfile = nil,
        onViewExperienceDetails = nil,
        userId = userId,
        universeId = universeId,
        playerName = var7.name,
        experienceName = if var8 then var8.lastLocation else "",
        bannerImageUrl = var11.url,
        thumbnailImageUrl = thumbnailImageUrl,
        onChat = noop,
        canUsePlatformChat = false,
        isLoading = isLoading,
        isInExperience = isInExperience,
        ageCheckRequired = false,
        actions = actions,
        areActionsLoading = false,
        disableAppTelemetry = true
    }
end

return useInExperienceGameJoinCardViewModel
