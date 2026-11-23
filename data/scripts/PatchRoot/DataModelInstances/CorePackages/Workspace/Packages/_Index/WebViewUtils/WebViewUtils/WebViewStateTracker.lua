-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local var1 = nil
local var2 = nil

local isOpen = false

local getWebViewMetadata = nil

local function defaultClock(): number
    return os.clock()
end

function module._setClockForTesting(func1: (...any) -> (...any))
    defaultClock = func1
end

function module.markClosed()
    if isOpen or var1 == nil then
        var1 = defaultClock()
    end
    isOpen = false
    getWebViewMetadata = nil
end

function module.updateMetadata(url: string, title: string?, isVisible: boolean?, hasBackButton: boolean?)
    getWebViewMetadata = {
        url = url,
        title = title,
        isVisible = isVisible,
        hasBackButton = hasBackButton
    }
end

function module.markOpen(url: string, title: string?, isVisible: boolean?, hasBackButton: boolean?)
    if not isOpen or var2 == nil then
        var2 = defaultClock()
    end
    isOpen = true
    module.updateMetadata(url, title, isVisible, hasBackButton)
end

function module.isOpen()
    return isOpen
end

function module.wasLastClosed()
    return if var1 == nil then -1 else defaultClock() - var1
end

function module.getOpenDuration()
    return if var2 == nil then -1 else defaultClock() - var2
end

function module.wasClosedWithin(num1: number): boolean
    return not (var1 == nil) and defaultClock() - var1 <= num1
end

function module.isOpenNoLongerThan(bool2: boolean, num1: number): boolean
    if bool2 then
        if var2 == nil or isOpen and num1 <= defaultClock() - var2 then
            return false
        end

        return isOpen
    end

    return isOpen
end

function module.getWebViewMetadata()
    return getWebViewMetadata
end

return module
