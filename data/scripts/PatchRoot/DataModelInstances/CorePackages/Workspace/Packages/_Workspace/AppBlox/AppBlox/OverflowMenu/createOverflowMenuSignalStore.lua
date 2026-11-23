-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Signals = require(AppBloxParent.Signals)

local function createOverflowMenuSignalStore()
    local getActiveMenuKey, var2 = Signals.createSignal(nil)

    local function getIsMenuOpen(str1: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        return getActiveMenuKey(false) == str1
    end

    local function openMenu(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        var2(str1)
    end

    local function closeMenu(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        if getIsMenuOpen(str1) then
            var2(nil)
        end
    end

    return {
        getActiveMenuKey = getActiveMenuKey,
        getIsMenuOpen = getIsMenuOpen,
        openMenu = openMenu,
        closeMenu = closeMenu,
        toggleMenu = function(str1: string)
            if getIsMenuOpen(str1) then
                closeMenu(str1)
                return
            end

            openMenu(str1)
        end
    }
end
return createOverflowMenuSignalStore
