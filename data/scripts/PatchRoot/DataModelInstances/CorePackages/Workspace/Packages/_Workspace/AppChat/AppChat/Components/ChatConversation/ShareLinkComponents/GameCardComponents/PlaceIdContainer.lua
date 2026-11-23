-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local FFlagLuaAppDefaultHttpRetry = require(AppChatParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local useCallback = React.useCallback
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local getPlaceDetailsStore = require(AppChatParent.DataHydration.PlaceDetails).getPlaceDetailsStore
local DataStatus = require(AppChatParent.DataHydration).DataStatus

local Logger = require(AppChatParent.Loggers).Logger
local logger = Logger.new(Logger, "PlaceIdContainer")

local ApiFetchPlaceInfos = require(AppChatParent.PlaceInfoRodux).Thunks.ApiFetchPlaceInfos

local GameCardGroupable = require(script.Parent.GameCardGroupable)
local GameCardContainer = require(script.Parent.GameCardContainer)
local GameCardError = require(script.Parent.GameCardError)
local GameAssetCard = require(script.Parent.GameAssetCard)
local _MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)

local FFlagAppChatInvalidGameLinkCard = require(AppChat.Flags.FFlagAppChatInvalidGameLinkCard)
local FFlagAppChatUseDataHydrationForPlaceInfos = require(AppChat.Flags.FFlagAppChatUseDataHydrationForPlaceInfos)

local HttpRequest = require(AppChatParent.HttpRequest)
local config = HttpRequest.config

local tbl1 = {
    requestFunction = function(arg1, arg2, arg3)
        logger:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
        return HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("PlaceIdContainerHttpRetryCount", 4) else nil
}

local tbl2 = {
    networkImpl = config(tbl1)
}

local function getPlaceInfo(arg1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.ChatAppReducer.PlaceInfos[str1] or {}
end

local var1 = FFlagAppChatUseDataHydrationForPlaceInfos and function(str1: string, _) -- name: useDataHydrationUniverseId
    local placeDetailsStore = getPlaceDetailsStore(false)
    local var1 = React.useMemo(function()
        return placeDetailsStore.getAndFetchPlaceDetails(str1)
    end, { placeDetailsStore, str1 })
    local var2 = useSignalState(var1.data)
    local var3 = useSignalState(var1.status)
    local universeId = if var2 then var2.universeId else nil
    return universeId, var3 == DataStatus.Failed or var3 == DataStatus.Ready and universeId == nil
end or function(str1: string, arg1) -- name: useRoduxUniverseId
    local var1 = useDispatch()
    local var2 = useCallback(function(arg2, arg3)
        return var1(ApiFetchPlaceInfos(arg2, { arg3 }))
    end, { var1 })

    local var3 = useSelector(function(arg2)
        local universeId = getPlaceInfo(arg2, str1).universeId

        return if universeId then tostring(universeId) or nil else nil
    end)

    local var4 = not FFlagAppChatInvalidGameLinkCard and { current = nil } or React.useRef(nil)
    local var5 = nil
    local var6 = nil

    if FFlagAppChatInvalidGameLinkCard then
        local var7
        var5, var7 = React.useState(false)
        var6 = var7
    end

    useEffect(function()
        local bool1 = false
        var2(arg1, str1):andThen(function(arg2)
            if FFlagAppChatInvalidGameLinkCard then
                bool1 = not Cryo.isEmpty(arg2)
            end
        end)

        if not FFlagAppChatInvalidGameLinkCard then
            return
        end

        if not var3 then
            if var4.current then
                task.cancel(var4.current)
            end

            var4.current = task.delay(1, function()
                if not bool1 then
                    var6(true)
                end
                var4.current = nil
            end)
        end

        return function()
            if var4.current then
                task.cancel(var4.current)
                var4.current = nil
            end
        end
    end, {})

    if FFlagAppChatInvalidGameLinkCard then
        useEffect(function()
            if var3 and var4.current then
                task.cancel(var4.current)
                var4.current = nil
            end
        end, { var3 })
    end

    return var3, var5
end

function PlaceIdContainer(arg1)
    local var2 = Cryo.Dictionary.join(tbl2, arg1)

    local universeId, var4 = var1(var2.placeId, var2.networkImpl)

    if not universeId and var2.groupShape then
        return React.createElement(GameAssetCard, {
            isLoading = true,
            isError = FFlagAppChatInvalidGameLinkCard and var4,
            groupShape = var2.groupShape,
            mediaRef = var2.mediaRef
        })
    elseif not universeId then
        if FFlagAppChatInvalidGameLinkCard and var4 then
            return React.createElement(GameCardError, {})
        end
        return React.createElement(GameCardGroupable, { isLoading = true, gameName = "", gameThumbnail = "" })
    else
        return React.createElement(GameCardContainer, Cryo.Dictionary.join(var2, { universeId = universeId }))
    end
end

return memo(PlaceIdContainer)
