-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _Signals = require(AppChatParent.Signals)
local createSessionScopedSignal = require(AppChatParent.SignalsUtils).createSessionScopedSignal

local tbl1 = { screen = nil, params = nil, requestId = 0, completedRequestId = 0 }

local function createExternalNavigationRequestStore()
    local getRequest, var2 = createSessionScopedSignal(tbl1)

    return {
        getRequest = getRequest,
        navigateIntoChat = function(screen: string?, params)
            local var3 = getRequest(false)

            local var4 = var2
            local tbl2 = { screen = 0, params = 0, requestId = 0, completedRequestId = 0 }
            if screen == nil then
                screen = var3.screen
            end

            tbl2.screen = screen
            if params == nil then
                params = var3.params
            end

            tbl2.params = params
            tbl2.requestId = var3.requestId + 1
            tbl2.completedRequestId = var3.completedRequestId
            var4(tbl2)
        end,
        completeExternalNavigation = function(completedRequestId: number)
            local var3 = getRequest(false)
            var2(
                {
                    screen = var3.screen,
                    params = var3.params,
                    requestId = var3.requestId,
                    completedRequestId = completedRequestId
                }
            )
        end,
        reset = function()
            var2(tbl1)
        end
    }
end
return createExternalNavigationRequestStore
