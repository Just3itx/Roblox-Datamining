-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")
local Players = game:GetService("Players")

local bool1 = game:DefineFastFlag("FFlagLogFirstGuacRead", false)
local bool2 = game:DefineFastFlag("FFlagLogAllGuacRead", false)
local bool3 = game:DefineFastFlag("CacheReadParsePolicy", false)
local bool4 = game:DefineFastFlag("FixPolicyStalePlayerUpdates", false)
local bool5 = game:DefineFastFlag("ClearPolicyOnLogout", false)

local default = nil
if bool1 then
    local CorePackages = game:GetService("CorePackages")
    default = require(CorePackages.Workspace.Packages.LoggingProtocol).default
end

return function(arg1)
    arg1 = arg1 or {}
    arg1.HttpService = arg1.HttpService or HttpService
    arg1.MemStorageService = arg1.MemStorageService or MemStorageService
    arg1.PlayersService = arg1.PlayersService or Players

    assert(arg1.HttpService, "expected dependencies.HttpService")
    assert(arg1.MemStorageService, "expected dependencies.MemStorageService")
    assert(arg1.PlayersService, "expected dependencies.PlayersService")

    local HttpService2 = arg1.HttpService
    local MemStorageService2 = arg1.MemStorageService
    local playersService = arg1.PlayersService
    local bool6 = false

    return function(arg2)
        assert(arg2, "expected behavior")

        local function getStoreKey() -- Luacid: Inlined by compiler; 3 call sites recovered
            local localPlayer = playersService.LocalPlayer
            return "GUAC:" .. (if localPlayer and localPlayer.UserId > 0 then localPlayer.UserId else -1) .. ":" .. arg2
        end

        local var1 = "GUAC:" .. -1 .. ":" .. arg2

        local var2 = nil
        local var3 = nil
        local var4 = nil
        local var5 = nil

        local bindableEvent = Instance.new("BindableEvent")

        local function onPolicyUpdated(arg3)
            if arg3 == var4 or not arg3 or not (#arg3 > 0) then
                return
            end

            local success, result = pcall(function()
                return HttpService2:JSONDecode(arg3)
            end)
            if success then
                var4 = arg3
                var5 = result
                bindableEvent:Fire(result)
            end
        end

        if bool3 then
            local connection = nil
            local function invalidateForKeyChange()
                local var6 = if bool5 then var2 else nil
                var5 = nil
                var4 = nil

                if not var3 then
                    var2 = nil

                    return
                end

                var3:Disconnect()
                var3 = nil
                local storeKey = getStoreKey()

                if bool5 and var6 and var6 ~= storeKey and storeKey == var1 then
                    MemStorageService2:RemoveItem(storeKey)
                end

                var2 = storeKey
                var3 = MemStorageService2:BindAndFire(storeKey, onPolicyUpdated)
            end

            local function localPlayerChanged()
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
                if playersService.LocalPlayer then
                    connection = playersService.LocalPlayer:GetPropertyChangedSignal("UserId"):Connect(function()
                        if bool4 then
                            invalidateForKeyChange()
                            return
                        end
                        var5 = nil
                    end)
                end

                if bool4 then
                    invalidateForKeyChange()
                    return
                end
                var5 = nil
            end

            playersService:GetPropertyChangedSignal("LocalPlayer"):Connect(localPlayerChanged)
            localPlayerChanged()
        end

        return {
            read = function()
                if bool3 and var5 then
                    return var5
                end

                local storeKey = getStoreKey()
                local item = MemStorageService2:GetItem(storeKey)
                if item and #item > 0 then
                    local success, result = pcall(function()
                        return HttpService2:JSONDecode(item)
                    end)
                    if success then
                        if bool2 then
                            default:logEvent("lua_policy_read_success")
                        elseif bool1 and not bool6 then
                            default:logEvent("lua_policy_read_success")
                            bool6 = true
                        end

                        var5 = result
                        var4 = item
                        return result
                    end
                end

                return nil
            end,
            onPolicyChanged = function(callback)
                local storeKey = getStoreKey()
                local connection = bindableEvent.Event:Connect(callback)

                if var3 and var2 == storeKey then
                    if var5 then
                        callback(var5)
                        return connection
                    end
                else
                    if var3 then
                        var3:Disconnect()
                    end
                    var2 = storeKey
                    var3 = MemStorageService2:BindAndFire(storeKey, onPolicyUpdated)
                end

                return connection
            end
        }
    end
end
