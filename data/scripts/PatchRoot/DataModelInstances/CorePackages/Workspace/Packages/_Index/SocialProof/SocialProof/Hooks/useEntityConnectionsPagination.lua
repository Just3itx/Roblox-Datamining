-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent

local React = require(SocialProofParent.React)
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useState = React.useState
local RoactUtils = require(SocialProofParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local getDeepValue = require(SocialProofParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue
local Cryo = require(SocialProofParent.Cryo)
local NetworkingSocialProof = require(SocialProof.Networking.NetworkingSocialProof)
local Constants = require(SocialProof.Common.Constants)
local _Enums = require(SocialProof.Common.Enums)

return function(tbl1)
    local var1 = useDispatch()
    local entityId = tbl1.entityId
    local entityType = tbl1.entityType
    local connectionType = tbl1.connectionType

    local isLoading, var3 = useState(false)
    local hasMore, var5 = useState(true)
    local error, var7 = useState(nil)
    local cursor, var9 = useState("")
    local userIds, var11 = useState({})
    local var12 = useRef(true)
    local totalConnections, var14 = useState(0)

    local var15 = useSelector(function(arg1)
        local connectionsByEntityId = arg1[Constants.RODUX_KEY].ConnectionsByEntityId or {}
        local str1 = string.format("%s.%s.%s", connectionType, entityType, entityId)
        return getDeepValue(connectionsByEntityId, str1) or {}
    end)

    useEffect(function()
        if not var15.userIds then
            return
        end

        local userIds2 = var15.userIds

        local num1 = #userIds + #userIds2
        local totalConnections = var15.totalConnections or 0
        local bool1 = num1 < totalConnections
        var14(totalConnections)
        var5(bool1)
        var9(tostring(num1))

        var11(function(arg1)
            return Cryo.List.join(arg1, userIds2)
        end)
    end, { var15.userIds, var15.totalConnections })

    local fetchPage = useCallback(function()
        if isLoading or not hasMore then
            return
        end

        var3(true)
        var7(nil)

        var1(
            NetworkingSocialProof.GetConnectionsByEntityId.API(
                {
                    entityId = entityId,
                    entityType = entityType,
                    connectionType = connectionType,
                    cursor = cursor
                }
            )
        ):andThen(
            function()
                if var12.current then
                    var3(false)
                end
            end
        ):catch(
            function(arg1)
                if var12.current then
                    var3(false)
                    var7(arg1)
                end
            end
        )
    end, {
        cursor,
        isLoading,
        hasMore,
        entityId,
        entityType,
        connectionType,
        var1
    })
    local reset = useCallback(function()
        var11({})
        var5(true)
        var3(false)
        var7(nil)
    end, {})

    useEffect(function()
        if entityId and entityType and connectionType and not var15.userIds then
            fetchPage()
        end
    end, {
        entityId,
        entityType,
        connectionType,
        var15.userIds
    })
    return {
        userIds = userIds,
        isLoading = isLoading,
        hasMore = hasMore,
        error = error,
        fetchPage = fetchPage,
        reset = reset,
        totalConnections = totalConnections
    }
end
