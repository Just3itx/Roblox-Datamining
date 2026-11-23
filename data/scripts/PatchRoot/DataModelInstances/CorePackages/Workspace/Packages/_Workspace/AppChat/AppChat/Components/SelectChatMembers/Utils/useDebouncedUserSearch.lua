-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local _ConversationChannels = require(AppChat.Models.ConversationChannels)

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local List = require(AppChatParent.Cryo).List
local NetworkingFriends = require(AppChat.Http.NetworkingFriends)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local LuauPolyfill = require(AppChatParent.LuauPolyfill)
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout

local isUserInConversation = require(script.Parent.isUserInConversation)
local Logger = require(script.Parent.Parent.Logger)

local function useDebouncedUserSearch(arg1)
    local var1 = useDispatch()
    local var2 = useLocalUserId()
    local var3 = React.useRef(setTimeout(function() end, 250))
    local var4 = React.useRef("")
    local var5, var6 = React.useState({})

    local var7 = React.useCallback(function(query)
        var1(NetworkingFriends.SearchFriendsByQuery.API(var2, { query = query, limit = 20 })):andThen(function(arg2)
            local var7 = List.map(arg2.responseBody.PageItems, function(arg3): string
                return tostring(arg3.id)
            end)
            local var8 = arg1 or {
                participants = {}
            }

            var6(Cryo.List.filter(var7, function(arg3): boolean
                return not isUserInConversation(arg3, var8)
            end))
        end):catch(function(arg2)
            Logger:error("Error searching friends:", arg2)
            var6({})
        end)
    end, { var1, var2, arg1 })

    local var8 = React.useCallback(function(current: string)
        clearTimeout(var3.current)
        var4.current = current
        var3.current = setTimeout(function()
            if current ~= "" then
                var7(current)
                return
            end
            var6({})
        end, 250)
    end, { var7 })

    React.useEffect(function()
        return function()
            clearTimeout(var3.current)
        end
    end, {})

    return var5, var8, var4.current
end

return useDebouncedUserSearch
