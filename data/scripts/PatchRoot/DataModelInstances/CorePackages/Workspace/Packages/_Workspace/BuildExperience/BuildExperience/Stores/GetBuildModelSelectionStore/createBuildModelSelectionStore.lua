-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local SignalsUtils = require(BuildExperienceParent.SignalsUtils)
local LocalUserIdStore = require(BuildExperienceParent.LocalUserIdStore).LocalUserIdStore

local function createBuildModelSelectionStore(num1: number?)
    local function createAccount()
        return {
            userId = if num1 ~= nil then tostring(num1) else LocalUserIdStore.getCurrentUserId(false),
            entries = {}
        }
    end
    local var1, var2 = SignalsUtils.createSessionScopedSignal(createAccount)

    local num2 = 0

    local function isAuthenticated(tbl1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return (tonumber(tbl1.userId) or 0) > 0
    end

    local function createEntry(tbl1, identity: string)
        local var3, var4 = Signals.createSignal({ intendedTier = "default" })

        local computed = Signals.createComputed(function(arg1)
            local var5 = var3(arg1)
            return table.freeze({ intendedTier = var5.intendedTier, isBusy = var5.lock ~= nil })
        end, function(tbl2, tbl3): boolean
            return tbl2.intendedTier == tbl3.intendedTier and tbl2.isBusy == tbl3.isBusy
        end)

        local bool1 = false
        local var5, var6 = Signals.createSignal(true)

        local function isCurrent(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
            return var1(arg1) == tbl1 and var5(arg1)
        end

        return {
            identity = identity,
            retainers = 0,
            discardRequested = false,
            invalidate = function()
                var6(false)
            end,
            entry = {
                getSelection = function(arg1)
                    if isCurrent(arg1) then
                        return (computed(arg1))
                    end

                    return nil
                end,
                selectTier = function(intendedTier: string): boolean
                    if not isCurrent(nil) or var3(false).lock ~= nil or intendedTier ~= "default" and intendedTier ~= "advanced" then
                        return false
                    end
                    var4({ intendedTier = intendedTier })
                    bool1 = true
                    return true
                end,
                restoreTier = function(intendedTier: string): boolean
                    if not isCurrent(nil) or bool1 or intendedTier ~= "default" and intendedTier ~= "advanced" then
                        return false
                    end

                    bool1 = true
                    local var7 = table.clone(var3(false))
                    var7.intendedTier = intendedTier
                    var4(var7)
                    return true
                end,
                acquireLock = function()
                    if not isCurrent(nil) or var3(false).lock ~= nil then
                        return nil
                    end
                    local lock = table.freeze({})
                    local var8 = table.clone(var3(false))
                    var8.lock = lock
                    var4(var8)
                    return lock
                end,
                releaseLock = function(lock): boolean
                    if not isCurrent(nil) or var3(false).lock == nil or var3(false).lock ~= lock then
                        return false
                    end
                    local var7 = table.clone(var3(false))
                    var7.lock = nil
                    var4(var7)
                    return true
                end
            }
        }
    end

    local function discardDraft(identity: string): boolean
        local var3 = var1(false)
        local var4 = var3.entries[identity]
        if var4 == nil then
            return false
        end
        if var4.retainers > 0 then
            var4.discardRequested = true
            return true
        end
        if var4.identity == identity and var4.createdUniverseId ~= nil then
            local createdUniverseId = var4.createdUniverseId
            local var5 = var1(false)
            local var6 = var5.entries[identity]
            if var6 ~= nil and not (createdUniverseId <= 0) then
                local str1 = `universe:{createdUniverseId}`
                if var6.identity ~= identity then
                    if var6.identity == str1 then
                    end
                elseif var5.entries[str1] == nil then
                    var6.identity = str1
                    var5.entries[str1] = var6
                end
            end
        end

        var3.entries[identity] = nil
        if var4.identity == identity then
            var4.invalidate()
        end
        return true
    end

    return {
        getUniverse = function(num3: number, arg1)
            local var3 = var1(arg1)

            if not isAuthenticated(var3) or num3 <= 0 then
                return nil
            end
            local str1 = `universe:{num3}`
            if var3.entries[str1] == nil then
                var3.entries[str1] = createEntry(var3, str1)
            end
            return var3.entries[str1].entry
        end,
        getDraft = function(str1: string, arg1)
            local var3 = var1(arg1).entries[str1]
            return if var3 == nil then nil else var3.entry
        end,
        createDraft = function()
            local var3 = var1(false)

            if not isAuthenticated(var3) then
                return nil
            end
            num2 += 1
            local str1 = `draft:{num2}`
            var3.entries[str1] = createEntry(var3, str1)
            return str1
        end,
        retainDraftForCreation = function(identity: string)
            local var3 = var1(false)
            local var4 = var3.entries[identity]
            if var4 == nil then
                return nil
            end
            var4.retainers += 1
            local bool1 = false
            return function(createdUniverseId: number?)
                if bool1 then
                    return
                end
                bool1 = true
                local var5 = var4
                var5.retainers -= 1
                if var1(false) ~= var3 then
                    return
                end
                if createdUniverseId ~= nil then
                    var4.createdUniverseId = createdUniverseId
                end
                if var4.retainers == 0 and var4.discardRequested then
                    discardDraft(identity)
                end
            end
        end,
        promoteDraft = function(identity: string, num3: number): boolean
            local var3 = var1(false)
            local var4 = var3.entries[identity]
            if var4 == nil or num3 <= 0 then
                return false
            end
            local str1 = `universe:{num3}`
            if var4.identity ~= identity then
                return var4.identity == str1
            end

            if var3.entries[str1] ~= nil then
                return false
            end
            var4.identity = str1
            var3.entries[str1] = var4
            return true
        end,
        discardDraft = discardDraft,
        reset = function()
            var2((createAccount()))
        end
    }
end

return createBuildModelSelectionStore
