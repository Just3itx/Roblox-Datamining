-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)
local Signal = require(AppChatParent.AppCommonLib).Signal

local ArraySet = require(AppChat.DataStructures).ArraySet

local function createSelectedUsersStore()
    local getMaxSize, var2 = Signals.createSignal(0)

    local var3, var4 = Signals.createSignal(ArraySet.new({}))

    local computed = Signals.createComputed(function(arg1): boolean
        local var5 = var3(arg1)
        return getMaxSize(arg1) > var5:size()
    end)

    local getSelectedUserIdsCount = Signals.createComputed(function(arg1)
        return var3(arg1):size()
    end)

    local getSelectedUserIdsArray = Signals.createComputed(function(arg1)
        return var3(arg1):toArray()
    end)

    local signal = Signal.new()

    local tbl1 = ({})

    local tbl2 = ({})

    local function emitMaxSizeExceeded() -- Luacid: Inlined by compiler; 1 call site recovered
        signal:fire()
    end

    local function addUserId(str1: string): boolean
        if var3(false):has(str1) then
            return true
        elseif not computed(false) then
            emitMaxSizeExceeded()
            return false
        else
            var4(function(arg1)
                local argClone = arg1:clone()
                argClone:add(str1)
                return argClone
            end)

            return true
        end
    end
    local function removeUserId(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        var4(function(arg1)
            if not arg1:has(str1) then
                return arg1
            end

            local argClone = arg1:clone()
            argClone:remove(str1)
            return argClone
        end)
    end

    return {
        setMaxSize = function(num1: number)
            var2(function(_)
                return num1
            end)
        end,
        getSelectedUserIdsCount = function()
            return getSelectedUserIdsCount
        end,
        getSelectedUserIdAtIndex = function(num1: number)
            if not tbl1[num1] then
                tbl1[num1] = Signals.createComputed(function(arg1)
                    return var3(arg1):at(num1)
                end)
            end
            return tbl1[num1]
        end,
        getIsUserSelected = function(str1: string)
            if not tbl2[str1] then
                tbl2[str1] = Signals.createComputed(function(arg1)
                    return var3(arg1):has(str1)
                end)
            end
            return tbl2[str1]
        end,
        getMaxSize = function()
            return getMaxSize
        end,
        getSelectedUserIdsArray = function()
            return getSelectedUserIdsArray
        end,
        addUserId = addUserId,
        removeUserId = removeUserId,
        toggleUserId = function(str1: string)
            if not var3(false):has(str1) then
                return (addUserId(str1))
            end

            removeUserId(str1)
            return true
        end,
        clearStore = function()
            signal = Signal.new()
            tbl1 = {}
            tbl2 = {}
            var4(function(_)
                return ArraySet.new({})
            end)
        end,
        onMaxSizeExceeded = function(func1: (...any) -> (...any))
            local connection = signal:connect(func1)

            return function()
                connection:disconnect()
            end
        end,
        hasUserId = function(str1: string)
            return var3(false):has(str1)
        end,
        getCount = function()
            return var3(false):size()
        end
    }
end
return createSelectedUsersStore
