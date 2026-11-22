-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent

local createSignal = require(SocialCarouselParent.Signals).createSignal

local function createMarqueeSessionStore()
    local getLoopsRemaining, var2 = createSignal({})
    local getHomeFocusVersion, var4 = createSignal(0)
    local getCurrentScroll = nil
    local getHeldScroll = nil
    local isScrollHeld = false
    local num1 = 0

    local function discardHeldScroll() -- Luacid: Inlined by compiler; 1 call site recovered
        isScrollHeld = false
        getHeldScroll = nil
    end

    return {
        getLoopsRemaining = getLoopsRemaining,
        getHomeFocusVersion = getHomeFocusVersion,
        notifyHomeFocused = function()
            var4(getHomeFocusVersion(false) + 1)
        end,
        reset = function()
            var2({})
            getCurrentScroll = nil
            discardHeldScroll()
        end,
        setCurrentScroll = function(tileId: string, offset: number)
            getCurrentScroll = { tileId = tileId, offset = offset }

            if isScrollHeld then
                getHeldScroll = getCurrentScroll
            end
        end,
        getCurrentScroll = function()
            return getCurrentScroll
        end,
        clearCurrentScroll = function(tileId: string)
            if getCurrentScroll ~= nil and getCurrentScroll.tileId == tileId then
                getCurrentScroll = nil
            end
            if getHeldScroll ~= nil and getHeldScroll.tileId == tileId then
                getHeldScroll = nil
            end
        end,
        holdCurrentScroll = function()
            isScrollHeld = true
            if getCurrentScroll ~= nil then
                getHeldScroll = getCurrentScroll
            end
        end,
        getHeldScroll = function()
            return getHeldScroll
        end,
        discardHeldScroll = discardHeldScroll,
        isScrollHeld = function()
            return isScrollHeld
        end,
        beginMount = function(): number
            num1 += 1
            return num1
        end,
        isCurrentMount = function(num2: number): boolean
            return num1 == num2
        end
    }
end

return createMarqueeSessionStore
