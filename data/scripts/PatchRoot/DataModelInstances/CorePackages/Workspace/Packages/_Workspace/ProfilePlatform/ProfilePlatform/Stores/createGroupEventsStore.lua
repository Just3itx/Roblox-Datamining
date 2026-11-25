-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local UrlBuilder = require(ProfilePlatformParent.UrlBuilder).UrlBuilder
local Signals = require(ProfilePlatformParent.Signals)
local HttpStore = require(ProfilePlatformParent.HttpStore)

local FFlagLuaAppUseAppHttpStore = require(ProfilePlatformParent.SharedFlags).FFlagLuaAppUseAppHttpStore
local InternalHttpStore = require(ProfilePlatformParent.InternalHttpStore)

local _GraphQLServer = require(ProfilePlatform.Parent.GraphQLServer)

local string2 = UrlBuilder.fromString("apis:virtual-events/v1/virtual-events/groups/{id}")
local string3 = UrlBuilder.fromString("apis:virtual-events/v1/virtual-events/{eventId}/rsvps")

local FFlagEnableCommunityProfileLoadingSkeletons = require(ProfilePlatform.Flags.FFlagEnableCommunityProfileLoadingSkeletons)

local tbl1 = {}

local function createGroupEventsStore(id: number)
    local httpStore = InternalHttpStore.GetHttpStore()
    if FFlagLuaAppUseAppHttpStore then
        httpStore = HttpStore.Instance.get() or httpStore
    end

    local var1, var2 = Signals.createSignal(0)

    local tbl2 = {}
    local var3, var4 = Signals.createSignal(tbl2)
    local function func1(id, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var5 = table.clone(tbl2)
        var5[id] = arg1
        var4(var5)
        tbl2 = var5
    end

    local computed = Signals.createComputed(function(arg1)
        local var5 = var1(arg1)
        local str1 = string.format("GetEvents_%d_%d", id, var5)
        local tbl3 = {
            Url = string2({ id = id }),
            Method = "GET"
        }

        return httpStore.fetch(str1, tbl3)
    end)

    local tbl3 = tbl1
    local effect = nil

    local module = {
        getEvents = Signals.createComputed(function(arg1)
            local var5 = computed(arg1)(arg1)
            local var6 = var3(arg1)

            if var5.status ~= "Success" then
                return if var5.status == "Failed" then {} else tbl3
            end

            local result = ({})
            local success, result2 = pcall(HttpService.JSONDecode, HttpService, var5.response.Body)
            if success and result2 ~= nil and result2.data ~= nil then
                for k, value in pairs(result2.data) do
                    local universeId = value.universeId
                    value.universeId = tostring(universeId)

                    local userRsvpStatus = var6[value.id]
                    if userRsvpStatus ~= nil then
                        value.userRsvpStatus = userRsvpStatus
                    end

                    result[k] = value
                end
            end

            tbl3 = result
            return result
        end),
        isLoading = if FFlagEnableCommunityProfileLoadingSkeletons then Signals.createComputed(function(arg1): boolean
            return computed(arg1)(arg1).status == "Fetching"
        end) else nil,
        updateRsvpStatus = 0,
        refetch = 0
    }

    function module.updateRsvpStatus(arg1, rsvpStatus)
        local str1 = string.format("UpdateEventRsvpStatus_%s_%s", arg1.id, rsvpStatus)
        local tbl4 = {
            Url = string3({ eventId = arg1.id }),
            Method = "POST",
            Body = HttpService:JSONEncode({ rsvpStatus = rsvpStatus }),
            Headers = { ["Content-Type"] = "application/json" }
        }
        local var5 = httpStore.fetch(str1, tbl4)

        local var6 = tbl2[arg1.id]
        func1(arg1.id, rsvpStatus)

        if effect then
            effect()
        end
        effect = Signals.createEffect(function(arg2)
            if var5(arg2).status == "Failed" then
                func1(arg1.id, var6)
            end
        end)

        return var5
    end

    function module.refetch()
        var2(function(arg1): number
            return arg1 + 1
        end)

        var4(function(_)
            return {}
        end)
    end

    return module
end

return createGroupEventsStore
