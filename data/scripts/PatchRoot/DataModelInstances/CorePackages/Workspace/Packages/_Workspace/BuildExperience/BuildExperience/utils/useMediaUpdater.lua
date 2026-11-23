-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Promise = require(BuildExperienceParent.Promise)

local getAssetUserAuthStore = require(BuildExperienceParent.DataHydration.AssetUserAuth).getAssetUserAuthStore

local debug2 = require(BuildExperienceParent.DataHydration.CreatorAgentChat).debug

local formatError = require(script.Parent.formatError)

local function useMediaUpdater(tbl1)
    local var1 = React.useRef(Promise.resolve())
    local onSuccess = tbl1 and tbl1.onSuccess
    local onError = tbl1 and tbl1.onError

    local var2 = React.useCallback(function(func1: (...any) -> (...any), str1: string)
        debug2.log("info", `media_updater {str1} enqueued`)
        local var2 = var1.current:catch(function()
            return nil
        end):andThen(func1):andThen(function(arg1)
            return getAssetUserAuthStore().pollUntilDone(arg1)
        end):andThen(function(arg1)
            if typeof(arg1) == "table" and arg1.status == "timed_out" then
                return Promise.reject("Operation did not complete in time")
            end
            return if arg1.status == "done" then arg1.operation else arg1
        end)

        var1.current = var2:catch(function()
            return nil
        end)

        return var2:andThen(function<T>(arg1: T): T
            debug2.log("info", `media_updater {str1} succeeded`)
            if onSuccess then
                onSuccess()
            end
            return arg1
        end):catch(function(arg1)
            local error = formatError(arg1)
            debug2.log("warn", `media_updater {str1} failed`, { error = error })
            if onError then
                onError(error)
            end
            return Promise.reject(arg1)
        end)
    end, { onSuccess, onError })

    return {
        setIcon = React.useCallback(function(str1: string, arg1)
            return var2(function()
                return Promise.resolve(arg1):andThen(function(str2: string)
                    return getAssetUserAuthStore().updateIcon(str1, str2)
                end)
            end, "setIcon")
        end, { var2 }),
        addPreview = React.useCallback(function(str1: string, arg1)
            return var2(function()
                local assetUserAuthStore = getAssetUserAuthStore()
                return Promise.resolve(arg1):andThen(function(str2: string)
                    return assetUserAuthStore.getPreviews(str1):andThen(function(tbl2)
                        local var3 = table.clone(tbl2)
                        table.insert(var3, { asset = `assets/{str2}` })
                        return assetUserAuthStore.updatePreviews(str1, var3)
                    end)
                end)
            end, "addPreview")
        end, { var2 }),
        replacePreview = React.useCallback(function(str1: string, arg1, asset: string)
            return var2(function()
                local assetUserAuthStore = getAssetUserAuthStore()
                return Promise.resolve(arg1):andThen(function(str2: string)
                    return assetUserAuthStore.getPreviews(str1):andThen(function(tbl2)
                        local var3 = nil
                        for value, value2 in tbl2 do
                            if value2.asset == asset then
                                var3 = value
                                break
                            end
                        end

                        if var3 == nil then
                            return Promise.reject(`Preview "{asset}" not found`)
                        end
                        local var4 = table.clone(tbl2)
                        local var5 = table.clone(tbl2[var3])
                        var5.asset = `assets/{str2}`
                        var4[var3] = var5
                        return assetUserAuthStore.updatePreviews(str1, var4)
                    end)
                end)
            end, "replacePreview")
        end, { var2 }),
        removePreview = React.useCallback(function(str1: string, asset: string)
            return var2(function()
                local assetUserAuthStore = getAssetUserAuthStore()
                return assetUserAuthStore.getPreviews(str1):andThen(function(tbl2)
                    local var3 = nil
                    for value, value2 in tbl2 do
                        if value2.asset == asset then
                            var3 = value
                            break
                        end
                    end

                    if var3 == nil then
                        return Promise.reject(`Preview "{asset}" not found`)
                    end
                    local var4 = table.clone(tbl2)
                    table.remove(var4, var3)
                    return assetUserAuthStore.updatePreviews(str1, var4)
                end)
            end, "removePreview")
        end, { var2 })
    }
end

return useMediaUpdater
