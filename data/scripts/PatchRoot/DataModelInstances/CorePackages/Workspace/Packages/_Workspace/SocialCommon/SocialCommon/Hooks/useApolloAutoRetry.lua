-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent

local React = require(SocialCommonParent.React)
local Cryo = require(SocialCommonParent.Cryo)
local var1 = require(SocialCommonParent.LuaSocialLibrariesDeps).SocialLibraries.config({})
local StatusCodesToRetry = require(script.Parent.StatusCodesToRetry)

local function shouldRetryRequest(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1.error then
        local deepValue = var1.Dictionary.getDeepValue(arg1, "error.graphQLErrors")
        if deepValue and deepValue[1] then
            local deepValue2 = var1.Dictionary.getDeepValue(deepValue[1], "extensions.status")
            return StatusCodesToRetry[deepValue2] or false
        end
    end

    return false
end

local function useApolloAutoRetry(arg1, tbl1)
    local retryCount, var3 = React.useState(0)
    local var4, var5 = React.useState(false)

    React.useEffect(function()
        if not shouldRetryRequest(arg1) or not (retryCount < tbl1.retryCount) or var4 then
            return
        end

        var5(true)

        task.delay(2 ^ retryCount + math.random(), function()
            arg1:refetch()
            var5(false)
            var3(retryCount + 1)
        end)
    end, { arg1, var4, retryCount })

    return (React.useMemo(function()
        return Cryo.Dictionary.join(
            arg1,
            {
                isRetrying = shouldRetryRequest(arg1) and retryCount < tbl1.retryCount,
                retryCount = retryCount
            }
        )
    end, { arg1, retryCount }))
end

return useApolloAutoRetry
